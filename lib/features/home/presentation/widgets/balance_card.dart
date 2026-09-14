import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../expenses/services/expense_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Monthly money-flow card: Income received vs Spends made vs what's left.
/// Replaces the old "Liquid Balance" card which showed an unreliable account sum.
class BalanceCard extends ConsumerWidget {
  final User user;

  const BalanceCard({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final income = ref.watch(monthlyIncomeProvider);
    final spends = ref.watch(monthlyExpensesProvider);
    final left = ref.watch(monthlyLeftProvider);
    final now = DateTime.now();
    final month = DateFormat('MMMM yyyy').format(now);
    final fmt = NumberFormat('#,##,###');

    final bool isSurplus = left >= 0;
    final leftColor = isSurplus ? AppColors.incomeGreen : AppColors.expenseRed;
    final leftLabel = isSurplus ? 'Remaining' : 'Over budget';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      decoration: BoxDecoration(
        color: AppColors.primaryNavy,
        borderRadius: BorderRadius.circular(AppSpacing.largeRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withOpacity(0.22),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top: Month label + tag ──────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.md,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  month,
                  style: AppTextStyles.label.copyWith(
                    color: Colors.white.withOpacity(0.55),
                    letterSpacing: 0.5,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.bar_chart_rounded, size: 12, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        'This Month',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Income (hero figure) ────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: AppColors.incomeGreen.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.arrow_downward_rounded,
                              size: 13,
                              color: AppColors.incomeGreen,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Income',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white.withOpacity(0.65),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        income > 0 ? '₹${fmt.format(income)}' : '₹0',
                        style: AppTextStyles.balanceLarge.copyWith(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // ── Spends + Remaining bottom row ───────────────────────────
          Container(
            margin: const EdgeInsets.fromLTRB(
              AppSpacing.md, 0, AppSpacing.md, AppSpacing.md,
            ),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                _FlowStat(
                  label: 'Spends',
                  value: '₹${fmt.format(spends)}',
                  valueColor: spends > 0 ? AppColors.expenseRed : Colors.white,
                  icon: Icons.arrow_upward_rounded,
                  iconBg: AppColors.expenseRed.withOpacity(0.18),
                  iconColor: AppColors.expenseRed,
                ),
                Container(
                  width: 1,
                  height: 36,
                  color: Colors.white.withOpacity(0.15),
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                ),
                _FlowStat(
                  label: leftLabel,
                  value: '₹${fmt.format(left.abs())}',
                  valueColor: leftColor,
                  icon: isSurplus
                      ? Icons.savings_rounded
                      : Icons.warning_amber_rounded,
                  iconBg: leftColor.withOpacity(0.18),
                  iconColor: leftColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FlowStat extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;

  const _FlowStat({
    required this.label,
    required this.value,
    required this.valueColor,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 15, color: iconColor),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: AppTextStyles.h3.copyWith(
                    color: valueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
