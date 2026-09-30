import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:isar_plus/isar_plus.dart';

import '../../features/expenses/models/expense_model.dart';
import '../../features/investments/models/investment_model.dart';
import '../../features/loans/models/loan_model.dart';
import '../../features/accounts/models/account_model.dart';
import 'package:fiscora/core/sync/collections/conflict_record.dart';
import 'package:fiscora/core/sync/collections/expense_collection.dart';
import 'package:fiscora/core/sync/collections/loan_collection.dart';
import 'package:fiscora/core/sync/collections/investment_collection.dart';
import 'package:fiscora/core/sync/collections/budget_collection.dart';
import 'package:fiscora/core/sync/collections/category_rule_collection.dart';
import 'package:fiscora/core/sync/collections/category_collection.dart';
import 'package:fiscora/core/sync/collections/account_collection.dart';
import 'package:fiscora/core/sync/conflict_resolver.dart';
import 'package:fiscora/core/sync/isar_database.dart';
import 'package:fiscora/core/sync/outbox_operation.dart';
import 'package:fiscora/core/sync/sync_api_client.dart';
import 'package:fiscora/core/sync/sync_metadata.dart';
import 'package:fiscora/core/sync/sync_state.dart';

class SyncEngine {
  static SyncEngine? _instance;
  final SyncApiClient _apiClient;
  bool _isSyncing = false;
  Timer? _debounceTimer;

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

  bool _wasOffline = false;

  void _startListeningToConnectivity() {
    Connectivity().onConnectivityChanged.listen((results) {
      // connectivity_plus v6 onConnectivityChanged returns a List<ConnectivityResult>
      // Check if there is any active non-none connection
      final hasConnection = results.any((result) => result != ConnectivityResult.none);
      if (hasConnection && _wasOffline) {
        _wasOffline = false;
        triggerSync(immediate: false);
      } else if (!hasConnection) {
        _wasOffline = true;
      }
    });
  }

