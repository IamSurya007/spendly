import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../data/category_taxonomy.g.dart';
import '../models/category.dart';
import '../services/category_providers.dart';

IconData categoryIconData(String iconKey) =>
    categoryIcons[iconKey] ?? PhosphorIconsFill.tag;

/// Fold-style category tile: the category colour at low opacity with the
/// icon in full colour on top.
class CategoryIcon extends StatelessWidget {
  final Category category;
  final double size;
  final bool muted;

  const CategoryIcon({
    super.key,
    required this.category,
    this.size = 44,
    this.muted = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = muted ? const Color(0xFFB0B8CC) : category.colorValue;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      alignment: Alignment.center,
      child: Icon(categoryIconData(category.iconKey), color: color, size: size * 0.5),
    );
  }
}

/// [CategoryIcon] for an expense-like record, resolved through the registry
/// (so user renames, colours and custom categories show up).
class ExpenseCategoryIcon extends ConsumerWidget {
  final String categoryId;
  final String subcategoryId;
  final bool isCredit;
  final double size;
  final bool muted;

  const ExpenseCategoryIcon({
    super.key,
    required this.categoryId,
    this.subcategoryId = '',
    this.isCredit = false,
    this.size = 44,
    this.muted = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registry = ref.watch(categoryRegistryProvider);
    final leaf = registry.leaf(categoryId, subcategoryId, isCredit: isCredit);
    return CategoryIcon(category: leaf, size: size, muted: muted);
  }
}
