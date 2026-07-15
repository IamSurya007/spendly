import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/widgets/app_bottom_nav.dart';
import 'core/constants/app_colors.dart';
import 'core/providers/repository_providers.dart';
import 'core/services/sms_parser_service.dart';
import 'features/expenses/screens/add_expense_sheet.dart';
import 'features/expenses/models/expense_model.dart';
import 'features/expenses/services/expense_providers.dart';
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

  @override
  void initState() {
    super.initState();
    _initSmsCapture();
  }

  void _initSmsCapture() async {
    // Listen for live SMS transactions captured while app is open
    _smsService.setIncomingTransactionListener((txn) async {
      await _autoSaveSmsTransaction(txn);
    });

    // Check for pending notification tap transactions
    final pending = await _smsService.getPendingTransaction();
    if (pending != null) {
      await _autoSaveSmsTransaction(pending);
    }
  }

  Future<void> _autoSaveSmsTransaction(ParsedSms txn) async {
    final expenseRepo = ref.read(expenseRepositoryProvider);
    final ruleCategory = await expenseRepo.getMerchantRule(txn.merchant);
    
    // Heuristics mapping to new category names
    String category = ruleCategory ?? (txn.isDebit ? 'Spends' : 'Other');
    if (ruleCategory == null) {
      final cleanMerchant = txn.merchant.toLowerCase();
      if (cleanMerchant.contains('rent')) {
        category = 'Rent';
      } else if (cleanMerchant.contains('swiggy') || cleanMerchant.contains('zomato') || cleanMerchant.contains('dining') || cleanMerchant.contains('restaurant') || cleanMerchant.contains('eats')) {
        category = 'Restaurants';
      } else if (cleanMerchant.contains('grocer') || cleanMerchant.contains('jiomart') || cleanMerchant.contains('blinkit') || cleanMerchant.contains('bigbasket')) {
        category = 'Groceries';
      } else if (cleanMerchant.contains('coffee') || cleanMerchant.contains('starbucks') || cleanMerchant.contains('chai')) {
        category = 'Coffee & Snacks';
      } else if (cleanMerchant.contains('electricity') || cleanMerchant.contains('power')) {
        category = 'Electricity';
      } else if (cleanMerchant.contains('water')) {
        category = 'Water Bill';
      } else if (cleanMerchant.contains('gas') || cleanMerchant.contains('indane') || cleanMerchant.contains('hp')) {
        category = 'Gas';
      } else if (cleanMerchant.contains('wifi') || cleanMerchant.contains('internet') || cleanMerchant.contains('actfibernet') || cleanMerchant.contains('broadband')) {
        category = 'Internet';
      } else if (cleanMerchant.contains('ola') || cleanMerchant.contains('uber') || cleanMerchant.contains('cab') || cleanMerchant.contains('auto')) {
        category = 'Auto / Cab';
      } else if (cleanMerchant.contains('metro') || cleanMerchant.contains('bus') || cleanMerchant.contains('train') || cleanMerchant.contains('irctc')) {
        category = 'Public Transport';
      } else if (cleanMerchant.contains('fuel') || cleanMerchant.contains('petrol') || cleanMerchant.contains('shell') || cleanMerchant.contains('iocl') || cleanMerchant.contains('hpcl')) {
        category = 'Fuel';
      } else if (cleanMerchant.contains('cc bill') || cleanMerchant.contains('credit card') || cleanMerchant.contains('card bill')) {
        category = 'CC Bill';
      } else if (cleanMerchant.contains('splitwise')) {
        category = 'Splitwise';
      }
    }

    final savedAmount = txn.isDebit ? txn.amount : -txn.amount;

    final expense = Expense(
      id: 'exp_sms_${txn.date.millisecondsSinceEpoch}',
      amount: savedAmount,
      category: category,
      note: 'Auto-captured from SMS',
      date: txn.date,
      method: 'upi',
      merchant: txn.merchant,
      createdAt: DateTime.now(),
    );

    // Save mapping rule if it didn't exist
    if (txn.merchant.isNotEmpty && ruleCategory == null) {
      await ref.read(expenseNotifierProvider.notifier).setMerchantRule(txn.merchant, category);
    }

    await ref.read(expenseNotifierProvider.notifier).addExpense(expense);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Auto-saved: ₹${txn.amount} ${txn.isDebit ? "spent" : "received"} at ${txn.merchant} ($category)',
          ),
          backgroundColor: AppColors.primaryNavy,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          action: SnackBarAction(
            label: 'EDIT',
            textColor: Colors.white,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => AddExpenseSheet(expense: expense),
              );
            },
          ),
        ),
      );
    }
  }

  void _handleNavTap(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
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
      ),
    );
  }
}
