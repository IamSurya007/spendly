import 'package:isar_plus/isar_plus.dart';
import 'package:spendly/core/sync/outbox_operation.dart';

import 'package:spendly/features/loans/models/loan_model.dart';
import 'package:spendly/core/sync/collections/loan_collection.dart';
import 'package:spendly/core/sync/isar_database.dart';
import 'package:spendly/core/sync/sync_engine.dart';
import 'package:spendly/core/sync/sync_metadata.dart';
import 'package:spendly/core/repositories/i_loan_repository.dart';

class IsarLoanRepository implements ILoanRepository {
  Isar get _isar => IsarDatabase.instance.isar;

  @override
  Stream<List<Loan>> watchLoans() {
    return _isar.loanCollections
        .where()
        .isDeletedEqualTo(false)
        .sortByCreatedAtDesc()
        .watch(fireImmediately: true)
        .map((list) => list.map((l) => l.toDomain()).toList());
  }

  @override
  Future<void> addLoan(Loan loan) async {
    await _isar.writeAsync((isar) {
      final newId = isar.loanCollections.autoIncrement();
      final col = LoanCollection.fromDomain(
        loan,
        syncStatus: SyncStatus.pendingCreate,
        dirty: true,
      )..id = newId;

      isar.loanCollections.put(col);
      SyncEngine.enqueue(
        isar: isar,
        entityType: 'loan',
        clientId: col.clientId,
        operationType: 'create',
        payload: col.toSyncJson(),
      );
    });

    SyncEngine.instance.triggerSync();
  }

  @override
  Future<void> updateLoan(Loan loan) async {
    await _isar.writeAsync((isar) {
      final existing = isar.loanCollections
          .where()
          .clientIdEqualTo(loan.id)
          .findFirst();

      if (existing != null) {
        final col = LoanCollection.fromDomain(
          loan,
          serverId: existing.serverId,
          serverUpdatedAt: existing.serverUpdatedAt,
          syncStatus: existing.serverId == null ? SyncStatus.pendingCreate : SyncStatus.pendingUpdate,
          version: existing.version + 1,
          dirty: true,
        )..id = existing.id;

        isar.loanCollections.put(col);
        SyncEngine.enqueue(
          isar: isar,
          entityType: 'loan',
          clientId: col.clientId,
          operationType: existing.serverId == null ? 'create' : 'update',
          payload: col.toSyncJson(),
        );
      }
    });

    SyncEngine.instance.triggerSync();
  }

  @override
  Future<void> updateLoanStatus(String id, String status) async {
    await _isar.writeAsync((isar) {
      final existing = isar.loanCollections
          .where()
          .clientIdEqualTo(id)
          .findFirst();

      if (existing != null) {
        existing.status = status;
        existing.version++;
        existing.dirty = true;
        existing.syncStatus = existing.serverId == null ? SyncStatus.pendingCreate.name : SyncStatus.pendingUpdate.name;
        existing.updatedAt = DateTime.now().toUtc();

        isar.loanCollections.put(existing);
        SyncEngine.enqueue(
          isar: isar,
          entityType: 'loan',
          clientId: existing.clientId,
          operationType: existing.serverId == null ? 'create' : 'update',
          payload: existing.toSyncJson(),
        );
      }
    });

    SyncEngine.instance.triggerSync();
  }

  @override
  Future<void> deleteLoan(String id) async {
    await _isar.writeAsync((isar) {
      final existing = isar.loanCollections
          .where()
          .clientIdEqualTo(id)
          .findFirst();

      if (existing != null) {
        if (existing.serverId == null) {
          isar.loanCollections.delete(existing.id);
          final ops = isar.outboxOperations.where().clientIdEqualTo(id).findAll();
          for (final op in ops) {
            isar.outboxOperations.delete(op.id);
          }
        } else {
          existing.isDeleted = true;
          existing.dirty = true;
          existing.syncStatus = SyncStatus.pendingDelete.name;
          existing.updatedAt = DateTime.now().toUtc();
          isar.loanCollections.put(existing);

          SyncEngine.enqueue(
            isar: isar,
            entityType: 'loan',
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
