import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../models/category.dart';
import '../services/category_providers.dart';
import '../services/category_registry.dart';
import '../services/category_resolver.dart';
import '../widgets/category_icon.dart';
import '../widgets/category_picker_sheet.dart';
import '../widgets/edit_category_sheet.dart';

/// Add, rename, recolour, hide, reorder and delete categories.
class ManageCategoriesScreen extends ConsumerStatefulWidget {
  const ManageCategoriesScreen({super.key});

  @override
  ConsumerState<ManageCategoriesScreen> createState() => _ManageCategoriesScreenState();
}

class _ManageCategoriesScreenState extends ConsumerState<ManageCategoriesScreen> {
  CategoryKind _kind = CategoryKind.expense;
  final Set<String> _expanded = {};

  Future<void> _toggleHidden(Category c) async {
    await ref.read(categoryRepositoryProvider).saveCategory(c.copyWith(isHidden: !c.isHidden));
  }

  Future<void> _delete(CategoryRegistry registry, Category c) async {
    final fallback = c.parentId != null
        ? CategorySelection(c.parentId!)
        : CategoryResolver.defaultFor(isCredit: c.kind == CategoryKind.income);
    final fallbackLabel = registry.label(fallback.categoryId, fallback.subcategoryId);

    final choice = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete "${c.name}"?'),
        content: Text(
          c.isParent
              ? 'Its subcategories are deleted too. Transactions in it will move to the category you choose.'
              : 'Transactions in it will move to the category you choose.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, 'pick'), child: const Text('Choose…')),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, 'fallback'),
            child: Text('Move to $fallbackLabel'),
          ),
        ],
      ),
    );
    if (choice == null || !mounted) return;

    var target = fallback;
    if (choice == 'pick') {
      final picked = await showCategoryPicker(context, kind: c.kind);
      if (picked == null) return;
      if (picked.categoryId == c.id || picked.subcategoryId == c.id) return;
      target = picked;
    }
    await ref.read(categoryRepositoryProvider).deleteCustomCategory(c.id, reassignTo: target);
  }

  Future<void> _reorder(List<Category> parents, int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) newIndex -= 1;
    final list = [...parents];
    final moved = list.removeAt(oldIndex);
    list.insert(newIndex, moved);
    final repo = ref.read(categoryRepositoryProvider);
    for (var i = 0; i < list.length; i++) {
      final wanted = i * 100;
      if (list[i].sortOrder != wanted) {
        await repo.saveCategory(list[i].copyWith(sortOrder: wanted));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final registry = ref.watch(categoryRegistryProvider);
    final parents = registry.parents(kind: _kind, includeHidden: true);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.pageBackground,
        elevation: 0,
        title: Text('Categories', style: AppTextStyles.h2),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryNavy,
        foregroundColor: Colors.white,
        onPressed: () => showEditCategorySheet(context, kind: _kind),
        icon: const Icon(Icons.add_rounded),
        label: const Text('New category'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
            child: SegmentedButton<CategoryKind>(
              segments: const [
                ButtonSegment(value: CategoryKind.expense, label: Text('Expense')),
                ButtonSegment(value: CategoryKind.income, label: Text('Income')),
                ButtonSegment(value: CategoryKind.transfer, label: Text('Transfer')),
              ],
              selected: {_kind},
              showSelectedIcon: false,
              onSelectionChanged: (s) => setState(() => _kind = s.first),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenPadding, AppSpacing.md, AppSpacing.screenPadding, AppSpacing.sm,
            ),
            child: Text(
              'Long-press and drag to reorder. Hidden categories stay on old transactions but are not offered when picking.',
              style: AppTextStyles.caption,
            ),
          ),
          Expanded(
            child: ReorderableListView.builder(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding, 0, AppSpacing.screenPadding, 96,
              ),
              itemCount: parents.length,
              onReorder: (o, n) => _reorder(parents, o, n),
              itemBuilder: (_, i) {
                final p = parents[i];
                final children = registry.childrenOf(p.id, includeHidden: true);
                final open = _expanded.contains(p.id);
                return Container(
                  key: ValueKey(p.id),
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.cardSurface,
                    borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Column(
                    children: [
                      _CategoryRow(
                        category: p,
                        subtitle: '${children.where((c) => !c.isHidden).length} subcategories',
                        trailing: IconButton(
                          icon: Icon(open ? Icons.expand_less_rounded : Icons.expand_more_rounded),
                          onPressed: () => setState(() => open ? _expanded.remove(p.id) : _expanded.add(p.id)),
                        ),
                        onEdit: () => showEditCategorySheet(context, existing: p),
                        onToggleHidden: () => _toggleHidden(p),
                        onDelete: p.isSystem ? null : () => _delete(registry, p),
                      ),
                      if (open) ...[
                        const Divider(height: 1, color: AppColors.borderLight),
                        for (final c in children)
                          _CategoryRow(
                            category: c,
                            indent: true,
                            onEdit: () => showEditCategorySheet(context, existing: c, parent: p),
                            onToggleHidden: () => _toggleHidden(c),
                            onDelete: c.isSystem ? null : () => _delete(registry, c),
                          ),
                        ListTile(
                          contentPadding: const EdgeInsets.only(left: 72, right: 16),
                          leading: const Icon(Icons.add_rounded, color: AppColors.accent),
                          title: Text(
                            'Add subcategory',
                            style: AppTextStyles.label.copyWith(color: AppColors.accent),
                          ),
                          onTap: () => showEditCategorySheet(context, parent: p),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final Category category;
  final String? subtitle;
  final bool indent;
  final Widget? trailing;
  final VoidCallback onEdit;
  final VoidCallback onToggleHidden;
  final VoidCallback? onDelete;

  const _CategoryRow({
    required this.category,
    required this.onEdit,
    required this.onToggleHidden,
    this.onDelete,
    this.subtitle,
    this.indent = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: indent ? 32 : 12, right: 4),
      leading: Opacity(
        opacity: category.isHidden ? 0.4 : 1,
        child: CategoryIcon(category: category, size: indent ? 34 : 40),
      ),
      title: Text(
        category.name,
        style: AppTextStyles.h3.copyWith(
          color: category.isHidden ? AppColors.mutedText : AppColors.primaryNavy,
          decoration: category.isHidden ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: subtitle == null && category.isSystem
          ? null
          : Text(
              [if (subtitle != null) subtitle!, if (!category.isSystem) 'Custom'].join(' · '),
              style: AppTextStyles.caption,
            ),
      onTap: onEdit,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded, color: AppColors.mutedText),
            onSelected: (v) {
              if (v == 'edit') onEdit();
              if (v == 'hide') onToggleHidden();
              if (v == 'delete') onDelete?.call();
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(value: 'hide', child: Text(category.isHidden ? 'Show' : 'Hide')),
              if (onDelete != null) const PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
