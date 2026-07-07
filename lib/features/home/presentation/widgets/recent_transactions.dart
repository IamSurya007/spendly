import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/transaction_tile.dart';
import '../../../expenses/services/expense_providers.dart';

/// Shows last 5 transactions from the Firestore stream.
class RecentTransactions extends ConsumerWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesAsync = ref.watch(expensesStreamProvider);

    return expensesAsync.when(
      data: (expenses) {
        if (expenses.isEmpty) {
          return _Empty();
        }
        final recent = expenses.take(5).toList();
        return Column(
          children: recent
              .map((e) => TransactionTile(expense: e))
              .toList(),
        );
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: CircularProgressIndicator(
            color: AppColors.accent,
            strokeWidth: 2,
          ),
        ),
      ),
      error: (e, _) => Center(
        child: Text('Error loading transactions', style: AppTextStyles.bodySmall),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          const Text('💸', style: TextStyle(fontSize: 32)),
          const SizedBox(height: AppSpacing.sm),
          Text('No transactions yet', style: AppTextStyles.h3),
          const SizedBox(height: 4),
          Text(
            'Tap + to add your first expense',
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}
