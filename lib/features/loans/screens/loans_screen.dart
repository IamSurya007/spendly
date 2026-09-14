import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/confirm_delete_dialog.dart';
import '../models/loan_model.dart';
import '../services/loan_providers.dart';
import 'add_loan_sheet.dart';

class LoansScreen extends ConsumerWidget {
  const LoansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loansData = ref.watch(loansGivenTakenProvider);
    final taken = loansData.taken;
    final given = loansData.given;

    final fmt = NumberFormat('#,##,###');
    final totalOwed =
        taken.where((l) => l.status != 'paid').fold(0.0, (s, l) => s + l.currentTotal);
    final totalOwedToMe =
        given.where((l) => l.status != 'paid').fold(0.0, (s, l) => s + l.currentTotal);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // ── Header ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenPadding,
                  AppSpacing.lg,
                  AppSpacing.screenPadding,
                  AppSpacing.md,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Loans', style: AppTextStyles.h1),
                    // Add loan FAB button
                    GestureDetector(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const AddLoanSheet(),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryNavy,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.add_rounded,
                                color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            Text('Add',
                                style: AppTextStyles.label
                                    .copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // ── Summary row ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding),
              child: Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      label: 'You Owe',
                      amount: '₹${fmt.format(totalOwed)}',
                      color: AppColors.expenseRed,
                      bgColor: const Color(0xFFFFEBEE),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _SummaryCard(
                      label: 'Owed to You',
                      amount: '₹${fmt.format(totalOwedToMe)}',
                      color: AppColors.incomeGreen,
                      bgColor: const Color(0xFFE8F5E9),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ── You Owe section ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: const BoxDecoration(
                      color: AppColors.expenseRed,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text('You Owe', style: AppTextStyles.h2),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),

          if (taken.isEmpty)
            SliverToBoxAdapter(child: _EmptySection(type: 'taken'))
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) {
                  final loan = taken[i];
                  return GestureDetector(
                    onTap: () => showModalBottomSheet(
                      context: ctx,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => AddLoanSheet(loan: loan),
                    ),
                    child: LoanCard(loan: loan),
                  );
                },
                childCount: taken.length,
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ── They Owe You section ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: const BoxDecoration(
                      color: AppColors.incomeGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text('They Owe You', style: AppTextStyles.h2),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),

          if (given.isEmpty)
            SliverToBoxAdapter(child: _EmptySection(type: 'given'))
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) {
                  final loan = given[i];
                  return GestureDetector(
                    onTap: () => showModalBottomSheet(
                      context: ctx,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => AddLoanSheet(loan: loan),
                    ),
                    child: LoanCard(loan: loan),
                  );
                },
                childCount: given.length,
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    ),
  );
}
}

class LoanCard extends ConsumerStatefulWidget {
  final Loan loan;

  const LoanCard({super.key, required this.loan});

  @override
  ConsumerState<LoanCard> createState() => _LoanCardState();
}

class _LoanCardState extends ConsumerState<LoanCard> {
  bool _isExpanded = false;

  Future<void> _handleTogglePaid() async {
    final newStatus = widget.loan.status == 'paid' ? 'active' : 'paid';
    final updatedLoan = widget.loan.copyWith(
      status: newStatus,
      total: widget.loan.currentTotal,
    );
    await ref.read(loanNotifierProvider.notifier).updateLoan(updatedLoan);
  }

