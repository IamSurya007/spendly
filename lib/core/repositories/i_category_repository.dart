import '../../features/categories/models/category.dart';

/// Custom categories and user overrides of system categories.
abstract interface class ICategoryRepository {
  /// Custom categories + overrides (not deleted).
  Stream<List<Category>> watchUserCategories();

  /// Creates or updates a custom category, or stores an override for a
  /// system category (same id as the system one).
  Future<void> saveCategory(Category category);

  /// Deletes a custom category (and its subcategories). Expenses, rules and
  /// budgets that used it are moved to [reassignTo].
  Future<void> deleteCustomCategory(String id, {required CategorySelection reassignTo});

  /// Removes the user's override of a system category.
  Future<void> resetSystemCategory(String id);

  /// One-time rewrite of records that only carry a legacy category name.
  /// Local only: the server applies the same mapping to its own rows.
  Future<void> migrateLegacyCategories();
}
