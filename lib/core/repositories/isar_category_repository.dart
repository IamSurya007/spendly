import 'package:isar_plus/isar_plus.dart';

import 'package:fiscora/core/repositories/i_category_repository.dart';
import 'package:fiscora/core/sync/collections/budget_collection.dart';
import 'package:fiscora/core/sync/collections/category_collection.dart';
import 'package:fiscora/core/sync/collections/category_rule_collection.dart';
import 'package:fiscora/core/sync/collections/expense_collection.dart';
import 'package:fiscora/core/sync/isar_database.dart';
import 'package:fiscora/core/sync/outbox_operation.dart';
import 'package:fiscora/core/sync/sync_engine.dart';
import 'package:fiscora/core/sync/sync_metadata.dart';
import 'package:fiscora/features/categories/models/category.dart';
import 'package:fiscora/features/categories/services/category_registry.dart';
import 'package:fiscora/features/categories/services/category_resolver.dart';

class IsarCategoryRepository implements ICategoryRepository {
  Isar get _isar => IsarDatabase.instance.isar;

  @override
  Stream<List<Category>> watchUserCategories() {
    return _isar.categoryCollections
        .where()
        .isDeletedEqualTo(false)
        .watch(fireImmediately: true)
        .map((list) => list.map((c) => c.toDomain()).toList());
  }

  List<Category> _userCategoriesSync(Isar isar) => isar.categoryCollections
      .where()
      .isDeletedEqualTo(false)
      .findAll()
      .map((c) => c.toDomain())
      .toList();

  @override
  Future<void> saveCategory(Category category) async {
    await _isar.writeAsync((isar) {
      final existing = isar.categoryCollections.where().clientIdEqualTo(category.id).findFirst();
      final col = CategoryCollection.fromDomain(
        category,
        serverId: existing?.serverId,
        serverUpdatedAt: existing?.serverUpdatedAt,
        syncStatus: existing?.serverId == null ? SyncStatus.pendingCreate : SyncStatus.pendingUpdate,
        version: (existing?.version ?? 0) + 1,
        dirty: true,
      )..id = existing?.id ?? isar.categoryCollections.autoIncrement();
      isar.categoryCollections.put(col);

      SyncEngine.enqueue(
        isar: isar,
        entityType: 'category',
        clientId: col.clientId,
        operationType: existing?.serverId == null ? 'create' : 'update',
        payload: col.toSyncJson(),
      );

      // Keep denormalised display names on expenses in sync with a rename.
      if (existing != null && existing.name != category.name) {
        _renameOnExpenses(isar, category);
      }
    });
    SyncEngine.instance.triggerSync();
  }

  void _renameOnExpenses(Isar isar, Category category) {
    final affected = category.isParent
        ? isar.expenseCollections.where().categoryIdEqualTo(category.id).findAll()
        : isar.expenseCollections.where().subcategoryIdEqualTo(category.id).findAll();
    for (final exp in affected) {
      if (category.isParent) {
        exp.category = category.name;
      } else {
        exp.subcategory = category.name;
      }
      isar.expenseCollections.put(exp);
    }
  }

  @override
  Future<void> deleteCustomCategory(String id, {required CategorySelection reassignTo}) async {
    await _isar.writeAsync((isar) {
      final registry = CategoryRegistry(_userCategoriesSync(isar));
      final target = registry.resolve(reassignTo.categoryId, reassignTo.subcategoryId);

      final ids = {
        id,
        ...isar.categoryCollections.where().parentIdEqualTo(id).findAll().map((c) => c.clientId),
      };

      for (final catId in ids) {
        final col = isar.categoryCollections.where().clientIdEqualTo(catId).findFirst();
        if (col == null || col.isSystem) continue;
        if (col.serverId == null) {
          isar.categoryCollections.delete(col.id);
          _dropQueuedOps(isar, col.clientId);
        } else {
          col
            ..isDeleted = true
            ..dirty = true
            ..syncStatus = SyncStatus.pendingDelete.name
            ..updatedAt = DateTime.now().toUtc();
          isar.categoryCollections.put(col);
          SyncEngine.enqueue(
            isar: isar,
            entityType: 'category',
            clientId: col.clientId,
            operationType: 'delete',
            payload: {},
          );
        }
      }

      // Move expenses.
      final expenses = isar.expenseCollections.where().isDeletedEqualTo(false).findAll().where(
            (e) => ids.contains(e.categoryId) || ids.contains(e.subcategoryId),
          );
      for (final exp in expenses) {
        exp
          ..categoryId = target.parent.id
          ..subcategoryId = target.sub?.id ?? ''
          ..category = target.parent.name
          ..subcategory = target.sub?.name ?? ''
          ..version += 1
          ..dirty = true
          ..syncStatus = exp.serverId == null ? SyncStatus.pendingCreate.name : SyncStatus.pendingUpdate.name
          ..updatedAt = DateTime.now().toUtc();
        isar.expenseCollections.put(exp);
        SyncEngine.enqueue(
          isar: isar,
          entityType: 'expense',
          clientId: exp.clientId,
          operationType: exp.serverId == null ? 'create' : 'update',
          payload: exp.toSyncJson(),
        );
      }

      // Move merchant rules.
      final rules = isar.categoryRuleCollections.where().isDeletedEqualTo(false).findAll().where(
            (r) => ids.contains(r.categoryId) || ids.contains(r.subcategoryId),
          );
      for (final rule in rules) {
        rule
          ..categoryId = target.parent.id
          ..subcategoryId = target.sub?.id ?? ''
          ..category = target.parent.name
          ..version += 1
          ..dirty = true
          ..syncStatus = rule.serverId == null ? SyncStatus.pendingCreate.name : SyncStatus.pendingUpdate.name
          ..updatedAt = DateTime.now().toUtc();
        isar.categoryRuleCollections.put(rule);
        SyncEngine.enqueue(
          isar: isar,
          entityType: 'category_rule',
          clientId: rule.clientId,
          operationType: rule.serverId == null ? 'create' : 'update',
          payload: rule.toSyncJson(),
        );
      }

      // Budgets on a deleted parent are dropped (the target may already have one).
      final budgets = isar.budgetCollections.where().isDeletedEqualTo(false).findAll().where(
            (b) => ids.contains(b.category),
          );
      for (final b in budgets) {
        if (b.serverId == null) {
          isar.budgetCollections.delete(b.id);
          _dropQueuedOps(isar, b.clientId);
        } else {
          b
            ..isDeleted = true
            ..dirty = true
            ..syncStatus = SyncStatus.pendingDelete.name
            ..updatedAt = DateTime.now().toUtc();
          isar.budgetCollections.put(b);
          SyncEngine.enqueue(
            isar: isar,
            entityType: 'budget',
            clientId: b.clientId,
            operationType: 'delete',
            payload: {},
          );
        }
      }
    });
    SyncEngine.instance.triggerSync();
  }

