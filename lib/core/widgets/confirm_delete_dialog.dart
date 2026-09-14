import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmLabel;

  const ConfirmDeleteDialog({
    super.key,
    required this.title,
    required this.content,
    this.confirmLabel = 'Delete',
  });

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String content,
    String confirmLabel = 'Delete',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => ConfirmDeleteDialog(
        title: title,
        content: content,
        confirmLabel: confirmLabel,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.statusOverdueBackground,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.expenseRed,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.h2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.mutedText,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Cancel',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.mutedText,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.expenseRed,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    confirmLabel,
                    style: AppTextStyles.label.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
