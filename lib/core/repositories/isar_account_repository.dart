import 'package:isar_plus/isar_plus.dart';
import 'package:spendly/core/sync/outbox_operation.dart';
import 'package:uuid/uuid.dart';

import 'package:spendly/features/accounts/models/account_model.dart';
import 'package:spendly/core/sync/collections/account_collection.dart';
import 'package:spendly/core/sync/isar_database.dart';
import 'package:spendly/core/sync/sync_engine.dart';
import 'package:spendly/core/sync/sync_metadata.dart';
import 'package:spendly/core/repositories/i_account_repository.dart';

class IsarAccountRepository implements IAccountRepository {
  Isar get _isar => IsarDatabase.instance.isar;
  final _uuid = const Uuid();

  @override
  Stream<List<Account>> watchAccounts() {
    return _isar.accountCollections
        .where()
        .isDeletedEqualTo(false)
        .watch(fireImmediately: true)
        .map((list) => list.where((a) => !a.isArchived).map((a) => a.toDomain()).toList());
  }

  @override
  Future<List<Account>> getAccounts() async {
    final list = _isar.accountCollections
        .where()
        .isDeletedEqualTo(false)
        .findAll();
    return list.where((a) => !a.isArchived).map((a) => a.toDomain()).toList();
  }

  @override
  Future<Account?> getAccount(String id) async {
    final col = _isar.accountCollections
        .where()
        .clientIdEqualTo(id)
        .findFirst();
    return col?.toDomain();
  }

  @override
  Future<void> addAccount(Account account) async {
    await _isar.writeAsync((isar) {
      final existing = isar.accountCollections
          .where()
          .clientIdEqualTo(account.id)
          .findFirst();
      if (existing != null) return;

      final newId = isar.accountCollections.autoIncrement();
      final col = AccountCollection.fromDomain(
        account,
        syncStatus: SyncStatus.pendingCreate,
        dirty: true,
      )..id = newId;

      isar.accountCollections.put(col);
      SyncEngine.enqueue(
        isar: isar,
        entityType: 'account',
        clientId: col.clientId,
        operationType: 'create',
        payload: col.toSyncJson(),
      );
    });

    SyncEngine.instance.triggerSync();
  }

  @override
  Future<void> updateAccount(Account account) async {
    await _isar.writeAsync((isar) {
      final existing = isar.accountCollections
          .where()
          .clientIdEqualTo(account.id)
          .findFirst();

      if (existing != null) {
        final col = AccountCollection.fromDomain(
          account,
          serverId: existing.serverId,
          serverUpdatedAt: existing.serverUpdatedAt,
          syncStatus: existing.serverId == null ? SyncStatus.pendingCreate : SyncStatus.pendingUpdate,
          version: existing.version + 1,
          dirty: true,
        )..id = existing.id;

        isar.accountCollections.put(col);
        SyncEngine.enqueue(
          isar: isar,
          entityType: 'account',
          clientId: col.clientId,
          operationType: existing.serverId == null ? 'create' : 'update',
          payload: col.toSyncJson(),
        );
      }
    });

    SyncEngine.instance.triggerSync();
  }

  @override
  Future<void> updateAccountBalance(String id, double newBalance) async {
    await _isar.writeAsync((isar) {
      final existing = isar.accountCollections
          .where()
          .clientIdEqualTo(id)
          .findFirst();

      if (existing != null) {
        existing.currentBalance = newBalance;
        existing.version++;
        existing.dirty = true;
        existing.syncStatus = existing.serverId == null ? SyncStatus.pendingCreate.name : SyncStatus.pendingUpdate.name;
        existing.updatedAt = DateTime.now().toUtc();

        isar.accountCollections.put(existing);
        SyncEngine.enqueue(
          isar: isar,
          entityType: 'account',
          clientId: id,
          operationType: existing.serverId == null ? 'create' : 'update',
          payload: existing.toSyncJson(),
        );
      }
    });

    SyncEngine.instance.triggerSync();
  }

  @override
  Future<void> adjustAccountBalance(String id, double delta) async {
    if (delta == 0) return;

    await _isar.writeAsync((isar) {
      final existing = isar.accountCollections
          .where()
          .clientIdEqualTo(id)
          .findFirst();

      if (existing != null) {
        existing.currentBalance += delta;
        existing.version++;
        existing.dirty = true;
        existing.syncStatus = existing.serverId == null ? SyncStatus.pendingCreate.name : SyncStatus.pendingUpdate.name;
        existing.updatedAt = DateTime.now().toUtc();

        isar.accountCollections.put(existing);
        SyncEngine.enqueue(
          isar: isar,
          entityType: 'account',
          clientId: id,
          operationType: existing.serverId == null ? 'create' : 'update',
          payload: existing.toSyncJson(),
        );
      }
    });

    SyncEngine.instance.triggerSync();
  }

  @override
  Future<void> deleteAccount(String id) async {
    await _isar.writeAsync((isar) {
      final existing = isar.accountCollections
          .where()
          .clientIdEqualTo(id)
          .findFirst();

      if (existing != null) {
        if (existing.serverId == null) {
          isar.accountCollections.delete(existing.id);
          final ops = isar.outboxOperations.where().clientIdEqualTo(id).findAll();
          for (final op in ops) {
            isar.outboxOperations.delete(op.id);
          }
        } else {
          existing.isDeleted = true;
          existing.dirty = true;
          existing.syncStatus = SyncStatus.pendingDelete.name;
          existing.updatedAt = DateTime.now().toUtc();
          isar.accountCollections.put(existing);

          SyncEngine.enqueue(
            isar: isar,
            entityType: 'account',
            clientId: id,
            operationType: 'delete',
            payload: {},
          );
        }
      }
    });

    SyncEngine.instance.triggerSync();
  }

  @override
  Future<void> seedDefaultAccountsIfNeeded() async {
    // Accounts should only be created from SMS parsing or manual user creation.
    return;
  }
}
