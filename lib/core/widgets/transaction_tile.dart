import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_spacing.dart';
import '../../features/expenses/models/expense_model.dart';
import '../../features/accounts/services/account_providers.dart';

/// Fold / Axio style transaction tile — compact collapsed state, rich expanded state on tap.
class TransactionTile extends ConsumerStatefulWidget {
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
  ConsumerState<TransactionTile> createState() => _TransactionTileState();
}

class _TransactionTileState extends ConsumerState<TransactionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final expense = widget.expense;
    final isDebit = expense.amount > 0;
    final isExcluded = !expense.isCountedAsSpend;
    final amountText =
        '${isDebit ? '-' : '+'}₹${NumberFormat('#,##,###').format(expense.amount.abs())}';

    final accounts = ref.watch(accountsStreamProvider).valueOrNull ?? [];
    final matchingAccounts = accounts.where((a) => a.id == expense.accountId);
    final account = matchingAccounts.isNotEmpty ? matchingAccounts.first : null;
    final accountName = account?.name ?? '';

    final categoryDisplay = expense.subcategory.isNotEmpty
        ? '${expense.category} › ${expense.subcategory}'
        : expense.category;

    final dateFormatted = DateFormat('d MMM · h:mm a').format(expense.date);

    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      onLongPress: widget.onLongPress,
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutCubic,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding,
          vertical: AppSpacing.sm + 2,
        ),
        decoration: BoxDecoration(
          color: _isExpanded
              ? AppColors.primaryNavy.withOpacity(0.02)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header (Collapsed & Top of Expanded) ──
            Row(
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
                        color: isExcluded
                            ? Colors.black.withOpacity(0.35)
                            : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                // Title + Subtitle
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
                          color: isExcluded ? AppColors.mutedText : null,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _isExpanded ? dateFormatted : '${expense.category} · ${DateFormat('d MMM').format(expense.date)}',
                        style: AppTextStyles.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Amount + Expand Chevron
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      amountText,
                      style: AppTextStyles.amountStyle(
                        isDebit: isDebit,
                        fontSize: 15,
                      ).copyWith(
                        color: isExcluded ? AppColors.mutedText : null,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 16,
                      color: AppColors.mutedText,
                    ),
                  ],
                ),
              ],
            ),

            // ── Expanded Story View ──
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(height: 1, color: AppColors.borderLight),
                    const SizedBox(height: AppSpacing.md),
                    
                    // Chips Row: Category, Account, Method, Excluded
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        // Category / Subcategory chip
                        _MetaChip(
                          icon: Icons.category_rounded,
                          label: categoryDisplay,
                          color: AppColors.primaryNavy,
                          bgColor: AppColors.inputFill,
                        ),
                        // Account chip
                        if (account != null && accountName.isNotEmpty)
                          _MetaChip(
                            icon: Icons.account_balance_wallet_rounded,
                            label: accountName,
                            color: Color(account.colorValue),
                            bgColor: Color(account.colorValue).withOpacity(0.12),
                          ),
                        // Payment method chip
                        _MetaChip(
                          icon: Icons.payment_rounded,
                          label: expense.method.toUpperCase(),
                          color: AppColors.mutedText,
                          bgColor: AppColors.inputFill,
                        ),
                        // Source chip
                        if (expense.source != 'manual')
                          _MetaChip(
                            icon: Icons.sync_rounded,
                            label: expense.source.toUpperCase(),
                            color: AppColors.accent,
                            bgColor: AppColors.accent.withOpacity(0.1),
                          ),
                        // Excluded pill
                        if (isExcluded)
                          _MetaChip(
                            icon: Icons.block_rounded,
                            label: isDebit ? 'Excluded from spends' : 'Excluded from income',
                            color: isDebit ? AppColors.expenseRed : AppColors.incomeGreen,
                            bgColor: isDebit
                                ? AppColors.statusOverdueBackground
                                : const Color(0xFFE8F5E9),
                          ),
                      ],
                    ),

                    // Note box if present
                    if (expense.note.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.sm + 4),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSpacing.sm + 2),
                        decoration: BoxDecoration(
                          color: AppColors.inputFill,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.notes_rounded,
                                size: 14, color: AppColors.mutedText),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                expense.note,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.primaryNavy,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    // Action buttons: Edit
                    if (widget.onTap != null) ...[
                      const SizedBox(height: AppSpacing.sm + 4),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: widget.onTap,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primaryNavy,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.edit_rounded,
                                    size: 13, color: Colors.white),
                                const SizedBox(width: 4),
                                Text(
                                  'Edit Details',
                                  style: AppTextStyles.caption.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 250),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;

  const _MetaChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