  void triggerSync({bool immediate = false}) {
    if (immediate) {
      _debounceTimer?.cancel();
      _executeSync();
      return;
    }

    // Debounce triggers by 3 seconds to batch rapid local database mutations (e.g. bulk SMS imports)
    // and minimize redundant serverless invocations.
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 3), () {
      _executeSync();
    });
  }

  Completer<bool>? _currentSync;

  Future<void> _executeSync() async {
    if (_isSyncing) return;
    await _runExclusive(forcePull: false);
  }

  /// Runs one push + full pull and completes when local data is up to date
  /// with the server. Callers that must not act on stale local data (e.g. the
  /// SMS scan after a reinstall) await this. Returns false if the server
  /// could not be reached.
  Future<bool> syncNow() async {
    _debounceTimer?.cancel();
    // Let an in-flight cycle finish, then run a forced one so nothing is throttled.
    if (_currentSync != null) {
      await _currentSync!.future;
    }
    return _runExclusive(forcePull: true);
  }

  /// Local changes not yet accepted by the server.
  Future<int> pendingOutboxCount() async {
    return IsarDatabase.instance.isar.outboxOperations.where().count();
  }

  Future<bool> _runExclusive({required bool forcePull}) async {
    if (_currentSync != null) return _currentSync!.future;
    final completer = Completer<bool>();
    _currentSync = completer;
    _isSyncing = true;
    var ok = true;
    try {
      ok = await runSyncCycle(forcePull: forcePull);
    } catch (e) {
      print('SyncEngine: Error in sync cycle: $e');
      ok = false;
    } finally {
      _isSyncing = false;
      _currentSync = null;
      completer.complete(ok);
    }
    return ok;
  }

  /// Returns false if any pull failed (e.g. offline).
  Future<bool> runSyncCycle({bool forcePull = false}) async {
    bool hasPendingWork = true;
    int maxCycles = 5;
    int cycles = 0;
    var allPullsOk = true;

    while (hasPendingWork && cycles < maxCycles) {
      cycles++;
      final pushedCount = await pushPendingOutbox();
      final pull = await _pullAll(force: forcePull || cycles > 1);
      allPullsOk = allPullsOk && pull.ok;
      hasPendingWork = pushedCount > 0 || pull.count > 0;
    }
    return allPullsOk;
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
              final serverId = result['serverId'] as String?;
              final serverVersion = result['serverVersion'] as int?;
              final serverUpdatedAtStr = result['serverUpdatedAt'] as String?;

              if (serverId == null || serverVersion == null || serverUpdatedAtStr == null) {
                print('SyncEngine Warning: server response for clientId=${op.clientId} applied but missing server info. '
                    'serverId=$serverId, version=$serverVersion, updatedAt=$serverUpdatedAtStr');
                op.outboxStatus = OutboxStatus.failed.name;
                op.attemptCount++;
                op.lastAttemptAt = DateTime.now().toUtc();
                op.nextRetryAt = _calculateNextRetryAt(op.attemptCount);
                isar.outboxOperations.put(op);
                continue;
              }

              // Apply server versioning to local record
              _updateLocalMetadata(
                entityType,
                op.clientId,
                serverId: serverId,
                serverVersion: serverVersion,
                serverUpdatedAt: DateTime.parse(serverUpdatedAtStr),
              );

              // The server already had this record (e.g. re-import after a
              // reinstall). Its copy wins; a deleted one stays deleted.
              if (result['isDeleted'] == true) {
                _applyTombstone(entityType, op.clientId);
              } else if (result['serverPayload'] is Map) {
                _applyServerRecord(entityType, {
                  'id': serverId,
                  'clientId': op.clientId,
                  'version': serverVersion,
                  'updatedAt': serverUpdatedAtStr,
                  'payload': Map<String, dynamic>.from(result['serverPayload'] as Map),
                }, forceRemote: true);
              }

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

  // Accounts first: pulled expenses reference them.
  static const _pullOrder = [
    'account',
    'category',
    'expense',
    'loan',
    'investment',
    'budget',
    'category_rule',
  ];

  // Pull all entities from server
  Future<int> pullAllEntities({bool force = false}) async {
    return (await _pullAll(force: force)).count;
  }

  Future<({int count, bool ok})> _pullAll({bool force = false}) async {
    int totalPulled = 0;
    var ok = true;
    for (final entity in _pullOrder) {
      final res = await _pullEntityPages(entity, force: force);
      totalPulled += res.count;
      ok = ok && res.ok;
    }
    return (count: totalPulled, ok: ok);
  }

  Future<int> pullEntity(String entityType, {bool force = false}) async {
    return (await _pullEntityPages(entityType, force: force)).count;
  }

  static const _pageSize = 200;
  static const _maxPagesPerPull = 100;

  /// Pulls every page for [entityType] until the server reports no more
  /// changes. The 30s throttle only guards the start of a pull, never the
  /// pages after it (previously it cut a fresh install off after 200 rows).
  Future<({int count, bool ok})> _pullEntityPages(String entityType, {bool force = false}) async {
    final isar = IsarDatabase.instance.isar;
    final existingState = await isar.syncStates.where().entityTypeEqualTo(entityType).findFirst();
    final state = existingState ?? (SyncState()
      ..id = isar.syncStates.autoIncrement()
      ..entityType = entityType);

    // Throttling: If we pulled this entity recently (e.g. within the last 30 seconds),
    // skip pulling it to conserve serverless execution instances, unless force is true.
    if (!force && state.lastPulledAt != null) {
      final elapsed = DateTime.now().toUtc().difference(state.lastPulledAt!);
      if (elapsed.inSeconds < 30) {
        return (count: 0, ok: true);
      }
    }

    int total = 0;
    try {
      for (var page = 0; page < _maxPagesPerPull; page++) {
        final pullResult = await _apiClient.pull(entityType, state.lastPulledCursor, limit: _pageSize);
        final records = List<Map<String, dynamic>>.from(pullResult['records'] ?? []);
        final tombstones = List<String>.from(pullResult['tombstones'] ?? []);
        final nextCursor = pullResult['nextCursor'] as String?;
        final received = records.length + tombstones.length;
        // Older servers don't send hasMore; a full page means there may be more.
        final hasMore = pullResult['hasMore'] as bool? ?? received >= _pageSize;

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
          if (received > 0) state.lastPulledCursor = nextCursor;
          state.lastPulledAt = DateTime.now().toUtc();
          isar.syncStates.put(state);
        });

        total += received;
        if (!hasMore || received == 0) break;
      }
      return (count: total, ok: true);
    } catch (e) {
      print('SyncEngine: Pull failed for $entityType: $e');
      return (count: total, ok: false);
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
      } else {
        // Keep a deleted placeholder so an SMS the user deleted on a previous
        // install is not offered again by the inbox scan.
        final placeholder = ExpenseCollection.fromDomain(
          Expense(
            id: clientId,
            amount: 0,
            category: '',
            date: DateTime.fromMillisecondsSinceEpoch(0),
            createdAt: DateTime.fromMillisecondsSinceEpoch(0),
          ),
          syncStatus: SyncStatus.synced,
          dirty: false,
          isDeleted: true,
        )..id = isar.expenseCollections.autoIncrement();
        isar.expenseCollections.put(placeholder);
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
    } else if (entityType == 'category') {
      final local = isar.categoryCollections.where().clientIdEqualTo(clientId).findFirst();
      if (local != null) {
        local.isDeleted = true;
        local.dirty = false;
        local.syncStatus = SyncStatus.synced.name;
        isar.categoryCollections.put(local);
      }
    } else if (entityType == 'account') {
      final local = isar.accountCollections.where().clientIdEqualTo(clientId).findFirst();
      if (local != null) {
        local.isDeleted = true;
        local.dirty = false;
        local.syncStatus = SyncStatus.synced.name;
        isar.accountCollections.put(local);
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

  void _applyServerRecord(String entityType, Map<String, dynamic> remote, {bool forceRemote = false}) {
    final isar = IsarDatabase.instance.isar;
    final clientId = remote['clientId'] as String?;
    final serverId = remote['id'] as String?;
    final remoteVersion = remote['version'] as int? ?? 1;
    final remoteUpdatedAtStr = remote['updatedAt'] as String?;
    final remoteIsDeleted = remote['isDeleted'] as bool? ?? false;

    if (clientId == null || serverId == null || remoteUpdatedAtStr == null) {
      print('SyncEngine Warning: skipping invalid remote record for $entityType: '
          'id=$serverId, clientId=$clientId, updatedAt=$remoteUpdatedAtStr');
      return;
    }

    final remoteUpdatedAt = DateTime.parse(remoteUpdatedAtStr);
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

      final res = _resolve(forceRemote,
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
          Expense.fromJson(converted, clientId, defaultIsCountedAsSpend: local.isCountedAsSpend),
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

      final res = _resolve(forceRemote,
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

      final res = _resolve(forceRemote,
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

      final res = _resolve(forceRemote,
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
            categoryId: remotePayload['categoryId'] as String? ?? '',
            subcategoryId: remotePayload['subcategoryId'] as String? ?? '',
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

      final res = _resolve(forceRemote,
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
          categoryId: remotePayload['categoryId'] as String? ?? '',
          subcategoryId: remotePayload['subcategoryId'] as String? ?? '',
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
    } else if (entityType == 'category') {
      final local = isar.categoryCollections.where().clientIdEqualTo(clientId).findFirst();
      if (local == null) {
        if (!remoteIsDeleted) {
          final newCol = CategoryCollection.fromSyncJson(
            clientId,
            remotePayload,
            serverId: serverId,
            serverUpdatedAt: remoteUpdatedAt,
            version: remoteVersion,
          )..id = isar.categoryCollections.autoIncrement();
          isar.categoryCollections.put(newCol);
        }
        return;
      }

      final res = _resolve(forceRemote,
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
        final updatedCol = CategoryCollection.fromSyncJson(
          clientId,
          remotePayload,
          serverId: serverId,
          serverUpdatedAt: remoteUpdatedAt,
          version: remoteVersion,
        )..id = local.id;
        isar.categoryCollections.put(updatedCol);
      } else if (res.action == ConflictResolution.delete) {
        local.isDeleted = true;
        local.dirty = false;
        local.syncStatus = SyncStatus.synced.name;
        isar.categoryCollections.put(local);
      } else if (res.action == ConflictResolution.conflict) {
        _saveConflictRecord(entityType, clientId, local.toSyncJson(), remotePayload);
        local.syncStatus = SyncStatus.conflict.name;
        isar.categoryCollections.put(local);
      }
    } else if (entityType == 'account') {
      final local = isar.accountCollections.where().clientIdEqualTo(clientId).findFirst();
      if (local == null) {
        if (!remoteIsDeleted) {
          final converted = _convertRestJsonToFirestoreJson(remotePayload, ['createdAt']);
          final newId = isar.accountCollections.autoIncrement();
          final newCol = AccountCollection.fromDomain(
            Account.fromJson(converted, clientId),
            serverId: serverId,
            serverUpdatedAt: remoteUpdatedAt,
            syncStatus: SyncStatus.synced,
            version: remoteVersion,
            dirty: false,
          )..id = newId;
          isar.accountCollections.put(newCol);
        }
        return;
      }

      final res = _resolve(forceRemote,
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
        final converted = _convertRestJsonToFirestoreJson(remotePayload, ['createdAt']);
        final updatedCol = AccountCollection.fromDomain(
          Account.fromJson(converted, clientId),
          serverId: serverId,
          serverUpdatedAt: remoteUpdatedAt,
          syncStatus: SyncStatus.synced,
          version: remoteVersion,
          dirty: false,
        )..id = local.id;
        isar.accountCollections.put(updatedCol);
      } else if (res.action == ConflictResolution.delete) {
        local.isDeleted = true;
        local.dirty = false;
        local.syncStatus = SyncStatus.synced.name;
        isar.accountCollections.put(local);
      } else if (res.action == ConflictResolution.conflict) {
        _saveConflictRecord(entityType, clientId, local.toSyncJson(), remotePayload);
        local.syncStatus = SyncStatus.conflict.name;
        isar.accountCollections.put(local);
      }
    }
  }

  ResolutionResult _resolve(
    bool forceRemote, {
    required String entityType,
    required bool localIsDirty,
    required int localVersion,
    required DateTime localUpdatedAt,
    required bool localIsDeleted,
    required int remoteVersion,
    required DateTime remoteUpdatedAt,
    required bool remoteIsDeleted,
    required Map<String, dynamic> localPayload,
    required Map<String, dynamic> remotePayload,
  }) {
    if (forceRemote) return ResolutionResult(ConflictResolution.useRemote);
    return ConflictResolver.resolve(
      entityType: entityType,
      localIsDirty: localIsDirty,
      localVersion: localVersion,
      localUpdatedAt: localUpdatedAt,
      localIsDeleted: localIsDeleted,
      remoteVersion: remoteVersion,
      remoteUpdatedAt: remoteUpdatedAt,
      remoteIsDeleted: remoteIsDeleted,
      localPayload: localPayload,
      remotePayload: remotePayload,
    );
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
    } else if (entityType == 'category') {
      final res = isar.categoryCollections.where().clientIdEqualTo(clientId).findFirst();
      return res?.version ?? 1;
    } else if (entityType == 'account') {
      final res = isar.accountCollections.where().clientIdEqualTo(clientId).findFirst();
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
    } else if (entityType == 'category') {
      final res = isar.categoryCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.serverId = serverId;
        res.version = serverVersion;
        res.serverUpdatedAt = serverUpdatedAt;
        res.syncStatus = SyncStatus.synced.name;
        res.dirty = false;
        isar.categoryCollections.put(res);
      }
    } else if (entityType == 'account') {
      final res = isar.accountCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.serverId = serverId;
        res.version = serverVersion;
        res.serverUpdatedAt = serverUpdatedAt;
        res.syncStatus = SyncStatus.synced.name;
        res.dirty = false;
        isar.accountCollections.put(res);
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
    } else if (entityType == 'category') {
      final res = isar.categoryCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.syncStatus = SyncStatus.conflict.name;
        isar.categoryCollections.put(res);
        _saveConflictRecord(entityType, clientId, res.toSyncJson(), remotePayload);
      }
    } else if (entityType == 'account') {
      final res = isar.accountCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.syncStatus = SyncStatus.conflict.name;
        isar.accountCollections.put(res);
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
    } else if (entityType == 'category') {
      final res = isar.categoryCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.syncStatus = SyncStatus.failed.name;
        isar.categoryCollections.put(res);
      }
    } else if (entityType == 'account') {
      final res = isar.accountCollections.where().clientIdEqualTo(clientId).findFirst();
      if (res != null) {
        res.syncStatus = SyncStatus.failed.name;
        isar.accountCollections.put(res);
      }
    }
  }
}
