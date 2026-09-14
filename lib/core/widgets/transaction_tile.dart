import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_spacing.dart';
import '../../features/expenses/models/expense_model.dart';
import '../../features/accounts/services/account_providers.dart';

/// A single transaction row — icon chip · merchant · category & account · date · amount.
class TransactionTile extends ConsumerWidget {
  final Expense expense;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const TransactionTile({
    super.key,
    required this.expense,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDebit = expense.amount > 0;
    final isExcluded = isDebit && !expense.isCountedAsSpend;
    final amountText =
        '${isDebit ? '-' : '+'}₹${NumberFormat('#,##,###').format(expense.amount.abs())}';

    final accounts = ref.watch(accountsStreamProvider).valueOrNull ?? [];
    final matchingAccounts = accounts.where((a) => a.id == expense.accountId);
    final account = matchingAccounts.isNotEmpty ? matchingAccounts.first : null;

    final accountName = account?.name ?? '';

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding,
          vertical: AppSpacing.sm + 2,
        ),
        child: Row(
          children: [
            // Icon chip
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isExcluded
                    ? AppColors.inputFill.withOpacity(0.5)
                    : AppColors.inputFill,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  ExpenseCategories.iconEmoji(expense.category),
                  style: TextStyle(
                    fontSize: 20,
                    color: isExcluded ? null : null,
                  ).copyWith(
                    color: isExcluded
                        ? Colors.black.withOpacity(0.35)
                        : null,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Merchant + category + account badge
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.merchant.isNotEmpty
                        ? expense.merchant
                        : expense.note.isNotEmpty
                            ? expense.note
                            : expense.category,
                    style: AppTextStyles.h3.copyWith(
                      color: isExcluded
                          ? AppColors.mutedText
                          : null,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          '${expense.category} · ${DateFormat('d MMM').format(expense.date)}',
                          style: AppTextStyles.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (account != null && accountName.isNotEmpty) ...[
                        const SizedBox(width: 6),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                            decoration: BoxDecoration(
                              color: Color(account.colorValue).withOpacity(0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              accountName,
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 10,
                                color: Color(account.colorValue),
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                      if (isExcluded) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                          decoration: BoxDecoration(
                            color: AppColors.mutedText.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Excluded',
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 10,
                              color: AppColors.mutedText,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            // Amount
            Text(
              amountText,
              style: AppTextStyles.amountStyle(
                isDebit: isDebit,
                fontSize: 14,
              ).copyWith(
                color: isExcluded ? AppColors.mutedText : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
