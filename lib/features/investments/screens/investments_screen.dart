import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/confirm_delete_dialog.dart';
import '../models/investment_model.dart';
import '../services/investment_providers.dart';
import 'add_investment_sheet.dart';

class InvestmentsScreen extends ConsumerWidget {
  const InvestmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final investmentsAsync = ref.watch(investmentsStreamProvider);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        bottom: false,
        child: investmentsAsync.when(
          skipLoadingOnRefresh: true,
          skipLoadingOnReload: true,
          data: (investments) {
            final totalPrincipal =
                investments.fold(0.0, (s, i) => s + i.principal);
            final totalMaturity =
                investments.fold(0.0, (s, i) => s + i.maturityAmount);
            final fmt = NumberFormat('#,##,###');
  
            return CustomScrollView(
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
                        Text('Investments', style: AppTextStyles.h1),
                        GestureDetector(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => const AddInvestmentSheet(),
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

              // ── Summary banner ──
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding),
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1A7A4A), Color(0xFF0D5C37)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius:
                        BorderRadius.circular(AppSpacing.cardRadius),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Invested',
                              style: AppTextStyles.caption.copyWith(
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₹${fmt.format(totalPrincipal)}',
                              style: AppTextStyles.h2
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          width: 0.5,
                          height: 40,
                          color: Colors.white.withOpacity(0.3),
                          margin: const EdgeInsets.symmetric(horizontal: 16)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'At Maturity',
                              style: AppTextStyles.caption.copyWith(
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₹${fmt.format(totalMaturity)}',
                              style: AppTextStyles.h2
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.lg)),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding),
                  child: Text('Your RDs & Investments',
                      style: AppTextStyles.h2),
                ),
              ),

              const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.sm)),

              if (investments.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Center(
                      child: Column(
                        children: [
                          const Text('📈',
                              style: TextStyle(fontSize: 36)),
                          const SizedBox(height: AppSpacing.sm),
                          Text('No investments yet',
                              style: AppTextStyles.h3),
                          Text('Start your first RD!',
                              style: AppTextStyles.caption),
                        ],
                      ),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) {
                      final inv = investments[i];
                      return GestureDetector(
                        onTap: () => showModalBottomSheet(
                          context: ctx,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => AddInvestmentSheet(investment: inv),
                        ),
                        child: InvestmentCard(investment: inv),
                      );
                    },
                    childCount: investments.length,
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.accent),
        ),
        error: (e, _) => Center(
          child: Text('Error: $e', style: AppTextStyles.bodySmall),
        ),
        ),
      ),
    );
  }
}

/// UI RESEARCH NOTE: Recurring Deposit & Investment Tracking Pattern
/// ------------------------------------------------------------------
/// Modern wealth apps (Fold Money, Axio) structure concurrent investment lists to scale
/// across multiple active RDs (RD1, RD2, RD3) without clutter:
/// 1. Institution Avatar & Type Pill: Quick visual identification (e.g. HDFC Bank · RD).
/// 2. 3-Column Metric Matrix: Monthly contribution, Principal invested to-date, Maturity target.
/// 3. Visual Yield Badge: Expected returns (e.g. +₹12,400 / 8.2% returns).
/// 4. Dynamic Tenure Progress: Completed tenure percentage bar + days/months to maturity footer.
/// 5. Explicit Actions: Non-intrusive delete action via confirm modal to prevent accidental loss.
class InvestmentCard extends ConsumerStatefulWidget {
  final Investment investment;

  const InvestmentCard({super.key, required this.investment});

  @override
  ConsumerState<InvestmentCard> createState() => _InvestmentCardState();
}

class _InvestmentCardState extends ConsumerState<InvestmentCard> {
  bool _isExpanded = false;

  Future<void> _handleDelete() async {
    final confirmed = await ConfirmDeleteDialog.show(
      context,
      title: 'Delete Investment',
      content:
          'Are you sure you want to delete "${widget.investment.name}"? This action cannot be undone.',
      confirmLabel: 'Delete',
    );

    if (confirmed) {
      ref
          .read(investmentNotifierProvider.notifier)
          .deleteInvestment(widget.investment.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final investment = widget.investment;
    final fmt = NumberFormat('#,##,###');
    final daysLeft = investment.daysToMaturity;
    final progress = investment.progressFraction;
    final gains = investment.maturityAmount - investment.principal;
    final gainPct =
        investment.principal > 0 ? (gains / investment.principal * 100) : 0.0;

    String daysLabel;
    if (daysLeft == 0) {
      daysLabel = 'Matured today! 🎉';
    } else if (daysLeft <= 30) {
      daysLabel = '$daysLeft days left';
    } else {
      final months = (daysLeft / 30).floor();
      daysLabel = '$months months left';
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.screenPadding,
        0,
        AppSpacing.screenPadding,
        AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.borderLight),
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
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.incomeGreen.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        investment.name.isNotEmpty
                            ? investment.name[0].toUpperCase()
                            : 'I',
                        style: AppTextStyles.h3.copyWith(
                          color: AppColors.incomeGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Name + Institution
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          investment.name,
                          style: AppTextStyles.h3.copyWith(fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              investment.institution.isNotEmpty
                                  ? investment.institution
                                  : 'Investment',
                              style: AppTextStyles.caption.copyWith(fontSize: 11),
                            ),
                            Text(' · ', style: AppTextStyles.caption),
                            Text(
                              daysLabel,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.incomeGreen,
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Maturity Target + Type Pill + Chevron
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '₹${fmt.format(investment.maturityAmount)}',
                            style: AppTextStyles.h3.copyWith(
                              fontSize: 14,
                              color: AppColors.incomeGreen,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 1.5),
                            decoration: BoxDecoration(
                              color: AppColors.statusActiveBackground,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              investment.type.toUpperCase(),
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.incomeGreen,
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

              // ── Expanded Details (On Tap) ──
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(height: 1, color: AppColors.borderLight),
                      const SizedBox(height: 10),

                      // 3-Column Stats Matrix
                      Row(
                        children: [
                          Expanded(
                            child: _InvStat(
                              label: 'Monthly',
                              value: '₹${fmt.format(investment.monthlyAmount)}',
                            ),
                          ),
                          Expanded(
                            child: _InvStat(
                              label: 'Principal',
                              value: '₹${fmt.format(investment.principal)}',
                            ),
                          ),
                          Expanded(
                            child: _InvStat(
                              label: 'At Maturity',
                              value: '₹${fmt.format(investment.maturityAmount)}',
                              valueColor: AppColors.incomeGreen,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Yield badge & progress bar
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '+₹${fmt.format(gains)} (${gainPct.toStringAsFixed(1)}% yield)',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.incomeGreen,
                                fontWeight: FontWeight.w700,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Matures ${DateFormat('d MMM yyyy').format(investment.maturityDate)}',
                            style: AppTextStyles.caption.copyWith(fontSize: 11),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progress.clamp(0.0, 1.0),
                          backgroundColor: AppColors.inputFill,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.incomeGreen),
                          minHeight: 5,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Action Buttons: Edit, Delete
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

                          // Edit button
                          GestureDetector(
                            onTap: () => showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => AddInvestmentSheet(investment: investment),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.inputFill,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.edit_rounded,
                                      size: 13, color: AppColors.primaryNavy),
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

class _InvStat extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InvStat({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.caption),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTextStyles.h3
              .copyWith(color: valueColor ?? AppColors.primaryNavy),
        ),
      ],
    );
  }
}
