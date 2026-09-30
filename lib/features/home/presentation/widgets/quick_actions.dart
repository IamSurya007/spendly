import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_spacing.dart';

/// Horizontal row of quick-action chips on the Home screen.
class QuickActions extends StatelessWidget {
  final VoidCallback onAddExpense;
  final VoidCallback onAddCashSpend;
  final VoidCallback onAddLoan;
  final VoidCallback onAddInvestment;
  final VoidCallback onScanSms;
  final VoidCallback onExport;
  final VoidCallback? onAiChat;

  const QuickActions({
    super.key,
    required this.onAddExpense,
    required this.onAddCashSpend,
    required this.onAddLoan,
    required this.onAddInvestment,
    required this.onScanSms,
    required this.onExport,
    this.onAiChat,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: Row(
        children: [
          if (onAiChat != null)
            _ActionChip(
              icon: '✨',
              label: 'AI Assistant',
              onTap: onAiChat!,
              isHighlight: true,
            ),
          _ActionChip(
            icon: '➕',
            label: 'Add Expense',
            onTap: onAddExpense,
          ),
          _ActionChip(
            icon: '💵',
            label: 'Cash Spend',
            onTap: onAddCashSpend,
          ),
          _ActionChip(
            icon: '💬',
            label: 'Scan SMS',
            onTap: onScanSms,
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
            onTap: onExport,
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
  final bool isHighlight;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isHighlight = false,
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
          gradient: isHighlight
              ? const LinearGradient(
                  colors: [Color(0xFF0D1B3E), Color(0xFF3D7FE8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isHighlight ? null : AppColors.cardSurface,
          borderRadius: BorderRadius.circular(AppSpacing.chipRadius + 2),
          border: Border.all(
            color: isHighlight
                ? AppColors.accent.withOpacity(0.5)
                : AppColors.borderLight,
          ),
          boxShadow: [
            BoxShadow(
              color: isHighlight
                  ? AppColors.accent.withOpacity(0.2)
                  : AppColors.primaryNavy.withOpacity(0.04),
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
            Text(
              label,
              style: AppTextStyles.label.copyWith(
                color: isHighlight ? Colors.white : AppColors.primaryNavy,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