  Future<void> _handleDelete() async {
    final confirmed = await ConfirmDeleteDialog.show(
      context,
      title: 'Delete Loan',
      content:
          'Are you sure you want to delete "${widget.loan.name}"? This action cannot be undone.',
      confirmLabel: 'Delete',
    );

    if (confirmed) {
      ref.read(loanNotifierProvider.notifier).deleteLoan(widget.loan.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loan = widget.loan;
    final fmt = NumberFormat('#,##,###');
    final isGiven = loan.type == 'given';
    final daysLeft = loan.daysRemaining;
    final isPaid = loan.status == 'paid';
    final isOverdue = loan.status == 'overdue' || loan.isOverdue;

    Color statusColor;
    Color statusBg;
    String statusLabel;

    if (isPaid) {
      statusColor = AppColors.statusPaid;
      statusBg = AppColors.statusPaidBackground;
      statusLabel = 'Paid';
    } else if (isOverdue) {
      statusColor = AppColors.statusOverdue;
      statusBg = AppColors.statusOverdueBackground;
      statusLabel = 'Overdue';
    } else {
      statusColor = AppColors.statusActive;
      statusBg = AppColors.statusActiveBackground;
      statusLabel = 'Active';
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.screenPadding,
        0,
        AppSpacing.screenPadding,
        AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: isPaid
            ? AppColors.cardSurface.withOpacity(0.7)
            : isOverdue
                ? AppColors.statusOverdueBackground.withOpacity(0.3)
                : AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(
          color: isOverdue
              ? AppColors.expenseRed.withOpacity(0.4)
              : AppColors.borderLight,
        ),
      ),
      child: InkWell(
        onTap: () => setState(() => _isExpanded = !_isExpanded),
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Collapsed Header (~50px) ──
              Row(
                children: [
                  // Initial Avatar chip
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: isGiven
                          ? AppColors.incomeGreen.withOpacity(0.12)
                          : AppColors.expenseRed.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        loan.name.isNotEmpty ? loan.name[0].toUpperCase() : 'L',
                        style: AppTextStyles.h3.copyWith(
                          color: isGiven
                              ? AppColors.incomeGreen
                              : AppColors.expenseRed,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Name + Direction Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loan.name,
                          style: AppTextStyles.h3.copyWith(
                            fontSize: 14,
                            decoration:
                                isPaid ? TextDecoration.lineThrough : null,
                            color: isPaid ? AppColors.mutedText : null,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              isGiven ? 'Owed to you' : 'You owe',
                              style: AppTextStyles.caption.copyWith(
                                color: isGiven
                                    ? AppColors.incomeGreen
                                    : AppColors.expenseRed,
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                            ),
                            if (loan.repaymentDate != null && !isPaid) ...[
                              Text(' · ', style: AppTextStyles.caption),
                              Text(
                                isOverdue
                                    ? 'Overdue (${daysLeft?.abs()}d)'
                                    : 'Due ${DateFormat('d MMM').format(loan.repaymentDate!)}',
                                style: AppTextStyles.caption.copyWith(
                                  color: isOverdue
                                      ? AppColors.expenseRed
                                      : AppColors.mutedText,
                                  fontWeight:
                                      isOverdue ? FontWeight.bold : null,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Amount + Status Pill + Chevron
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '₹${fmt.format(loan.currentTotal)}',
                            style: AppTextStyles.h3.copyWith(
                              fontSize: 14,
                              color: isGiven
                                  ? AppColors.incomeGreen
                                  : AppColors.expenseRed,
                              decoration:
                                  isPaid ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 1.5),
                            decoration: BoxDecoration(
                              color: statusBg,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              statusLabel,
                              style: AppTextStyles.caption.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        color: AppColors.mutedText,
                      ),
                    ],
                  ),
                ],
              ),

              // ── Expanded Content (On Tap) ──
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(height: 1, color: AppColors.borderLight),
                      const SizedBox(height: 10),
                      // Stats Row
                      Row(
                        children: [
                          Expanded(
                            child: _LoanStat(
                              label: 'Principal',
                              value: '₹${fmt.format(loan.principal)}',
                            ),
                          ),
                          Expanded(
                            child: _LoanStat(
                              label: 'Total Owed',
                              value: '₹${fmt.format(loan.currentTotal)}',
                              valueStyle: AppTextStyles.h3.copyWith(
                                fontSize: 13,
                                color: isGiven
                                    ? AppColors.incomeGreen
                                    : AppColors.expenseRed,
                              ),
                            ),
                          ),
                          if (loan.repaymentDate != null)
                            Expanded(
                              child: _LoanStat(
                                label: 'Due Date',
                                value: DateFormat('d MMM yyyy')
                                    .format(loan.repaymentDate!),
                              ),
                            ),
                        ],
                      ),
                      if (loan.notes.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.inputFill,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            loan.notes,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primaryNavy,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 10),
                      // Action buttons: Mark Paid, Edit, Delete (Delete ALWAYS available)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Delete action button
                          GestureDetector(
                            onTap: _handleDelete,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.expenseRed.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.delete_outline_rounded,
                                      size: 13, color: AppColors.expenseRed),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Delete',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.expenseRed,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Edit button
                              GestureDetector(
                                onTap: () => showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (_) => AddLoanSheet(loan: loan),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.inputFill,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.edit_rounded,
                                          size: 13,
                                          color: AppColors.primaryNavy),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Edit',
                                        style: AppTextStyles.caption.copyWith(
                                          color: AppColors.primaryNavy,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Toggle Paid / Active button
                              GestureDetector(
                                onTap: _handleTogglePaid,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: isPaid
                                        ? AppColors.inputFill
                                        : AppColors.incomeGreen,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    isPaid ? 'Mark Active' : 'Mark Paid',
                                    style: AppTextStyles.caption.copyWith(
                                      color: isPaid
                                          ? AppColors.primaryNavy
                                          : Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoanStat extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;

  const _LoanStat({
    required this.label,
    required this.value,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.caption),
        const SizedBox(height: 2),
        Text(
          value,
          style: valueStyle ?? AppTextStyles.h3,
        ),
      ],
    );
  }
}


class _SummaryCard extends StatelessWidget {
  final String label;
  final String amount;
  final Color color;
  final Color bgColor;

  const _SummaryCard({
    required this.label,
    required this.amount,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: AppTextStyles.caption.copyWith(color: color)),
          const SizedBox(height: 4),
          Text(amount,
              style: AppTextStyles.h2.copyWith(color: color)),
        ],
      ),
    );
  }
}

class _EmptySection extends StatelessWidget {
  final String type;
  const _EmptySection({required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding, vertical: AppSpacing.md),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Center(
          child: Text(
            type == 'taken'
                ? 'No loans taken — you\'re debt free! 🎉'
                : 'No loans given out',
            style: AppTextStyles.bodySmall,
          ),
        ),
      ),
    );
  }
}
