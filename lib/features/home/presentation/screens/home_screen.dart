import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/transaction_tile.dart';
import '../../../expenses/screens/add_expense_sheet.dart';
import '../../../expenses/screens/sms_scan_sheet.dart';
import '../../../loans/screens/add_loan_sheet.dart';
import '../../../investments/screens/add_investment_sheet.dart';
import '../../../expenses/services/expense_providers.dart';
import '../../../loans/services/loan_providers.dart';
import '../../../investments/services/investment_providers.dart';
import '../../../../core/services/excel_export_service.dart';
import '../widgets/balance_card.dart';
import '../widgets/quick_actions.dart';

class HomeScreen extends ConsumerWidget {
  final User user;
  final VoidCallback onSeeAll;

  const HomeScreen({
    super.key,
    required this.user,
    required this.onSeeAll,
  });

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  String _firstName() {
    final name = user.displayName ?? '';
    return name.split(' ').first;
  }

  Future<void> _handleExport(BuildContext context, WidgetRef ref) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Generating Excel report...'),
        duration: Duration(seconds: 2),
      ),
    );

    try {
      final expenses = ref.read(expensesStreamProvider).valueOrNull ?? [];
      final loans = ref.read(loansStreamProvider).valueOrNull ?? [];
      final investments = ref.read(investmentsStreamProvider).valueOrNull ?? [];

      await ExcelExportService.exportDataToExcel(
        expenses: expenses,
        loans: loans,
        investments: investments,
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: ${e.toString()}'),
            backgroundColor: AppColors.expenseRed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesAsync = ref.watch(expensesStreamProvider);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // ── Header ────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenPadding,
                  AppSpacing.lg,
                  AppSpacing.screenPadding,
                  AppSpacing.md,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _greeting(),
                            style: AppTextStyles.greeting,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _firstName(),
                            style: AppTextStyles.h1,
                          ),
                        ],
                      ),
                    ),
                    // Avatar
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.inputFill,
                      backgroundImage: user.photoURL != null
                          ? NetworkImage(user.photoURL!)
                          : null,
                      child: user.photoURL == null
                          ? Text(
                              _firstName().isNotEmpty
                                  ? _firstName()[0].toUpperCase()
                                  : 'U',
                              style: AppTextStyles.h3.copyWith(
                                color: AppColors.accent,
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
  
            // ── Balance Card ──────────────────────────
            SliverToBoxAdapter(
              child: BalanceCard(user: user),
            ),
  
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),
  
            // ── Quick Actions ─────────────────────────
            SliverToBoxAdapter(
              child: QuickActions(
                onAddExpense: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const AddExpenseSheet(),
                ),
                onScanSms: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const SmsScanSheet(),
                ),
                onAddLoan: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const AddLoanSheet(),
                ),
                onAddInvestment: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const AddInvestmentSheet(),
                ),
                onExport: () => _handleExport(context, ref),
              ),
            ),
  
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),
  
            // ── Recent Transactions header ─────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recent Transactions', style: AppTextStyles.h2),
                    GestureDetector(
                      onTap: onSeeAll,
                      child: Text(
                        'See all',
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
  
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

          // ── Transactions list ─────────────────────
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: expensesAsync.when(
                data: (expenses) {
                  if (expenses.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Column(
                        children: [
                          const Text('💸', style: TextStyle(fontSize: 36)),
                          const SizedBox(height: AppSpacing.sm),
                          Text('No transactions yet',
                              style: AppTextStyles.h3),
                          const SizedBox(height: 4),
                          Text(
                            'Tap + to add your first expense',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    );
                  }
                  final recent = expenses.take(5).toList();
                  return Column(
                    children: [
                      for (int i = 0; i < recent.length; i++) ...[
                        TransactionTile(
                          expense: recent[i],
                          onTap: () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => AddExpenseSheet(expense: recent[i]),
                          ),
                        ),
                        if (i < recent.length - 1)
                          const Divider(
                            height: 1,
                            indent: AppSpacing.screenPadding + 44 + AppSpacing.md,
                            endIndent: AppSpacing.screenPadding,
                            color: AppColors.borderLight,
                          ),
                      ]
                    ],
                  );
                },
                loading: () => const Padding(
                  padding: EdgeInsets.all(AppSpacing.xl),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.accent,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                error: (e, _) => Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Text('Could not load transactions',
                      style: AppTextStyles.bodySmall),
                ),
              ),
            ),
          ),

          // ── Bottom padding for nav bar ─────────────
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    ),
  );
}
}
