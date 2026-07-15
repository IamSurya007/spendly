import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
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

class InvestmentCard extends StatelessWidget {
  final Investment investment;

  const InvestmentCard({super.key, required this.investment});

  @override
  Widget build(BuildContext context) {
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
      daysLabel = '$daysLeft days to maturity';
    } else {
      final months = (daysLeft / 30).floor();
      daysLabel = '$months months to maturity';
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
          // Top row: name + type badge
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(investment.name, style: AppTextStyles.h3),
                    if (investment.institution.isNotEmpty)
                      Text(investment.institution,
                          style: AppTextStyles.caption),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.statusActiveBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  investment.type,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.incomeGreen,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Stats row
          Row(
            children: [
              Expanded(
                child: _InvStat(
                    label: 'Monthly',
                    value: '₹${fmt.format(investment.monthlyAmount)}'),
              ),
              Expanded(
                child: _InvStat(
                    label: 'Principal',
                    value: '₹${fmt.format(investment.principal)}'),
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

          const SizedBox(height: AppSpacing.sm),

          // Gains
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.trending_up_rounded,
                    size: 14, color: AppColors.incomeGreen),
                const SizedBox(width: 4),
                Text(
                  'Gains: ₹${fmt.format(gains)} (${gainPct.toStringAsFixed(1)}%)',
                  style: AppTextStyles.caption.copyWith(
                      color: AppColors.incomeGreen,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // Maturity countdown + progress
          Row(
            children: [
              const Icon(Icons.schedule_rounded,
                  size: 13, color: AppColors.mutedText),
              const SizedBox(width: 4),
              Text(daysLabel, style: AppTextStyles.caption),
              const Spacer(),
              Text(
                DateFormat('d MMM yyyy').format(investment.maturityDate),
                style: AppTextStyles.caption,
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.inputFill,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.incomeGreen),
              minHeight: 6,
            ),
          ),
        ],
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
