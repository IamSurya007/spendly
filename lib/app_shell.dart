import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/widgets/app_bottom_nav.dart';
import 'core/constants/app_colors.dart';
import 'core/providers/repository_providers.dart';
import 'core/services/sms_parser_service.dart';
import 'core/services/sms_import_service.dart';
import 'features/expenses/services/expense_providers.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/expenses/screens/expenses_screen.dart';
import 'features/loans/screens/loans_screen.dart';
import 'features/investments/screens/investments_screen.dart';
import 'features/profile/screens/profile_screen.dart';

/// Top-level authenticated shell — holds the floating nav + 5 screens.
/// Nav index → page:
///   0 → Home
///   1 → Budget/Expenses
///   2 → Loans
///   3 → Investments
///   4 → Profile
///
/// Uses [IndexedStack] so every page stays alive in memory.
/// Tab switching is a pure visibility toggle — zero widget rebuild, zero flash.
class AppShell extends ConsumerStatefulWidget {
  final User user;

  const AppShell({super.key, required this.user});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell>
    with WidgetsBindingObserver {
  int _currentIndex = 0;
  final _smsService = SmsParserService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initSmsCapture();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _processPendingTransactions();
    }
  }

  void _initSmsCapture() async {
    // Listen for live SMS transactions captured while app is open
    _smsService.setIncomingTransactionListener((txn) async {
      await _autoSaveSmsTransaction(txn);
    });

    // Check and auto-save any pending background SMS transactions
    await _processPendingTransactions();
  }

  static const int _batchToastThreshold = 3;

  Future<void> _processPendingTransactions() async {
    final pendingList = await _smsService.getPendingTransactions();
    if (pendingList.isEmpty) return;

    if (pendingList.length >= _batchToastThreshold) {
      // Save all transactions silently
      var saved = 0;
      for (final txn in pendingList) {
        if (await _autoSaveSmsTransaction(txn, showToast: false)) saved++;
      }
      await _smsService.clearPendingTransactions();

      if (mounted && saved > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('⚡ $saved new transactions synced'),
            backgroundColor: AppColors.primaryNavy,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            action: SnackBarAction(
              label: 'VIEW',
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ExpensesScreen()),
                );
              },
            ),
          ),
        );
      }
    } else {
      for (final txn in pendingList) {
        await _autoSaveSmsTransaction(txn, showToast: true);
      }
      await _smsService.clearPendingTransactions();
    }
  }

  /// Returns true if a new expense was saved (false for duplicates).
  Future<bool> _autoSaveSmsTransaction(ParsedSms txn, {bool showToast = true}) async {
    final importer = SmsImportService(
      ref.read(expenseRepositoryProvider),
      ref.read(accountRepositoryProvider),
    );
    final expense = await importer.import(txn, note: 'Auto-captured from SMS');
    if (expense == null) return false;

    if (showToast && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${txn.isDebit ? '💸' : '💰'} ${txn.isDebit ? 'Saved' : 'Received'} · ₹${txn.amount.toStringAsFixed(0)} · ${txn.merchant}',
          ),
          backgroundColor: AppColors.primaryNavy,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          action: SnackBarAction(
            label: 'UNDO',
            textColor: Colors.white,
            onPressed: () async {
              await ref
                  .read(expenseNotifierProvider.notifier)
                  .deleteExpense(expense.id);
            },
          ),
        ),
      );
    }
    return true;
  }

  void _handleNavTap(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_currentIndex != 0) {
          setState(() => _currentIndex = 0);
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        extendBody: true,
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              user: widget.user,
              onSeeAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ExpensesScreen()),
                );
              },
              onProfileTap: () => setState(() => _currentIndex = 3),
            ),
            const LoansScreen(),
            const InvestmentsScreen(),
            ProfileScreen(user: widget.user),
          ],
        ),
        bottomNavigationBar: AppBottomNav(
          currentIndex: _currentIndex,
          onTap: _handleNavTap,
        ),
      ),
    );
  }
}
