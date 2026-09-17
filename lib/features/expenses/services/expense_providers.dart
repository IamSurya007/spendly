import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/repository_providers.dart';
import '../../../core/repositories/i_expense_repository.dart';
import '../models/expense_model.dart';

/// Real-time stream of all expenses, newest first.
final expensesStreamProvider = StreamProvider<List<Expense>>((ref) {
  return ref.watch(expenseRepositoryProvider).watchExpenses();
});

/// Budget category limits — loaded from persistent key so limits carry over every month.
final budgetProvider =
    FutureProvider<Map<String, Map<String, dynamic>>>((ref) async {
  return ref.watch(expenseRepositoryProvider).getBudgetForMonth('all');
});

/// Mutates expenses via [IExpenseRepository].
class ExpenseNotifier extends StateNotifier<AsyncValue<void>> {
  ExpenseNotifier(this._repo) : super(const AsyncValue.data(null));

  final IExpenseRepository _repo;

  Future<void> addExpense(Expense expense) async {
    try {
      await _repo.addExpense(expense);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateExpense(Expense expense) async {
    try {
      await _repo.updateExpense(expense);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteExpense(String id) async {
    await _repo.deleteExpense(id);
  }

  Future<void> setMerchantRule(String merchant, String category) async {
    try {
      await _repo.setMerchantRule(merchant, category);
    } catch (_) {}
  }

  Future<void> updateExpensesCategory(String merchant, String newCategory) async {
    state = const AsyncValue.loading();
    try {
      await _repo.updateExpensesCategory(merchant, newCategory);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateBudgetLimit(String category, double limit) async {
    state = const AsyncValue.loading();
    try {
      // Use 'all' key so limits persist across months
      const month = 'all';
      final currentBudget = await _repo.getBudgetForMonth(month);

      final updatedCategoryData = Map<String, dynamic>.from(currentBudget[category] ?? {'spent': 0.0});
      updatedCategoryData['limit'] = limit;

      currentBudget[category] = updatedCategoryData;
      await _repo.setBudgetForMonth(month, currentBudget);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteBudgetCategory(String category) async {
    state = const AsyncValue.loading();
    try {
      const month = 'all';
      final currentBudget = await _repo.getBudgetForMonth(month);
      currentBudget.remove(category);
      await _repo.setBudgetForMonth(month, currentBudget);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final expenseNotifierProvider =
    StateNotifierProvider<ExpenseNotifier, AsyncValue<void>>((ref) {
  return ExpenseNotifier(ref.watch(expenseRepositoryProvider));
});

/// Computed: total income (credit) for the current month (excludes isCountedAsSpend=false).
final monthlyIncomeProvider = Provider<double>((ref) {
  final expenses = ref.watch(expensesStreamProvider).valueOrNull ?? [];
  final now = DateTime.now();
  return expenses
      .where((e) => e.date.year == now.year && e.date.month == now.month)
      .where((e) => e.amount < 0 && e.isCountedAsSpend) // negative = credit/income
      .fold(0.0, (sum, e) => sum + e.amount.abs());
});

/// Computed: total counted spends for the current month (excludes isCountedAsSpend=false).
final monthlyExpensesProvider = Provider<double>((ref) {
  final expenses = ref.watch(expensesStreamProvider).valueOrNull ?? [];
  final now = DateTime.now();
  return expenses
      .where((e) => e.date.year == now.year && e.date.month == now.month)
      .where((e) => e.amount > 0 && e.isCountedAsSpend)
      .fold(0.0, (sum, e) => sum + e.amount);
});

/// Computed: income minus spends this month (positive = surplus).
final monthlyLeftProvider = Provider<double>((ref) {
  final income = ref.watch(monthlyIncomeProvider);
  final spends = ref.watch(monthlyExpensesProvider);
  return income - spends;
});

/// Computed: total transaction count for the current month.
final monthlyTransactionCountProvider = Provider<int>((ref) {
  final expenses = ref.watch(expensesStreamProvider).valueOrNull ?? [];
  final now = DateTime.now();
  return expenses
      .where((e) => e.date.year == now.year && e.date.month == now.month)
      .length;
});
