import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/category_chip.dart';
import '../../expenses/services/expense_providers.dart';
import '../models/category.dart';
import '../services/category_providers.dart';
import '../services/category_registry.dart';
import 'category_icon.dart';
import 'edit_category_sheet.dart';

/// Opens the category picker. Returns null if dismissed.
Future<CategorySelection?> showCategoryPicker(
  BuildContext context, {
  CategorySelection? initial,
  CategoryKind kind = CategoryKind.expense,
}) {
  return showModalBottomSheet<CategorySelection>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => CategoryPickerSheet(initial: initial, initialKind: kind),
  );
}

class CategoryPickerSheet extends ConsumerStatefulWidget {
  final CategorySelection? initial;
  final CategoryKind initialKind;

  const CategoryPickerSheet({super.key, this.initial, this.initialKind = CategoryKind.expense});

  @override
  ConsumerState<CategoryPickerSheet> createState() => _CategoryPickerSheetState();
}

class _CategoryPickerSheetState extends ConsumerState<CategoryPickerSheet> {
  late CategoryKind _kind = widget.initialKind;
  String? _openParentId;
  String _query = '';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _pick(CategorySelection selection) => Navigator.pop(context, selection);

  Future<void> _createCategory({String? parentId}) async {
    final registry = ref.read(categoryRegistryProvider);
    final parent = parentId == null ? null : registry.byId(parentId);
    final created = await showEditCategorySheet(
      context,
      parent: parent,
      kind: parent?.kind ?? _kind,
    );
    if (created == null || !mounted) return;
    _pick(created.isParent
        ? CategorySelection(created.id)
        : CategorySelection(created.parentId!, created.id));
  }

  /// Most recently used leaf categories of the current kind.
  List<Category> _recent(CategoryRegistry registry) {
    final expenses = ref.watch(expensesStreamProvider).valueOrNull ?? const [];
    final seen = <String>{};
    final result = <Category>[];
    for (final e in expenses) {
      final leaf = registry.leaf(e.categoryId, e.subcategoryId, isCredit: e.amount < 0);
      final parent = leaf.parentId == null ? leaf : registry.byId(leaf.parentId!);
      if (parent?.kind != _kind || leaf.isHidden) continue;
      if (seen.add(leaf.id)) result.add(leaf);
      if (result.length == 8) break;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final registry = ref.watch(categoryRegistryProvider);
    final openParent = _openParentId == null ? null : registry.byId(_openParentId!);

    return Container(
      height: MediaQuery.of(context).size.height * 0.82,
      decoration: const BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.md),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.borderLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: openParent == null
                  ? _buildRoot(registry)
                  : _buildParent(registry, openParent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoot(CategoryRegistry registry) {
    final parents = registry.parents(kind: _kind);
    final results = registry.search(_query, kind: _kind);
    final recent = _query.isEmpty ? _recent(registry) : const <Category>[];

    return Column(
      key: const ValueKey('root'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
          child: Text('Choose category', style: AppTextStyles.h2),
        ),
        const SizedBox(height: AppSpacing.md),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
          child: TextField(
            controller: _searchController,
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'Search categories',
              prefixIcon: const Icon(Icons.search_rounded, color: AppColors.mutedText),
              filled: true,
              fillColor: AppColors.inputFill,
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
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
        const SizedBox(height: AppSpacing.md),
        Expanded(
          child: _query.isNotEmpty
              ? _buildSearchResults(registry, results)
              : ListView(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
                  children: [
                    if (recent.isNotEmpty) ...[
                      Text('RECENT', style: AppTextStyles.caption.copyWith(letterSpacing: 1.2)),
                      const SizedBox(height: AppSpacing.sm),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final c in recent)
                            CategoryChip(
                              category: c,
                              isSelected: widget.initial?.leafId == c.id,
                              onTap: () => _pick(registry.selectionFor(c.id)),
                            ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                    Text('ALL CATEGORIES', style: AppTextStyles.caption.copyWith(letterSpacing: 1.2)),
                    const SizedBox(height: AppSpacing.sm),
                    GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.78,
                      children: [
                        for (final p in parents)
                          _ParentTile(
                            category: p,
                            isSelected: widget.initial?.categoryId == p.id,
                            onTap: () {
                              if (registry.childrenOf(p.id).isEmpty) {
                                _pick(CategorySelection(p.id));
                              } else {
                                setState(() => _openParentId = p.id);
                              }
                            },
                          ),
                        _NewTile(onTap: () => _createCategory()),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildSearchResults(CategoryRegistry registry, List<Category> results) {
    if (results.isEmpty) {
      return Center(
        child: TextButton.icon(
          onPressed: () => _createCategory(),
          icon: const Icon(Icons.add_rounded),
          label: Text('Create "${_query.trim()}"'),
        ),
      );
    }
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (_, i) {
        final c = results[i];
        final parent = c.parentId == null ? null : registry.byId(c.parentId!);
        return ListTile(
          leading: CategoryIcon(category: c, size: 38),
          title: Text(c.name, style: AppTextStyles.h3),
          subtitle: parent == null ? null : Text(parent.name, style: AppTextStyles.caption),
          onTap: () => _pick(registry.selectionFor(c.id)),
        );
      },
    );
  }

  Widget _buildParent(CategoryRegistry registry, Category parent) {
    final children = registry.childrenOf(parent.id);
    final initial = widget.initial;
    return ListView(
      key: ValueKey(parent.id),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => setState(() => _openParentId = null),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            CategoryIcon(category: parent, size: 40),
            const SizedBox(width: AppSpacing.sm + 4),
            Expanded(child: Text(parent.name, style: AppTextStyles.h2)),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: 8,
          runSpacing: 10,
          children: [
            CategoryChip(
              category: parent,
              labelOverride: 'All ${parent.name}',
              isSelected: initial?.categoryId == parent.id && !(initial?.hasSub ?? false),
              onTap: () => _pick(CategorySelection(parent.id)),
            ),
            for (final c in children)
              CategoryChip(
                category: c,
                isSelected: initial?.subcategoryId == c.id,
                onTap: () => _pick(CategorySelection(parent.id, c.id)),
              ),
            ActionChip(
              avatar: const Icon(Icons.add_rounded, size: 16),
              label: const Text('Add subcategory'),
              onPressed: () => _createCategory(parentId: parent.id),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ],
        ),
      ],
    );
  }
}

class _ParentTile extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  const _ParentTile({required this.category, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isSelected ? category.colorValue : Colors.transparent,
                width: 2,
              ),
            ),
            child: CategoryIcon(category: category, size: 52),
          ),
          const SizedBox(height: 6),
          Text(
            category.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primaryNavy,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _NewTile extends StatelessWidget {
  final VoidCallback onTap;
  const _NewTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.inputFill,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: const Icon(Icons.add_rounded, color: AppColors.mutedText),
          ),
          const SizedBox(height: 6),
          Text('New', style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
