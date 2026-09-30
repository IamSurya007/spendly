import '../data/category_taxonomy.g.dart';
import '../models/category.dart';

/// Stateless lookups against the generated system taxonomy.
///
/// For anything that must reflect the user's custom categories and overrides
/// use [CategoryRegistry] instead.
class CategoryResolver {
  CategoryResolver._();

  static final Map<String, Category> systemById = {
    for (final c in systemCategories) c.id: c,
  };

  /// Maps an old free-text category name to ids. Unknown names fall back to
  /// Miscellaneous (debits) or Income (credits).
  static CategorySelection fromLegacyName(String name, {bool isCredit = false}) {
    final key = name.trim().toLowerCase();
    final mapped = legacyCategoryMap[key];
    if (mapped != null) {
      final (parent, sub) = mapped;
      if (isCredit && parent == defaultDebitCategoryId) {
        return const CategorySelection(defaultCreditCategoryId);
      }
      return CategorySelection(parent, sub ?? '');
    }

    // Already a new-style name or id (e.g. data written by a newer client).
    for (final c in systemCategories) {
      if (c.id == key || c.name.toLowerCase() == key) {
        return c.parentId == null ? CategorySelection(c.id) : CategorySelection(c.parentId!, c.id);
      }
    }

    return CategorySelection(isCredit ? defaultCreditCategoryId : defaultDebitCategoryId);
  }

  static CategorySelection defaultFor({required bool isCredit}) =>
      CategorySelection(isCredit ? defaultCreditCategoryId : defaultDebitCategoryId);

  /// Turns any category id (parent or sub) into a (parent, sub) selection
  /// using the system taxonomy only.
  static CategorySelection selectionForSystemId(String id) {
    final c = systemById[id];
    if (c == null) return CategorySelection(id);
    return c.parentId == null ? CategorySelection(c.id) : CategorySelection(c.parentId!, c.id);
  }
}
