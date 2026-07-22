import 'package:isar_plus/isar_plus.dart';
import 'package:spendly/core/sync/outbox_operation.dart';
import 'package:uuid/uuid.dart';

import 'package:spendly/features/expenses/models/expense_model.dart';
import 'package:spendly/core/sync/collections/expense_collection.dart';
import 'package:spendly/core/sync/collections/budget_collection.dart';
import 'package:spendly/core/sync/collections/category_rule_collection.dart';
import 'package:spendly/core/sync/isar_database.dart';
import 'package:spendly/core/sync/sync_engine.dart';
import 'package:spendly/core/sync/sync_metadata.dart';
import 'package:spendly/core/repositories/i_expense_repository.dart';

class IsarExpenseRepository implements IExpenseRepository {
  Isar get _isar => IsarDatabase.instance.isar;
  final _uuid = const Uuid();

  @override
  Stream<List<Expense>> watchExpenses() {
    // Return a stream that watches all changes on expenses (excluding deleted ones)
    return _isar.expenseCollections
        .where()
        .isDeletedEqualTo(false)
        .sortByDateDesc()
        .watch(fireImmediately: true)
        .map((list) => list.map((e) => e.toDomain()).toList());
  }

  @override
  Future<void> addExpense(Expense expense) async {
    await _isar.writeAsync((isar) {
      final existing = isar.expenseCollections
          .where()
          .clientIdEqualTo(expense.id)
          .findFirst();
      if (existing != null) {
        return;
      }

      final newId = isar.expenseCollections.autoIncrement();
      final col = ExpenseCollection.fromDomain(
        expense,
        syncStatus: SyncStatus.pendingCreate,
        dirty: true,
      )..id = newId;

      isar.expenseCollections.put(col);
      SyncEngine.enqueue(
        isar: isar,
        entityType: 'expense',
        clientId: col.clientId,
        operationType: 'create',
        payload: col.toSyncJson(),
      );
    });

    // Trigger sync in background
    SyncEngine.instance.triggerSync();
  }

  @override
  Future<void> updateExpense(Expense expense) async {
    await _isar.writeAsync((isar) {
      final existing = isar.expenseCollections
          .where()
          .clientIdEqualTo(expense.id)
          .findFirst();

      if (existing != null) {
        final col = ExpenseCollection.fromDomain(
          expense,
          serverId: existing.serverId,
          serverUpdatedAt: existing.serverUpdatedAt,
          syncStatus: existing.serverId == null ? SyncStatus.pendingCreate : SyncStatus.pendingUpdate,
          version: existing.version + 1,
          dirty: true,
        )..id = existing.id;

        isar.expenseCollections.put(col);
        SyncEngine.enqueue(
          isar: isar,
          entityType: 'expense',
          clientId: col.clientId,
          operationType: existing.serverId == null ? 'create' : 'update',
          payload: col.toSyncJson(),
        );
      }
    });

    SyncEngine.instance.triggerSync();
  }

