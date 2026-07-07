import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';

/// A category budget progress card.
class BudgetCategoryCard extends StatelessWidget {
  final String category;
  final String emoji;
  final double spent;
  final double limit;

  const BudgetCategoryCard({
    super.key,
    required this.category,
    required this.emoji,
    required this.spent,
    required this.limit,
  });

  @override
  Widget build(BuildContext context) {
    final fraction = limit > 0 ? (spent / limit).clamp(0.0, 1.0) : 0.0;
    final pct = (fraction * 100).toStringAsFixed(0);
    final isWarning = fraction >= 0.8 && fraction < 1.0;
    final isOver = fraction >= 1.0;
    final barColor = isOver
        ? AppColors.expenseRed
        : isWarning
            ? const Color(0xFFE07B00)
            : AppColors.accent;
    final fmt = NumberFormat('#,##,###');

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: AppSpacing.xs,
      ),
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Emoji icon chip
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.inputFill,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(emoji, style: const TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(width: AppSpacing.sm + 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(category, style: AppTextStyles.h3),
                    Text(
                      '₹${fmt.format(spent)} of ₹${fmt.format(limit)}',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              // Percentage badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isOver
                      ? AppColors.statusOverdueBackground
                      : isWarning
                          ? const Color(0xFFFFF3E0)
                          : AppColors.statusActiveBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$pct%',
                  style: AppTextStyles.labelBold.copyWith(color: barColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm + 4),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: fraction,
              backgroundColor: AppColors.inputFill,
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
