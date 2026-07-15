import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:isar_plus/isar_plus.dart';

import '../../features/expenses/models/expense_model.dart';
import '../../features/investments/models/investment_model.dart';
import '../../features/loans/models/loan_model.dart';
import 'package:spendly/core/sync/collections/conflict_record.dart';
import 'package:spendly/core/sync/collections/expense_collection.dart';
import 'package:spendly/core/sync/collections/loan_collection.dart';
import 'package:spendly/core/sync/collections/investment_collection.dart';
import 'package:spendly/core/sync/collections/budget_collection.dart';
import 'package:spendly/core/sync/collections/category_rule_collection.dart';
import 'package:spendly/core/sync/conflict_resolver.dart';
import 'package:spendly/core/sync/isar_database.dart';
import 'package:spendly/core/sync/outbox_operation.dart';
import 'package:spendly/core/sync/sync_api_client.dart';
import 'package:spendly/core/sync/sync_metadata.dart';
import 'package:spendly/core/sync/sync_state.dart';

class SyncEngine {
  static SyncEngine? _instance;
  final SyncApiClient _apiClient;
  bool _isSyncing = false;

  SyncEngine._(this._apiClient);

  static SyncEngine get instance {
    if (_instance == null) {
      throw StateError('SyncEngine has not been initialized. Call init() first.');
    }
    return _instance!;
  }

  static void init(SyncApiClient apiClient) {
    if (_instance != null) return;
    _instance = SyncEngine._(apiClient);
    _instance!._startListeningToConnectivity();
  }

  void _startListeningToConnectivity() {
    Connectivity().onConnectivityChanged.listen((results) {
      // connectivity_plus v6 onConnectivityChanged returns a List<ConnectivityResult>
      // Check if there is any active non-none connection
      final hasConnection = results.any((result) => result != ConnectivityResult.none);
      if (hasConnection) {
        triggerSync();
      }
    });
  }

