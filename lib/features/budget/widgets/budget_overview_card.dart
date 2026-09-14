import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../expenses/services/expense_providers.dart';

/// Top-level budget utilisation summary card for the Budget Overview tab.
/// Shows total budgeted vs total spent this month with a progress bar.
class BudgetOverviewCard extends ConsumerWidget {
  final double totalBudgeted;
  final double totalSpent;

  const BudgetOverviewCard({
    super.key,
    required this.totalBudgeted,
    required this.totalSpent,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final income = ref.watch(monthlyIncomeProvider);
    final fmt = NumberFormat('#,##,###');

    final fraction =
        totalBudgeted > 0 ? (totalSpent / totalBudgeted).clamp(0.0, 1.0) : 0.0;
    final pct = (fraction * 100).round();
    final isOver = totalBudgeted > 0 && totalSpent > totalBudgeted;
    final isWarning = !isOver && fraction >= 0.8;

    final barColor = isOver
        ? AppColors.expenseRed
        : isWarning
            ? const Color(0xFFE07B00)
            : AppColors.accent;

    final remaining = totalBudgeted - totalSpent;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.primaryNavy,
        borderRadius: BorderRadius.circular(AppSpacing.largeRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: spent / budget
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Month Budget',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white.withOpacity(0.55),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    totalBudgeted > 0
                        ? '₹${fmt.format(totalBudgeted)}'
                        : 'No limit set',
                    style: AppTextStyles.h2.copyWith(color: Colors.white),
                  ),
                ],
              ),
              // Pct badge
              if (totalBudgeted > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: barColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isOver ? 'Over budget' : '$pct% used',
                    style: AppTextStyles.caption.copyWith(
                      color: isOver ? AppColors.expenseRed : Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // Progress bar
          if (totalBudgeted > 0) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: fraction,
                backgroundColor: Colors.white.withOpacity(0.12),
                valueColor: AlwaysStoppedAnimation<Color>(barColor),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],

          // Bottom stats row
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _MiniStat(
                  label: 'Spent',
                  value: '₹${fmt.format(totalSpent)}',
                  color: totalSpent > 0 ? AppColors.expenseRed : Colors.white,
                ),
                if (totalBudgeted > 0) ...[
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.white.withOpacity(0.15),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  _MiniStat(
                    label: isOver ? 'Overspent' : 'Remaining',
                    value: '₹${fmt.format(remaining.abs())}',
                    color: isOver ? AppColors.expenseRed : AppColors.incomeGreen,
                  ),
                ],
                if (income > 0) ...[
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.white.withOpacity(0.15),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  _MiniStat(
                    label: 'Income',
                    value: '₹${fmt.format(income)}',
                    color: AppColors.incomeGreen,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MiniStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: Colors.white.withOpacity(0.55),
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: AppTextStyles.h3.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
