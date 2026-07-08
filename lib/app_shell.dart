import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/widgets/app_bottom_nav.dart';
import 'core/constants/app_colors.dart';
import 'core/providers/repository_providers.dart';
import 'core/services/sms_parser_service.dart';
import 'features/expenses/screens/add_expense_sheet.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/expenses/screens/expenses_screen.dart';
import 'features/loans/screens/loans_screen.dart';
import 'features/investments/screens/investments_screen.dart';

/// Top-level authenticated shell — holds the floating nav + 5 screens.
/// Nav index → page:
///   0 → Home
///   1 → Budget/Expenses
///   2 → (FAB — no screen, opens bottom sheet)
///   3 → Loans
///   4 → Investments
///
/// Uses [IndexedStack] so every page stays alive in memory.
/// Tab switching is a pure visibility toggle — zero widget rebuild,
/// zero flash.
class AppShell extends ConsumerStatefulWidget {
  final User user;

  const AppShell({super.key, required this.user});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  int _currentIndex = 0;
  final _smsService = SmsParserService();

  // Nav index 2 is the FAB — map it to page 0 so the stack index is always valid.
  // Real page indices: 0→Home, 1→Expenses, 2→Loans, 3→Investments
  static int _navToStack(int navIndex) {
    const map = {0: 0, 1: 1, 2: 0, 3: 2, 4: 3};
    return map[navIndex] ?? 0;
  }

  @override
  void initState() {
    super.initState();
    _initSmsCapture();
  }

  void _initSmsCapture() async {
    // Listen for live SMS transactions captured while app is open
    _smsService.setIncomingTransactionListener((txn) async {
      final ruleCategory = await ref.read(expenseRepositoryProvider).getMerchantRule(txn.merchant);
      
      if (mounted) {
        _openAddExpense(
          prefilledAmount: txn.amount,
          prefilledMerchant: txn.merchant,
          prefilledNote: 'Auto-captured from SMS',
          prefilledCategory: ruleCategory ?? (txn.isDebit ? 'Spends' : 'Other'),
          prefilledMethod: 'upi',
          prefilledIsCredit: !txn.isDebit,
        );
      }
    });

    // Check for pending notification tap transactions
    final pending = await _smsService.getPendingTransaction();
    if (pending != null) {
      final ruleCategory = await ref.read(expenseRepositoryProvider).getMerchantRule(pending.merchant);
      
      if (mounted) {
        _openAddExpense(
          prefilledAmount: pending.amount,
          prefilledMerchant: pending.merchant,
          prefilledNote: 'Auto-captured from SMS',
          prefilledCategory: ruleCategory ?? (pending.isDebit ? 'Spends' : 'Other'),
          prefilledMethod: 'upi',
          prefilledIsCredit: !pending.isDebit,
        );
      }
    }
  }

  void _handleNavTap(int index) {
    if (index == 2) {
      _openAddExpense();
      return;
    }
    setState(() => _currentIndex = index);
  }

  void _openAddExpense({
    double? prefilledAmount,
    String? prefilledCategory,
    String? prefilledNote,
    String? prefilledMerchant,
    String? prefilledMethod,
    bool? prefilledIsCredit,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddExpenseSheet(
        prefilledAmount: prefilledAmount,
        prefilledCategory: prefilledCategory,
        prefilledNote: prefilledNote,
        prefilledMerchant: prefilledMerchant,
        prefilledMethod: prefilledMethod,
        prefilledIsCredit: prefilledIsCredit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      extendBody: true,
      body: IndexedStack(
        index: _navToStack(_currentIndex),
        children: [
          HomeScreen(
            user: widget.user,
            onSeeAll: () => setState(() => _currentIndex = 1),
          ),
          const ExpensesScreen(),
          const LoansScreen(),
          const InvestmentsScreen(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTap: _handleNavTap,
        onAddTap: _openAddExpense,
      ),
    );
  }
}
