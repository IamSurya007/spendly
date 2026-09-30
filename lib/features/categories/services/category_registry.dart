import '../data/category_taxonomy.g.dart';
import '../models/category.dart';
import 'category_resolver.dart';

/// The effective category list for the current user: system taxonomy merged
/// with the user's overrides (rename / recolour / hide / reorder) and custom
/// categories.
class CategoryRegistry {
  final Map<String, Category> _byId;
  final List<Category> _ordered;

  CategoryRegistry._(this._byId, this._ordered);

  factory CategoryRegistry(List<Category> userCategories) {
    final byId = <String, Category>{
      for (final c in systemCategories) c.id: c,
    };
    for (final c in userCategories) {
      final system = byId[c.id];
      byId[c.id] = system == null
          ? c
          // An override may not move a system category or change its kind.
          : system.copyWith(
              name: c.name,
              iconKey: c.iconKey,
              color: c.color,
              isHidden: c.isHidden,
              sortOrder: c.sortOrder,
            );
    }
    // Drop custom subcategories whose parent no longer exists.
    byId.removeWhere((_, c) => c.parentId != null && !byId.containsKey(c.parentId));

    final ordered = byId.values.toList()
      ..sort((a, b) {
        final bySort = a.sortOrder.compareTo(b.sortOrder);
        return bySort != 0 ? bySort : a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
    return CategoryRegistry._(byId, ordered);
  }

  static final CategoryRegistry systemOnly = CategoryRegistry(const []);

  Category? byId(String id) => _byId[id];

  /// Always returns something displayable.
  Category categoryOrFallback(String id, {bool isCredit = false}) {
    return _byId[id] ??
        _byId[isCredit ? defaultCreditCategoryId : defaultDebitCategoryId]!;
  }

  List<Category> get all => List.unmodifiable(_ordered);

  List<Category> parents({CategoryKind? kind, bool includeHidden = false}) => _ordered
      .where((c) => c.isParent)
      .where((c) => kind == null || c.kind == kind)
      .where((c) => includeHidden || !c.isHidden)
      .toList();

  List<Category> childrenOf(String parentId, {bool includeHidden = false}) => _ordered
      .where((c) => c.parentId == parentId)
      .where((c) => includeHidden || !c.isHidden)
      .toList();

  /// Parent + optional sub for an expense-like record.
  ({Category parent, Category? sub}) resolve(
    String categoryId,
    String subcategoryId, {
    bool isCredit = false,
  }) {
    final parent = categoryOrFallback(categoryId, isCredit: isCredit);
    final sub = subcategoryId.isEmpty ? null : _byId[subcategoryId];
    return (parent: parent, sub: sub?.parentId == parent.id ? sub : null);
  }

  /// "Food & Drinks › Restaurants" or just "Food & Drinks".
  String label(String categoryId, String subcategoryId, {bool isCredit = false}) {
    final r = resolve(categoryId, subcategoryId, isCredit: isCredit);
    return r.sub == null ? r.parent.name : '${r.parent.name} › ${r.sub!.name}';
  }

  /// The most specific category to show an icon/colour for.
  Category leaf(String categoryId, String subcategoryId, {bool isCredit = false}) {
    final r = resolve(categoryId, subcategoryId, isCredit: isCredit);
    return r.sub ?? r.parent;
  }

  /// Turns any id (parent or sub) into a selection.
  CategorySelection selectionFor(String id) {
    final c = _byId[id];
    if (c == null) return CategoryResolver.selectionForSystemId(id);
    return c.parentId == null ? CategorySelection(c.id) : CategorySelection(c.parentId!, c.id);
  }

  /// Case-insensitive search over names of visible categories.
  List<Category> search(String query, {CategoryKind? kind}) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return const [];
    return _ordered
        .where((c) => !c.isHidden)
        .where((c) => kind == null || c.kind == kind || _byId[c.parentId]?.kind == kind)
        .where((c) => c.name.toLowerCase().contains(q))
        .toList();
  }
}
