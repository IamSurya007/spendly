import 'package:flutter/material.dart';

enum CategoryKind { expense, income, transfer }

/// A transaction category or subcategory.
///
/// System categories come from the generated taxonomy
/// (`data/category_taxonomy.g.dart`) and use stable slug ids such as `food`
/// and `food.restaurants`. Custom categories created by the user use UUIDs.
/// A user can also override a system category (rename / recolour / hide);
/// the override is stored with the system id.
@immutable
class Category {
  final String id;
  final String name;
  final String iconKey;

  /// ARGB colour value.
  final int color;
  final CategoryKind kind;

  /// Null for top-level categories.
  final String? parentId;
  final bool isSystem;
  final bool isHidden;
  final int sortOrder;

  const Category({
    required this.id,
    required this.name,
    required this.iconKey,
    required this.color,
    required this.kind,
    this.parentId,
    this.isSystem = false,
    this.isHidden = false,
    this.sortOrder = 0,
  });

  bool get isParent => parentId == null;
  Color get colorValue => Color(color);

  Category copyWith({
    String? name,
    String? iconKey,
    int? color,
    CategoryKind? kind,
    String? parentId,
    bool? isHidden,
    int? sortOrder,
  }) {
    return Category(
      id: id,
      name: name ?? this.name,
      iconKey: iconKey ?? this.iconKey,
      color: color ?? this.color,
      kind: kind ?? this.kind,
      parentId: parentId ?? this.parentId,
      isSystem: isSystem,
      isHidden: isHidden ?? this.isHidden,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  static CategoryKind kindFromName(String? name) => CategoryKind.values.firstWhere(
        (k) => k.name == name,
        orElse: () => CategoryKind.expense,
      );

  static String colorToHex(int argb) =>
      '#${(argb & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';

  static int colorFromHex(String? hex, {int fallback = 0xFF9CA3AF}) {
    if (hex == null) return fallback;
    final clean = hex.replaceAll('#', '');
    final value = int.tryParse(clean, radix: 16);
    if (value == null) return fallback;
    return clean.length <= 6 ? 0xFF000000 | value : value;
  }

  @override
  bool operator ==(Object other) =>
      other is Category &&
      other.id == id &&
      other.name == name &&
      other.iconKey == iconKey &&
      other.color == color &&
      other.kind == kind &&
      other.parentId == parentId &&
      other.isHidden == isHidden &&
      other.sortOrder == sortOrder;

  @override
  int get hashCode => Object.hash(id, name, iconKey, color, kind, parentId, isHidden, sortOrder);
}

/// A resolved (parent, subcategory) pair for display.
@immutable
class CategorySelection {
  final String categoryId;
  final String subcategoryId;

  const CategorySelection(this.categoryId, [this.subcategoryId = '']);

  bool get hasSub => subcategoryId.isNotEmpty;

  /// The most specific id (subcategory if set).
  String get leafId => hasSub ? subcategoryId : categoryId;

  @override
  bool operator ==(Object other) =>
      other is CategorySelection &&
      other.categoryId == categoryId &&
      other.subcategoryId == subcategoryId;

  @override
  int get hashCode => Object.hash(categoryId, subcategoryId);
}
