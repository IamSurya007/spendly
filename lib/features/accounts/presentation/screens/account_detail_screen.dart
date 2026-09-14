import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/transaction_tile.dart';
import '../../../expenses/screens/add_expense_sheet.dart';
import '../../../expenses/services/expense_providers.dart';
import '../../models/account_model.dart';
import '../../services/account_providers.dart';
import 'add_edit_account_sheet.dart';

class AccountDetailScreen extends ConsumerWidget {
  final Account account;

  const AccountDetailScreen({super.key, required this.account});

  void _showBalanceOverrideDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(
      text: account.currentBalance == account.currentBalance.toInt()
          ? account.currentBalance.toInt().toString()
          : account.currentBalance.toString(),
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Adjust Balance for ${account.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set exact current balance if an SMS deduction didn\'t include the remaining balance.',
              style: AppTextStyles.caption,
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Correct Balance (₹)',
                hintText: 'e.g. 24500',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newBal = double.tryParse(controller.text.trim()) ?? account.currentBalance;
              await ref
                  .read(accountNotifierProvider.notifier)
                  .updateAccountBalance(account.id, newBal);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryNavy,
              foregroundColor: Colors.white,
            ),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allExpensesAsync = ref.watch(expensesStreamProvider);
    final accountsAsync = ref.watch(accountsStreamProvider);

    // Watch live updated account entity from stream
    final liveAccount = accountsAsync.valueOrNull?.firstWhere(
          (a) => a.id == account.id,
          orElse: () => account,
        ) ??
        account;

    final fmt = NumberFormat('#,##,###');
    final cardColor = Color(liveAccount.colorValue);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.pageBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.primaryNavy),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(liveAccount.name, style: AppTextStyles.h2),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_rounded, color: AppColors.primaryNavy),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => AddEditAccountSheet(account: liveAccount),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Account summary hero card
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(AppSpacing.screenPadding),
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: cardColor.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(liveAccount.type.icon, color: Colors.white, size: 20),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              liveAccount.type.displayName.toUpperCase(),
                              style: AppTextStyles.label.copyWith(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 11,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                        if (liveAccount.institution.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              liveAccount.institution,
                              style: AppTextStyles.caption.copyWith(color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      liveAccount.isCreditCard ? 'Outstanding Balance' : 'Current Balance',
                      style: AppTextStyles.caption.copyWith(color: Colors.white.withOpacity(0.7)),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₹${fmt.format(liveAccount.currentBalance)}',
                          style: AppTextStyles.balanceLarge.copyWith(
                            color: Colors.white,
                            fontSize: 36,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _showBalanceOverrideDialog(context, ref),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.sync_rounded, size: 14, color: AppColors.primaryNavy),
                                const SizedBox(width: 4),
                                Text(
                                  'Adjust',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.primaryNavy,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (liveAccount.isCreditCard && liveAccount.creditLimit > 0) ...[
                      const SizedBox(height: AppSpacing.md),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: (liveAccount.currentBalance / liveAccount.creditLimit).clamp(0.0, 1.0),
                          backgroundColor: Colors.white.withOpacity(0.2),
                          color: Colors.white,
                          minHeight: 6,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Available: ₹${fmt.format(liveAccount.availableCredit)}',
                            style: AppTextStyles.caption.copyWith(color: Colors.white.withOpacity(0.8)),
                          ),
                          Text(
                            'Limit: ₹${fmt.format(liveAccount.creditLimit)}',
                            style: AppTextStyles.caption.copyWith(color: Colors.white.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Transactions Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                  vertical: AppSpacing.sm,
                ),
                child: Text('Account Transactions', style: AppTextStyles.h2),
              ),
            ),

            // Filtered Transactions List
            allExpensesAsync.when(
              data: (expenses) {
                final accountExpenses = expenses
                    .where((e) => e.accountId == liveAccount.id)
                    .toList();

                if (accountExpenses.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Column(
                        children: [
                          const Text('💳', style: TextStyle(fontSize: 40)),
                          const SizedBox(height: AppSpacing.sm),
                          Text('No transactions for this account', style: AppTextStyles.h3),
                          const SizedBox(height: 4),
                          Text(
                            'Transactions added to ${liveAccount.name} will appear here.',
                            style: AppTextStyles.caption,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
                    decoration: BoxDecoration(
                      color: AppColors.cardSurface,
                      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Column(
                      children: [
                        for (int i = 0; i < accountExpenses.length; i++) ...[
                          TransactionTile(
                            expense: accountExpenses[i],
                            onTap: () => showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => AddExpenseSheet(expense: accountExpenses[i]),
                            ),
                          ),
                          if (i < accountExpenses.length - 1)
                            const Divider(
                              height: 1,
                              indent: AppSpacing.screenPadding + 44 + AppSpacing.md,
                              endIndent: AppSpacing.screenPadding,
                              color: AppColors.borderLight,
                            ),
                        ]
                      ],
                    ),
                  ),
                );
              },
              loading: () => const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator(color: AppColors.accent)),
              ),
              error: (e, _) => SliverToBoxAdapter(
                child: Center(child: Text('Could not load transactions', style: AppTextStyles.bodySmall)),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }
}
