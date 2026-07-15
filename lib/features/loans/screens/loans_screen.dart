import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
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

class LoanCard extends ConsumerWidget {
  final Loan loan;

  const LoanCard({super.key, required this.loan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fmt = NumberFormat('#,##,###');
    final isGiven = loan.type == 'given';
    final daysLeft = loan.daysRemaining;

    Color statusColor;
    Color statusBg;
    String statusLabel;

    if (loan.status == 'paid') {
      statusColor = AppColors.statusPaid;
      statusBg = AppColors.statusPaidBackground;
      statusLabel = 'Paid';
    } else if (loan.status == 'overdue' || loan.isOverdue) {
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
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar initial
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isGiven
                      ? AppColors.statusActiveBackground
                      : const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    loan.name[0].toUpperCase(),
                    style: AppTextStyles.h2.copyWith(
                      color: isGiven
                          ? AppColors.incomeGreen
                          : AppColors.expenseRed,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm + 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(loan.name, style: AppTextStyles.h3),
                    if (loan.notes.isNotEmpty)
                      Text(loan.notes, style: AppTextStyles.caption),
                  ],
                ),
              ),
              // Status chip
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusLabel,
                  style: AppTextStyles.caption.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Amount row
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
                  label: 'Total',
                  value: '₹${fmt.format(loan.currentTotal)}',
                  valueStyle: AppTextStyles.h3.copyWith(
                    color: isGiven
                        ? AppColors.incomeGreen
                        : AppColors.expenseRed,
                  ),
                ),
              ),
              if (daysLeft != null && loan.status != 'paid')
                Expanded(
                  child: _LoanStat(
                    label: daysLeft >= 0 ? 'Days left' : 'Days overdue',
                    value: '${daysLeft.abs()}d',
                    valueStyle: AppTextStyles.h3.copyWith(
                      color: daysLeft < 0
                          ? AppColors.expenseRed
                          : daysLeft <= 7
                              ? const Color(0xFFE07B00)
                              : AppColors.primaryNavy,
                    ),
                  ),
                ),
            ],
          ),
          if (loan.repaymentDate != null && loan.status != 'paid') ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                const Icon(Icons.calendar_today_rounded,
                    size: 12, color: AppColors.mutedText),
                const SizedBox(width: 4),
                Text(
                  'Due ${DateFormat('d MMM yyyy').format(loan.repaymentDate!)}',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ],
          if (loan.status != 'paid') ...[
            const SizedBox(height: AppSpacing.sm),
            const Divider(color: AppColors.borderLight, height: 1),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _ActionButton(
                  label: 'Mark Paid',
                  onTap: () {
                    final paidLoan = loan.copyWith(
                      status: 'paid',
                      total: loan.currentTotal,
                    );
                    ref
                        .read(loanNotifierProvider.notifier)
                        .updateLoan(paidLoan);
                  },
                ),
              ],
            ),
          ],
        ],
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

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _ActionButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: AppColors.inputFill,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Text(
          label,
          style: AppTextStyles.label.copyWith(
            color: AppColors.incomeGreen,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
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
