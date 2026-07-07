import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../../features/expenses/models/expense_model.dart';

/// Horizontal-scroll chip for category selection in Add Expense sheet.
class CategoryChip extends StatelessWidget {
  final String category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : AppColors.inputFill,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.borderLight,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              ExpenseCategories.iconEmoji(category),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 6),
            Text(
              category,
              style: AppTextStyles.label.copyWith(
                color: isSelected ? Colors.white : AppColors.primaryNavy,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
