import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'core/widgets/app_bottom_nav.dart';
import 'core/constants/app_colors.dart';
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
class AppShell extends StatefulWidget {
  final User user;

  const AppShell({super.key, required this.user});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  // Nav index 2 is the FAB — map it to page 0 so the stack index is always valid.
  // Real page indices: 0→Home, 1→Expenses, 2→Loans, 3→Investments
  static int _navToStack(int navIndex) {
    const map = {0: 0, 1: 1, 2: 0, 3: 2, 4: 3};
    return map[navIndex] ?? 0;
  }

  void _handleNavTap(int index) {
    if (index == 2) {
      _openAddExpense();
      return;
    }
    setState(() => _currentIndex = index);
  }

  void _openAddExpense() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddExpenseSheet(),
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
          HomeScreen(user: widget.user),
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