  @override
  Future<void> deleteExpense(String id) async {
    await _isar.writeAsync((isar) {
      final existing = isar.expenseCollections
          .where()
          .clientIdEqualTo(id)
          .findFirst();

      if (existing != null) {
        if (existing.serverId == null) {
          // Hard delete local-only records
          isar.expenseCollections.delete(existing.id);
          // Clean up outbox operations for this clientId
          final ops = isar.outboxOperations.where().clientIdEqualTo(id).findAll();
          for (final op in ops) {
            isar.outboxOperations.delete(op.id);
          }
        } else {
          // Soft delete synced records
          existing.isDeleted = true;
          existing.dirty = true;
          existing.syncStatus = SyncStatus.pendingDelete.name;
          existing.updatedAt = DateTime.now().toUtc();
          isar.expenseCollections.put(existing);

          SyncEngine.enqueue(
            isar: isar,
            entityType: 'expense',
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
  Future<Map<String, Map<String, dynamic>>> getBudgetForMonth(String month) async {
    final budgets = _isar.budgetCollections
        .where()
        .monthEqualTo(month)
        .isDeletedEqualTo(false)
        .findAll();

    final Map<String, Map<String, dynamic>> results = {};
    for (final b in budgets) {
      results[b.category] = {
        'limit': b.amountLimit,
        'spent': 0.0, // populated by UI provider calculations
      };
    }
    return results;
  }

  @override
  Future<void> setBudgetForMonth(
    String month,
    Map<String, Map<String, dynamic>> categories,
  ) async {
    await _isar.writeAsync((isar) {
      // Find all existing budgets for this month
      final existingBudgets = isar.budgetCollections
          .where()
          .monthEqualTo(month)
          .findAll();

      final existingMap = {for (var b in existingBudgets) b.category: b};

      // Upsert new budgets
      for (final entry in categories.entries) {
        final category = entry.key;
        final limit = (entry.value['limit'] as num? ?? 0.0).toDouble();

        final existing = existingMap[category];
        if (existing != null) {
          if (existing.amountLimit != limit || existing.isDeleted) {
            existing.amountLimit = limit;
            existing.isDeleted = false;
            existing.version++;
            existing.dirty = true;
            existing.syncStatus = existing.serverId == null ? SyncStatus.pendingCreate.name : SyncStatus.pendingUpdate.name;
            existing.updatedAt = DateTime.now().toUtc();

            isar.budgetCollections.put(existing);
            SyncEngine.enqueue(
              isar: isar,
              entityType: 'budget',
              clientId: existing.clientId,
              operationType: existing.serverId == null ? 'create' : 'update',
              payload: existing.toSyncJson(),
            );
          }
        } else {
          final clientId = _uuid.v4();
          final newId = isar.budgetCollections.autoIncrement();
          final newCol = BudgetCollection.create(
            clientId: clientId,
            month: month,
            category: category,
            amountLimit: limit,
            syncStatus: SyncStatus.pendingCreate,
            dirty: true,
          )..id = newId;

          isar.budgetCollections.put(newCol);
          SyncEngine.enqueue(
            isar: isar,
            entityType: 'budget',
            clientId: clientId,
            operationType: 'create',
            payload: newCol.toSyncJson(),
          );
        }
      }

      // Soft delete omitted budgets
      for (final existing in existingBudgets) {
        if (!categories.containsKey(existing.category) && !existing.isDeleted) {
          if (existing.serverId == null) {
            isar.budgetCollections.delete(existing.id);
            final ops = isar.outboxOperations.where().clientIdEqualTo(existing.clientId).findAll();
            for (final op in ops) {
              isar.outboxOperations.delete(op.id);
            }
          } else {
            existing.isDeleted = true;
            existing.dirty = true;
            existing.syncStatus = SyncStatus.pendingDelete.name;
            existing.updatedAt = DateTime.now().toUtc();

            isar.budgetCollections.put(existing);
            SyncEngine.enqueue(
              isar: isar,
              entityType: 'budget',
              clientId: existing.clientId,
              operationType: 'delete',
              payload: {},
            );
          }
        }
      }
    });

    SyncEngine.instance.triggerSync();
  }

  @override
  Future<void> setMerchantRule(String merchant, String category) async {
    final docName = merchant.toLowerCase().trim();
    if (docName.isEmpty) return;

    await _isar.writeAsync((isar) {
      final existing = isar.categoryRuleCollections
          .where()
          .merchantEqualTo(merchant.trim())
          .findFirst();

      if (existing != null) {
        if (existing.category != category || existing.isDeleted) {
          existing.category = category;
          existing.isDeleted = false;
          existing.version++;
          existing.dirty = true;
          existing.syncStatus = existing.serverId == null ? SyncStatus.pendingCreate.name : SyncStatus.pendingUpdate.name;
          existing.updatedAt = DateTime.now().toUtc();

          isar.categoryRuleCollections.put(existing);
          SyncEngine.enqueue(
            isar: isar,
            entityType: 'category_rule',
            clientId: existing.clientId,
            operationType: existing.serverId == null ? 'create' : 'update',
            payload: existing.toSyncJson(),
          );
        }
      } else {
        final clientId = _uuid.v4();
        final newId = isar.categoryRuleCollections.autoIncrement();
        final newCol = CategoryRuleCollection.create(
          clientId: clientId,
          merchant: merchant.trim(),
          category: category,
          syncStatus: SyncStatus.pendingCreate,
          dirty: true,
        )..id = newId;

        isar.categoryRuleCollections.put(newCol);
        SyncEngine.enqueue(
          isar: isar,
          entityType: 'category_rule',
          clientId: clientId,
          operationType: 'create',
          payload: newCol.toSyncJson(),
        );
      }
    });

    SyncEngine.instance.triggerSync();
  }

  @override
  Future<String?> getMerchantRule(String merchant) async {
    final trimmed = merchant.toLowerCase().trim();
    if (trimmed.isEmpty) return null;

    // Use a case-insensitive check
    final rule = _isar.categoryRuleCollections
        .where()
        .merchantEqualTo(merchant.trim(), caseSensitive: false)
        .isDeletedEqualTo(false)
        .findFirst();

    return rule?.category;
  }

  @override
  Future<void> updateExpensesCategory(String merchant, String newCategory) async {
    if (merchant.trim().isEmpty) return;

    await _isar.writeAsync((isar) {
      final expenses = isar.expenseCollections
          .where()
          .merchantEqualTo(merchant.trim())
          .isDeletedEqualTo(false)
          .findAll();

      for (final exp in expenses) {
        exp.category = newCategory;
        exp.version++;
        exp.dirty = true;
        exp.syncStatus = exp.serverId == null ? SyncStatus.pendingCreate.name : SyncStatus.pendingUpdate.name;
        exp.updatedAt = DateTime.now().toUtc();

        isar.expenseCollections.put(exp);
        SyncEngine.enqueue(
          isar: isar,
          entityType: 'expense',
          clientId: exp.clientId,
          operationType: exp.serverId == null ? 'create' : 'update',
          payload: exp.toSyncJson(),
        );
      }
    });

    SyncEngine.instance.triggerSync();
  }
}
