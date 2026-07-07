import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../expenses/services/expense_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// The large hero balance card showing current month net balance.
class BalanceCard extends ConsumerWidget {
  final User user;

  const BalanceCard({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesAsync = ref.watch(expensesStreamProvider);
    final now = DateTime.now();

    return expensesAsync.when(
      data: (expenses) {
        final thisMonth = expenses.where(
          (e) => e.date.year == now.year && e.date.month == now.month,
        );
        final totalExpenses = thisMonth
            .where((e) => e.amount > 0)
            .fold(0.0, (sum, e) => sum + e.amount);
        // For now, income is static (can be extended to income collection later)
        const income = 65000.0;
        final balance = income - totalExpenses;
        final savings = balance;

        return _CardContent(
          income: income,
          expenses: totalExpenses,
          balance: balance,
          savings: savings,
          month: DateFormat('MMMM yyyy').format(now),
        );
      },
      loading: () => _CardContent(
        income: 0,
        expenses: 0,
        balance: 0,
        savings: 0,
        month: DateFormat('MMMM yyyy').format(now),
        loading: true,
      ),
      error: (e, _) => const SizedBox.shrink(),
    );
  }
}

class _CardContent extends StatelessWidget {
  final double income;
  final double expenses;
  final double balance;
  final double savings;
  final String month;
  final bool loading;

  const _CardContent({
    required this.income,
    required this.expenses,
    required this.balance,
    required this.savings,
    required this.month,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat('#,##,###');
    final isNegative = balance < 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.primaryNavy,
        borderRadius: BorderRadius.circular(AppSpacing.largeRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month label
          Row(
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
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Net Balance',
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Big balance number
          loading
              ? Container(
                  width: 160,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                )
              : Text(
                  '${isNegative ? '-' : ''}₹${fmt.format(balance.abs())}',
                  style: AppTextStyles.balanceLarge.copyWith(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
          const SizedBox(height: AppSpacing.lg),
          // Income · Expenses · Savings row
          Row(
            children: [
              _Stat(
                label: 'Income',
                value: '₹${fmt.format(income)}',
                color: AppColors.incomeGreen,
              ),
              _Divider(),
              _Stat(
                label: 'Expenses',
                value: '₹${fmt.format(expenses)}',
                color: AppColors.expenseRed,
              ),
              _Divider(),
              _Stat(
                label: 'Savings',
                value: '₹${fmt.format(savings.abs())}',
                color: savings >= 0 ? AppColors.incomeGreen : AppColors.expenseRed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _Stat({
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
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.h3.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.5,
      height: 32,
      color: Colors.white.withOpacity(0.15),
      margin: const EdgeInsets.symmetric(horizontal: 12),
    );
  }
}