  Future<void> triggerSync() async {
    if (_isSyncing) return;
    _isSyncing = true;
    try {
      await runSyncCycle();
    } catch (e) {
      print('SyncEngine: Error in sync cycle: $e');
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> runSyncCycle() async {
    bool hasPendingWork = true;
    int maxCycles = 5;
    int cycles = 0;

    while (hasPendingWork && cycles < maxCycles) {
      cycles++;
      final pushedCount = await pushPendingOutbox();
      final pulledCount = await pullAllEntities();
      hasPendingWork = pushedCount > 0 || pulledCount > 0;
    }
  }

  // Transactionally enqueues an operation to the outbox queue
  static void enqueue({
    required Isar isar,
    required String entityType,
    required String clientId,
    required String operationType,
    required Map<String, dynamic> payload,
  }) {
    final newId = isar.outboxOperations.autoIncrement();
    final op = OutboxOperation(
      id: newId,
      entityType: entityType,
      clientId: clientId,
      operationType: operationType,
      payloadJson: jsonEncode(payload),
      createdAt: DateTime.now().toUtc(),
      attemptCount: 0,
      lastAttemptAt: DateTime.fromMillisecondsSinceEpoch(0).toUtc(),
      nextRetryAt: DateTime.now().toUtc(),
      outboxStatus: OutboxStatus.queued.name,
    );

    isar.outboxOperations.put(op);
  }

  DateTime _calculateNextRetryAt(int attemptCount) {
    const base = 2; // base delay in seconds
    const maxDelay = 300; // cap at 5 minutes
    final delaySecs = (base * (1 << attemptCount)).clamp(base, maxDelay);
    final jitter = DateTime.now().millisecond % 5;
    return DateTime.now().toUtc().add(Duration(seconds: delaySecs + jitter));
  }

  // Push pending outbox mutations in FIFO order per entity type
  Future<int> pushPendingOutbox() async {
    final isar = IsarDatabase.instance.isar;
    final now = DateTime.now().toUtc();
    
    // Find all queued or failed operations where nextRetryAt <= now
    final ops = await isar.outboxOperations
        .where()
        .outboxStatusEqualTo(OutboxStatus.queued.name)
        .or()
        .outboxStatusEqualTo(OutboxStatus.failed.name)
        .and()
        .nextRetryAtLessThan(now)
        .sortByCreatedAt()
        .findAll();

    if (ops.isEmpty) return 0;

    // Group operations by entity type to batch them
    final groupedOps = <String, List<OutboxOperation>>{};
    for (final op in ops) {
      groupedOps.putIfAbsent(op.entityType, () => []).add(op);
    }

    int processedCount = 0;
    for (final entry in groupedOps.entries) {
      final entityType = entry.key;
      final batch = entry.value;

      // Set status to inFlight
      isar.write((isar) {
        for (final op in batch) {
          op.outboxStatus = OutboxStatus.inFlight.name;
          isar.outboxOperations.put(op);
        }
      });

      // Prepare API batch payload
      final pushPayloads = <Map<String, dynamic>>[];
      for (final op in batch) {
        // Fetch local version from collection to send to the server
        final version = await _getLocalVersion(entityType, op.clientId);
        pushPayloads.add({
          'clientId': op.clientId,
          'operationType': op.operationType.toUpperCase(), // CREATE, UPDATE, DELETE
          'payload': op.operationType == 'delete' ? {} : jsonDecode(op.payloadJson),
          'clientVersion': version,
        });
      }

      try {
        final results = await _apiClient.pushBatch(entityType, pushPayloads);
        
        isar.write((isar) {
          for (int i = 0; i < batch.length; i++) {
            final op = batch[i];
            final result = results.firstWhere(
              (r) => r['clientId'] == op.clientId,
              orElse: () => <String, dynamic>{},
            );

            if (result.isEmpty) {
              // Operation missing from result, retry later
              op.outboxStatus = OutboxStatus.failed.name;
              op.attemptCount++;
              op.lastAttemptAt = DateTime.now().toUtc();
              op.nextRetryAt = _calculateNextRetryAt(op.attemptCount);
              isar.outboxOperations.put(op);
              continue;
            }

            final status = result['status'] as String? ?? 'rejected';
            if (status == 'applied') {
              // Apply server versioning to local record
              _updateLocalMetadata(
                entityType,
                op.clientId,
                serverId: result['serverId'] as String,
                serverVersion: result['serverVersion'] as int,
                serverUpdatedAt: DateTime.parse(result['serverUpdatedAt'] as String),
              );

              // Delete outbox operation upon success
              isar.outboxOperations.delete(op.id);
              processedCount++;
            } else if (status == 'conflict') {
              // Flag conflict state locally
              _flagLocalConflict(entityType, op.clientId, result['remotePayload'] as Map<String, dynamic>? ?? {});
              isar.outboxOperations.delete(op.id); // Conflict stops outbox retries (resolved manually)
              processedCount++;
            } else {
              // Validation rejected or failed permanently
              _flagLocalFailed(entityType, op.clientId);
              isar.outboxOperations.delete(op.id); // Permanently drop outbox operation
              processedCount++;
            }
          }
        });
      } catch (e) {
        print('SyncEngine: Batch push failed for $entityType: $e');
        // Reset in-flight batch back to failed with exponential backoff
        isar.write((isar) {
          for (final op in batch) {
            op.outboxStatus = OutboxStatus.failed.name;
            op.attemptCount++;
            op.lastAttemptAt = DateTime.now().toUtc();
            op.nextRetryAt = _calculateNextRetryAt(op.attemptCount);
            isar.outboxOperations.put(op);
          }
        });
      }
    }
    return processedCount;
  }

  // Pull all entities from server
  Future<int> pullAllEntities() async {
    final entities = ['expense', 'loan', 'investment', 'budget', 'category_rule'];
    int totalPulled = 0;
    for (final entity in entities) {
      totalPulled += await pullEntity(entity);
    }
    return totalPulled;
  }

  Future<int> pullEntity(String entityType) async {
    final isar = IsarDatabase.instance.isar;
    final existingState = await isar.syncStates.where().entityTypeEqualTo(entityType).findFirst();
    final state = existingState ?? (SyncState()
      ..id = isar.syncStates.autoIncrement()
      ..entityType = entityType);

    try {
      final pullResult = await _apiClient.pull(entityType, state.lastPulledCursor);
      final records = List<Map<String, dynamic>>.from(pullResult['records'] ?? []);
      final tombstones = List<String>.from(pullResult['tombstones'] ?? []);
      final nextCursor = pullResult['nextCursor'] as String?;

      if (records.isEmpty && tombstones.isEmpty) return 0;

      isar.write((isar) {
        // 1. Process deletions
        for (final tombstoneId in tombstones) {
          _applyTombstone(entityType, tombstoneId);
        }

        // 2. Process updates / conflict resolution
        for (final record in records) {
          _applyServerRecord(entityType, record);
        }

        // 3. Save sync cursor
        state.lastPulledCursor = nextCursor;
        state.lastPulledAt = DateTime.now().toUtc();
        isar.syncStates.put(state);
      });

      return records.length + tombstones.length;
    } catch (e) {
      print('SyncEngine: Pull failed for $entityType: $e');
      return 0;
    }
  }

  void _applyTombstone(String entityType, String clientId) {
    final isar = IsarDatabase.instance.isar;
    if (entityType == 'expense') {
      final local = isar.expenseCollections.where().clientIdEqualTo(clientId).findFirst();
      if (local != null) {
        local.isDeleted = true;
        local.dirty = false;
        local.syncStatus = SyncStatus.synced.name;
        isar.expenseCollections.put(local);
      }
    } else if (entityType == 'loan') {
      final local = isar.loanCollections.where().clientIdEqualTo(clientId).findFirst();
      if (local != null) {
        local.isDeleted = true;
        local.dirty = false;
        local.syncStatus = SyncStatus.synced.name;
        isar.loanCollections.put(local);
      }
    } else if (entityType == 'investment') {
      final local = isar.investmentCollections.where().clientIdEqualTo(clientId).findFirst();
      if (local != null) {
        local.isDeleted = true;
        local.dirty = false;
        local.syncStatus = SyncStatus.synced.name;
        isar.investmentCollections.put(local);
      }
    } else if (entityType == 'budget') {
      final local = isar.budgetCollections.where().clientIdEqualTo(clientId).findFirst();
      if (local != null) {
        local.isDeleted = true;
        local.dirty = false;
        local.syncStatus = SyncStatus.synced.name;
        isar.budgetCollections.put(local);
      }
    } else if (entityType == 'category_rule') {
      final local = isar.categoryRuleCollections.where().clientIdEqualTo(clientId).findFirst();
      if (local != null) {
        local.isDeleted = true;
        local.dirty = false;
        local.syncStatus = SyncStatus.synced.name;
        isar.categoryRuleCollections.put(local);
      }
    }
  }

  Map<String, dynamic> _convertRestJsonToFirestoreJson(Map<String, dynamic> map, List<String> dateKeys) {
    final newMap = Map<String, dynamic>.from(map);
    for (final key in dateKeys) {
      final val = newMap[key];
      if (val is String) {
        newMap[key] = Timestamp.fromDate(DateTime.parse(val));
      }
    }
    return newMap;
  }

  void _applyServerRecord(String entityType, Map<String, dynamic> remote) {
    final isar = IsarDatabase.instance.isar;
    final clientId = remote['clientId'] as String;
    final serverId = remote['id'] as String;
    final remoteVersion = remote['version'] as int? ?? 1;
    final remoteUpdatedAt = DateTime.parse(remote['updatedAt'] as String);
    final remoteIsDeleted = remote['isDeleted'] as bool? ?? false;
    final remotePayload = Map<String, dynamic>.from(remote['payload'] ?? remote);

    if (entityType == 'expense') {
      final local = isar.expenseCollections.where().clientIdEqualTo(clientId).findFirst();
      if (local == null) {
        if (!remoteIsDeleted) {
          final converted = _convertRestJsonToFirestoreJson(remotePayload, ['date', 'createdAt']);
          final newId = isar.expenseCollections.autoIncrement();
          final newCol = ExpenseCollection.fromDomain(
            Expense.fromJson(converted, clientId),
            serverId: serverId,
            serverUpdatedAt: remoteUpdatedAt,
            syncStatus: SyncStatus.synced,
            version: remoteVersion,
            dirty: false,
          )..id = newId;
          isar.expenseCollections.put(newCol);
        }
        return;
      }

      final res = ConflictResolver.resolve(
        entityType: entityType,
        localIsDirty: local.dirty,
        localVersion: local.version,
        localUpdatedAt: local.updatedAt,
        localIsDeleted: local.isDeleted,
        remoteVersion: remoteVersion,
        remoteUpdatedAt: remoteUpdatedAt,
        remoteIsDeleted: remoteIsDeleted,
        localPayload: local.toSyncJson(),
        remotePayload: remotePayload,
      );

      if (res.action == ConflictResolution.useRemote) {
        final converted = _convertRestJsonToFirestoreJson(remotePayload, ['date', 'createdAt']);
        final updatedCol = ExpenseCollection.fromDomain(
          Expense.fromJson(converted, clientId),
          serverId: serverId,
          serverUpdatedAt: remoteUpdatedAt,
          syncStatus: SyncStatus.synced,
          version: remoteVersion,
          dirty: false,
        )..id = local.id;
        isar.expenseCollections.put(updatedCol);
      } else if (res.action == ConflictResolution.delete) {
        local.isDeleted = true;
        local.dirty = false;
        local.syncStatus = SyncStatus.synced.name;
        isar.expenseCollections.put(local);
      } else if (res.action == ConflictResolution.conflict) {
        _saveConflictRecord(entityType, clientId, local.toSyncJson(), remotePayload);
        local.syncStatus = SyncStatus.conflict.name;
        isar.expenseCollections.put(local);
      }
    } else if (entityType == 'loan') {
      final local = isar.loanCollections.where().clientIdEqualTo(clientId).findFirst();
      if (local == null) {
        if (!remoteIsDeleted) {
          final converted = _convertRestJsonToFirestoreJson(remotePayload, ['repaymentDate', 'createdAt']);
          final newId = isar.loanCollections.autoIncrement();
          final newCol = LoanCollection.fromDomain(
            Loan.fromJson(converted, clientId),
            serverId: serverId,
            serverUpdatedAt: remoteUpdatedAt,
            syncStatus: SyncStatus.synced,
            version: remoteVersion,
            dirty: false,
          )..id = newId;
          isar.loanCollections.put(newCol);
        }
        return;
      }

      final res = ConflictResolver.resolve(
        entityType: entityType,
        localIsDirty: local.dirty,
        localVersion: local.version,
        localUpdatedAt: local.updatedAt,
        localIsDeleted: local.isDeleted,
        remoteVersion: remoteVersion,
        remoteUpdatedAt: remoteUpdatedAt,
        remoteIsDeleted: remoteIsDeleted,
        localPayload: local.toSyncJson(),
        remotePayload: remotePayload,
      );

      if (res.action == ConflictResolution.useRemote) {
        final converted = _convertRestJsonToFirestoreJson(remotePayload, ['repaymentDate', 'createdAt']);
        final updatedCol = LoanCollection.fromDomain(
          Loan.fromJson(converted, clientId),
          serverId: serverId,
          serverUpdatedAt: remoteUpdatedAt,
          syncStatus: SyncStatus.synced,
          version: remoteVersion,
          dirty: false,
        )..id = local.id;
        isar.loanCollections.put(updatedCol);
      } else if (res.action == ConflictResolution.delete) {
        local.isDeleted = true;
        local.dirty = false;
        local.syncStatus = SyncStatus.synced.name;
        isar.loanCollections.put(local);
      } else if (res.action == ConflictResolution.conflict) {
        _saveConflictRecord(entityType, clientId, local.toSyncJson(), remotePayload);
        local.syncStatus = SyncStatus.conflict.name;
        isar.loanCollections.put(local);
      }
    } else if (entityType == 'investment') {
      final local = isar.investmentCollections.where().clientIdEqualTo(clientId).findFirst();
      if (local == null) {
        if (!remoteIsDeleted) {
          final converted = _convertRestJsonToFirestoreJson(remotePayload, ['startDate', 'maturityDate']);
          final newId = isar.investmentCollections.autoIncrement();
          final newCol = InvestmentCollection.fromDomain(
            Investment.fromJson(converted, clientId),
            serverId: serverId,
            serverUpdatedAt: remoteUpdatedAt,
            syncStatus: SyncStatus.synced,
            version: remoteVersion,
            dirty: false,
          )..id = newId;
          isar.investmentCollections.put(newCol);
        }
        return;
      }

      final res = ConflictResolver.resolve(
        entityType: entityType,
        localIsDirty: local.dirty,
        localVersion: local.version,
        localUpdatedAt: local.updatedAt,
        localIsDeleted: local.isDeleted,
        remoteVersion: remoteVersion,
        remoteUpdatedAt: remoteUpdatedAt,
        remoteIsDeleted: remoteIsDeleted,
        localPayload: local.toSyncJson(),
        remotePayload: remotePayload,
      );

      if (res.action == ConflictResolution.useRemote) {
        final converted = _convertRestJsonToFirestoreJson(remotePayload, ['startDate', 'maturityDate']);
        final updatedCol = InvestmentCollection.fromDomain(
          Investment.fromJson(converted, clientId),
          serverId: serverId,
          serverUpdatedAt: remoteUpdatedAt,
          syncStatus: SyncStatus.synced,
          version: remoteVersion,
          dirty: false,
        )..id = local.id;
        isar.investmentCollections.put(updatedCol);
      } else if (res.action == ConflictResolution.delete) {
        local.isDeleted = true;
        local.dirty = false;
        local.syncStatus = SyncStatus.synced.name;
        isar.investmentCollections.put(local);
      } else if (res.action == ConflictResolution.conflict) {
        _saveConflictRecord(entityType, clientId, local.toSyncJson(), remotePayload);
        local.syncStatus = SyncStatus.conflict.name;
        isar.investmentCollections.put(local);
      }
    } else if (entityType == 'budget') {
      final local = isar.budgetCollections.where().clientIdEqualTo(clientId).findFirst();
      if (local == null) {
        if (!remoteIsDeleted) {
          final newId = isar.budgetCollections.autoIncrement();
          final newCol = BudgetCollection.create(
            clientId: clientId,
            month: remotePayload['month'] as String? ?? '',
            category: remotePayload['category'] as String? ?? 'Other',
            amountLimit: (remotePayload['limit'] as num? ?? 0.0).toDouble(),
            serverId: serverId,
            serverUpdatedAt: remoteUpdatedAt,
            syncStatus: SyncStatus.synced,
            version: remoteVersion,
            dirty: false,
          )..id = newId;
          isar.budgetCollections.put(newCol);
        }
        return;
      }

      final res = ConflictResolver.resolve(
        entityType: entityType,
        localIsDirty: local.dirty,
        localVersion: local.version,
        localUpdatedAt: local.updatedAt,
        localIsDeleted: local.isDeleted,
        remoteVersion: remoteVersion,
        remoteUpdatedAt: remoteUpdatedAt,
        remoteIsDeleted: remoteIsDeleted,
        localPayload: local.toSyncJson(),
        remotePayload: remotePayload,
      );

      if (res.action == ConflictResolution.useRemote) {
        final updatedCol = BudgetCollection.create(
          clientId: clientId,
          month: remotePayload['month'] as String? ?? '',
          category: remotePayload['category'] as String? ?? 'Other',
          amountLimit: (remotePayload['limit'] as num? ?? 0.0).toDouble(),
          serverId: serverId,
          serverUpdatedAt: remoteUpdatedAt,
          syncStatus: SyncStatus.synced,
          version: remoteVersion,
          dirty: false,
        )..id = local.id;
        isar.budgetCollections.put(updatedCol);
      } else if (res.action == ConflictResolution.delete) {
        local.isDeleted = true;
        local.dirty = false;
        local.syncStatus = SyncStatus.synced.name;
        isar.budgetCollections.put(local);
      } else if (res.action == ConflictResolution.conflict) {
        _saveConflictRecord(entityType, clientId, local.toSyncJson(), remotePayload);
        local.syncStatus = SyncStatus.conflict.name;
        isar.budgetCollections.put(local);
      }
    } else if (entityType == 'category_rule') {
      final local = isar.categoryRuleCollections.where().clientIdEqualTo(clientId).findFirst();
      if (local == null) {
        if (!remoteIsDeleted) {
          final newId = isar.categoryRuleCollections.autoIncrement();
          final newCol = CategoryRuleCollection.create(
            clientId: clientId,
            merchant: remotePayload['merchant'] as String? ?? '',
            category: remotePayload['category'] as String? ?? 'Other',
            serverId: serverId,
            serverUpdatedAt: remoteUpdatedAt,
            syncStatus: SyncStatus.synced,
            version: remoteVersion,
            dirty: false,
          )..id = newId;
          isar.categoryRuleCollections.put(newCol);
        }
        return;
      }

      final res = ConflictResolver.resolve(
        entityType: entityType,
        localIsDirty: local.dirty,
        localVersion: local.version,
        localUpdatedAt: local.updatedAt,
        localIsDeleted: local.isDeleted,
        remoteVersion: remoteVersion,
        remoteUpdatedAt: remoteUpdatedAt,
        remoteIsDeleted: remoteIsDeleted,
        localPayload: local.toSyncJson(),
        remotePayload: remotePayload,
      );

      if (res.action == ConflictResolution.useRemote) {
        final updatedCol = CategoryRuleCollection.create(
          clientId: clientId,
          merchant: remotePayload['merchant'] as String? ?? '',
          category: remotePayload['category'] as String? ?? 'Other',
          serverId: serverId,
          serverUpdatedAt: remoteUpdatedAt,
          syncStatus: SyncStatus.synced,
          version: remoteVersion,
          dirty: false,
        )..id = local.id;
        isar.categoryRuleCollections.put(updatedCol);
      } else if (res.action == ConflictResolution.delete) {
        local.isDeleted = true;
        local.dirty = false;
        local.syncStatus = SyncStatus.synced.name;
        isar.categoryRuleCollections.put(local);
      } else if (res.action == ConflictResolution.conflict) {
        _saveConflictRecord(entityType, clientId, local.toSyncJson(), remotePayload);
        local.syncStatus = SyncStatus.conflict.name;
        isar.categoryRuleCollections.put(local);
      }
    }
  }

  void _saveConflictRecord(
    String entityType,
    String clientId,
    Map<String, dynamic> localPayload,
    Map<String, dynamic> remotePayload,
  ) {
    final isar = IsarDatabase.instance.isar;
    final newId = isar.conflictRecords.autoIncrement();
    final conf = ConflictRecord()
      ..id = newId
      ..entityType = entityType
      ..clientId = clientId
      ..localPayloadJson = jsonEncode(localPayload)
      ..serverPayloadJson = jsonEncode(remotePayload)
      ..conflictAt = DateTime.now().toUtc();
    isar.conflictRecords.put(conf);
  }

  int _getLocalVersion(String entityType, String clientId) {
    final isar = IsarDatabase.instance.isar;
    if (entityType == 'expense') {
      final res = isar.expenseCollections.where().clientIdEqualTo(clientId).findFirst();
      return res?.version ?? 1;
    } else if (entityType == 'loan') {
      final res = isar.loanCollections.where().clientIdEqualTo(clientId).findFirst();
      return res?.version ?? 1;
    } else if (entityType == 'investment') {
      final res = isar.investmentCollections.where().clientIdEqualTo(clientId).findFirst();
      return res?.version ?? 1;
    } else if (entityType == 'budget') {
      final res = isar.budgetCollections.where().clientIdEqualTo(clientId).findFirst();
      return res?.version ?? 1;
    } else if (entityType == 'category_rule') {
      final res = isar.categoryRuleCollections.where().clientIdEqualTo(clientId).findFirst();
      return res?.version ?? 1;
    }
    return 1;
  }

  void _updateLocalMetadata(
    String entityType,
    String clientId, {
    required String serverId,
    required int serverVersion,
    required DateTime serverUpdatedAt,
  }) {
    final isar = IsarDatabase.instance.isar;
    if (entityType == 'expense') {
      final res = isar.expenseCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.serverId = serverId;
        res.version = serverVersion;
        res.serverUpdatedAt = serverUpdatedAt;
        res.syncStatus = SyncStatus.synced.name;
        res.dirty = false;
        isar.expenseCollections.put(res);
      }
    } else if (entityType == 'loan') {
      final res = isar.loanCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.serverId = serverId;
        res.version = serverVersion;
        res.serverUpdatedAt = serverUpdatedAt;
        res.syncStatus = SyncStatus.synced.name;
        res.dirty = false;
        isar.loanCollections.put(res);
      }
    } else if (entityType == 'investment') {
      final res = isar.investmentCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.serverId = serverId;
        res.version = serverVersion;
        res.serverUpdatedAt = serverUpdatedAt;
        res.syncStatus = SyncStatus.synced.name;
        res.dirty = false;
        isar.investmentCollections.put(res);
      }
    } else if (entityType == 'budget') {
      final res = isar.budgetCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.serverId = serverId;
        res.version = serverVersion;
        res.serverUpdatedAt = serverUpdatedAt;
        res.syncStatus = SyncStatus.synced.name;
        res.dirty = false;
        isar.budgetCollections.put(res);
      }
    } else if (entityType == 'category_rule') {
      final res = isar.categoryRuleCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.serverId = serverId;
        res.version = serverVersion;
        res.serverUpdatedAt = serverUpdatedAt;
        res.syncStatus = SyncStatus.synced.name;
        res.dirty = false;
        isar.categoryRuleCollections.put(res);
      }
    }
  }

  void _flagLocalConflict(String entityType, String clientId, Map<String, dynamic> remotePayload) {
    final isar = IsarDatabase.instance.isar;
    if (entityType == 'expense') {
      final res = isar.expenseCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.syncStatus = SyncStatus.conflict.name;
        isar.expenseCollections.put(res);
        _saveConflictRecord(entityType, clientId, res.toSyncJson(), remotePayload);
      }
    } else if (entityType == 'loan') {
      final res = isar.loanCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.syncStatus = SyncStatus.conflict.name;
        isar.loanCollections.put(res);
        _saveConflictRecord(entityType, clientId, res.toSyncJson(), remotePayload);
      }
    } else if (entityType == 'investment') {
      final res = isar.investmentCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.syncStatus = SyncStatus.conflict.name;
        isar.investmentCollections.put(res);
        _saveConflictRecord(entityType, clientId, res.toSyncJson(), remotePayload);
      }
    } else if (entityType == 'budget') {
      final res = isar.budgetCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.syncStatus = SyncStatus.conflict.name;
        isar.budgetCollections.put(res);
        _saveConflictRecord(entityType, clientId, res.toSyncJson(), remotePayload);
      }
    } else if (entityType == 'category_rule') {
      final res = isar.categoryRuleCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.syncStatus = SyncStatus.conflict.name;
        isar.categoryRuleCollections.put(res);
        _saveConflictRecord(entityType, clientId, res.toSyncJson(), remotePayload);
      }
    }
  }

  void _flagLocalFailed(String entityType, String clientId) {
    final isar = IsarDatabase.instance.isar;
    if (entityType == 'expense') {
      final res = isar.expenseCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.syncStatus = SyncStatus.failed.name;
        isar.expenseCollections.put(res);
      }
    } else if (entityType == 'loan') {
      final res = isar.loanCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.syncStatus = SyncStatus.failed.name;
        isar.loanCollections.put(res);
      }
    } else if (entityType == 'investment') {
      final res = isar.investmentCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.syncStatus = SyncStatus.failed.name;
        isar.investmentCollections.put(res);
      }
    } else if (entityType == 'budget') {
      final res = isar.budgetCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.syncStatus = SyncStatus.failed.name;
        isar.budgetCollections.put(res);
      }
    } else if (entityType == 'category_rule') {
      final res = isar.categoryRuleCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.syncStatus = SyncStatus.failed.name;
        isar.categoryRuleCollections.put(res);
      }
    }
  }
}
