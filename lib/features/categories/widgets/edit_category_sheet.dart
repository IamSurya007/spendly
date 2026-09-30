import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../data/category_taxonomy.g.dart';
import '../models/category.dart';
import '../services/category_providers.dart';
import 'category_icon.dart';

/// Create a category (pass [parent] for a subcategory) or edit [existing].
/// Returns the saved category, or null if cancelled.
Future<Category?> showEditCategorySheet(
  BuildContext context, {
  Category? existing,
  Category? parent,
  CategoryKind kind = CategoryKind.expense,
}) {
  return showModalBottomSheet<Category>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => EditCategorySheet(existing: existing, parent: parent, kind: kind),
  );
}

class EditCategorySheet extends ConsumerStatefulWidget {
  final Category? existing;
  final Category? parent;
  final CategoryKind kind;

  const EditCategorySheet({super.key, this.existing, this.parent, this.kind = CategoryKind.expense});

  @override
  ConsumerState<EditCategorySheet> createState() => _EditCategorySheetState();
}

class _EditCategorySheetState extends ConsumerState<EditCategorySheet> {
  late final TextEditingController _name =
      TextEditingController(text: widget.existing?.name ?? '');
  late String _iconKey = widget.existing?.iconKey ?? widget.parent?.iconKey ?? 'tag';
  late int _color = widget.existing?.color ?? widget.parent?.color ?? categoryColorPalette.first;
  bool _saving = false;

  bool get _isSub => (widget.existing?.parentId ?? widget.parent?.id) != null;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) return;
    setState(() => _saving = true);

    final existing = widget.existing;
    final registry = ref.read(categoryRegistryProvider);
    final category = existing != null
        ? existing.copyWith(name: name, iconKey: _iconKey, color: _color)
        : Category(
            id: const Uuid().v4(),
            name: name,
            iconKey: _iconKey,
            color: _color,
            kind: widget.parent?.kind ?? widget.kind,
            parentId: widget.parent?.id,
            // New categories go to the end of their group.
            sortOrder: (widget.parent == null
                    ? registry.parents(includeHidden: true)
                    : registry.childrenOf(widget.parent!.id, includeHidden: true))
                .fold<int>(0, (m, c) => c.sortOrder > m ? c.sortOrder : m) + 1,
          );

    await ref.read(categoryRepositoryProvider).saveCategory(category);
    if (mounted) Navigator.pop(context, category);
  }

  @override
  Widget build(BuildContext context) {
    final preview = Category(
      id: 'preview',
      name: _name.text,
      iconKey: _iconKey,
      color: _color,
      kind: widget.kind,
    );
    final title = widget.existing != null
        ? 'Edit ${_isSub ? 'subcategory' : 'category'}'
        : (_isSub ? 'New subcategory in ${widget.parent!.name}' : 'New category');

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.78,
        decoration: const BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.md),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(title, style: AppTextStyles.h2),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                CategoryIcon(category: preview, size: 56),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: TextField(
                    controller: _name,
                    autofocus: widget.existing == null,
                    textCapitalization: TextCapitalization.words,
                    maxLength: 32,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Name',
                      counterText: '',
                      filled: true,
                      fillColor: AppColors.inputFill,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('COLOUR', style: AppTextStyles.caption.copyWith(letterSpacing: 1.2)),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final c in categoryColorPalette)
                    GestureDetector(
                      onTap: () => setState(() => _color = c),
                      child: Container(
                        width: 32,
                        height: 32,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Color(c),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _color == c ? AppColors.primaryNavy : Colors.transparent,
                            width: 2.5,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('ICON', style: AppTextStyles.caption.copyWith(letterSpacing: 1.2)),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: GridView.count(
                crossAxisCount: 6,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: [
                  for (final key in categoryIconPalette)
                    InkWell(
                      onTap: () => setState(() => _iconKey = key),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: _iconKey == key ? Color(_color).withValues(alpha: 0.14) : AppColors.inputFill,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _iconKey == key ? Color(_color) : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          categoryIconData(key),
                          size: 20,
                          color: _iconKey == key ? Color(_color) : AppColors.mutedText,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _saving || _name.text.trim().isEmpty ? null : _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryNavy,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                      ),
                      elevation: 0,
                    ),
                    child: Text('Save', style: AppTextStyles.buttonText),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
