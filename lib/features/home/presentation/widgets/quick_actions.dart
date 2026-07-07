import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_spacing.dart';

/// Horizontal row of quick-action chips on the Home screen.
class QuickActions extends StatelessWidget {
  final VoidCallback onAddExpense;
  final VoidCallback onAddLoan;
  final VoidCallback onAddInvestment;

  const QuickActions({
    super.key,
    required this.onAddExpense,
    required this.onAddLoan,
    required this.onAddInvestment,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: Row(
        children: [
          _ActionChip(
            icon: '➕',
            label: 'Add Expense',
            onTap: onAddExpense,
          ),
          _ActionChip(
            icon: '🤝',
            label: 'Add Loan',
            onTap: onAddLoan,
          ),
          _ActionChip(
            icon: '📈',
            label: 'Add Investment',
            onTap: onAddInvestment,
          ),
          _ActionChip(
            icon: '📤',
            label: 'Export',
            onTap: () {
              // TODO: Sheets export — Week 7
            },
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(AppSpacing.chipRadius + 2),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryNavy.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            Text(label, style: AppTextStyles.label.copyWith(
              color: AppColors.primaryNavy,
              fontWeight: FontWeight.w600,
            )),
          ],
        ),
      ),
    );
  }
}
