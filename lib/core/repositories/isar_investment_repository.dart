import 'package:isar_plus/isar_plus.dart';
import 'package:spendly/core/sync/outbox_operation.dart';

import 'package:spendly/features/investments/models/investment_model.dart';
import 'package:spendly/core/sync/collections/investment_collection.dart';
import 'package:spendly/core/sync/isar_database.dart';
import 'package:spendly/core/sync/sync_engine.dart';
import 'package:spendly/core/sync/sync_metadata.dart';
import 'package:spendly/core/repositories/i_investment_repository.dart';

class IsarInvestmentRepository implements IInvestmentRepository {
  Isar get _isar => IsarDatabase.instance.isar;

  @override
  Stream<List<Investment>> watchInvestments() {
    return _isar.investmentCollections
        .where()
        .isDeletedEqualTo(false)
        .watch(fireImmediately: true)
        .map((list) => list.map((i) => i.toDomain()).toList());
  }

  @override
  Future<void> addInvestment(Investment investment) async {
    await _isar.writeAsync((isar) {
      final newId = isar.investmentCollections.autoIncrement();
      final col = InvestmentCollection.fromDomain(
        investment,
        syncStatus: SyncStatus.pendingCreate,
        dirty: true,
      )..id = newId;

      isar.investmentCollections.put(col);
      SyncEngine.enqueue(
        isar: isar,
        entityType: 'investment',
        clientId: col.clientId,
        operationType: 'create',
        payload: col.toSyncJson(),
      );
    });

    SyncEngine.instance.triggerSync();
  }

  @override
  Future<void> updateInvestment(Investment investment) async {
    await _isar.writeAsync((isar) {
      final existing = isar.investmentCollections
          .where()
          .clientIdEqualTo(investment.id)
          .findFirst();

      if (existing != null) {
        final col = InvestmentCollection.fromDomain(
          investment,
          serverId: existing.serverId,
          serverUpdatedAt: existing.serverUpdatedAt,
          syncStatus: existing.serverId == null ? SyncStatus.pendingCreate : SyncStatus.pendingUpdate,
          version: existing.version + 1,
          dirty: true,
        )..id = existing.id;

        isar.investmentCollections.put(col);
        SyncEngine.enqueue(
          isar: isar,
          entityType: 'investment',
          clientId: col.clientId,
          operationType: existing.serverId == null ? 'create' : 'update',
          payload: col.toSyncJson(),
        );
      }
    });

    SyncEngine.instance.triggerSync();
  }

  @override
  Future<void> deleteInvestment(String id) async {
    await _isar.writeAsync((isar) {
      final existing = isar.investmentCollections
          .where()
          .clientIdEqualTo(id)
          .findFirst();

      if (existing != null) {
        if (existing.serverId == null) {
          isar.investmentCollections.delete(existing.id);
          final ops = isar.outboxOperations.where().clientIdEqualTo(id).findAll();
          for (final op in ops) {
            isar.outboxOperations.delete(op.id);
          }
        } else {
          existing.isDeleted = true;
          existing.dirty = true;
          existing.syncStatus = SyncStatus.pendingDelete.name;
          existing.updatedAt = DateTime.now().toUtc();
          isar.investmentCollections.put(existing);

          SyncEngine.enqueue(
            isar: isar,
            entityType: 'investment',
            clientId: id,
            operationType: 'delete',
            payload: {},
          );
        }
      }
    });

    SyncEngine.instance.triggerSync();
  }
}
