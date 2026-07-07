import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_spacing.dart';
import '../../features/expenses/models/expense_model.dart';

/// A single transaction row — icon chip · merchant · category · date · amount.
class TransactionTile extends StatelessWidget {
  final Expense expense;
  final VoidCallback? onLongPress;

  const TransactionTile({
    super.key,
    required this.expense,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final isDebit = expense.amount > 0;
    final amountText =
        '${isDebit ? '-' : '+'}₹${NumberFormat('#,##,###').format(expense.amount.abs())}';

    return InkWell(
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
                color: AppColors.inputFill,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  ExpenseCategories.iconEmoji(expense.category),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Merchant + category
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
                    style: AppTextStyles.h3,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${expense.category} · ${DateFormat('d MMM').format(expense.date)}',
                    style: AppTextStyles.caption,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