  @override
  Future<void> resetSystemCategory(String id) async {
    final system = CategoryResolver.systemById[id];
    if (system == null) return;
    // Store the pristine values rather than deleting, so other devices pick
    // up the reset through normal sync.
    await saveCategory(system);
  }

  void _dropQueuedOps(Isar isar, String clientId) {
    final ops = isar.outboxOperations.where().clientIdEqualTo(clientId).findAll();
    for (final op in ops) {
      isar.outboxOperations.delete(op.id);
    }
  }

  @override
  Future<void> migrateLegacyCategories() async {
    await _isar.writeAsync((isar) {
      final registry = CategoryRegistry(_userCategoriesSync(isar));

      // Expenses: fill ids from the legacy name and refresh display names.
      final expenses = isar.expenseCollections.where().categoryIdEqualTo('').findAll();
      for (final exp in expenses) {
        final sel = CategoryResolver.fromLegacyName(exp.category, isCredit: exp.amount < 0);
        final r = registry.resolve(sel.categoryId, sel.subcategoryId, isCredit: exp.amount < 0);
        exp
          ..categoryId = r.parent.id
          ..subcategoryId = r.sub?.id ?? ''
          ..category = r.parent.name
          ..subcategory = r.sub?.name ?? '';
        isar.expenseCollections.put(exp);
      }

      // Merchant rules.
      final rules = isar.categoryRuleCollections.where().categoryIdEqualTo('').findAll();
      for (final rule in rules) {
        final sel = CategoryResolver.fromLegacyName(rule.category);
        rule
          ..categoryId = sel.categoryId
          ..subcategoryId = sel.subcategoryId;
        isar.categoryRuleCollections.put(rule);
      }

      // Budgets move from legacy names to parent ids. Several old budgets can
      // land on the same parent (Restaurants + Food Delivery -> Food & Drinks):
      // their limits are added up into one. The surviving row is chosen
      // exactly like the server does (see CategoriesService.backfill), so both
      // sides keep the same clientId.
      final budgets = isar.budgetCollections.where().isDeletedEqualTo(false).findAll();
      final groups = <String, List<BudgetCollection>>{};
      for (final b in budgets) {
        final parentId = registry.byId(b.category)?.isParent == true
            ? b.category
            : CategoryResolver.fromLegacyName(b.category).categoryId;
        groups.putIfAbsent('${b.month}|$parentId', () => []).add(b);
      }
      for (final entry in groups.entries) {
        final parentId = entry.key.split('|').last;
        final rows = entry.value;
        if (rows.length == 1 && rows.first.category == parentId) continue;

        rows.sort((a, b) {
          final aIsId = a.category == parentId ? 0 : 1;
          final bIsId = b.category == parentId ? 0 : 1;
          return aIsId != bIsId ? aIsId - bIsId : a.clientId.compareTo(b.clientId);
        });
        final keeper = rows.first
          ..category = parentId
          ..amountLimit = rows.fold(0.0, (sum, r) => sum + r.amountLimit);
        isar.budgetCollections.put(keeper);
        for (final extra in rows.skip(1)) {
          extra.isDeleted = true;
          isar.budgetCollections.put(extra);
        }
      }
    });
  }
}
