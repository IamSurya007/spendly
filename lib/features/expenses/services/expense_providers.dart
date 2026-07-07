import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/firebase_service.dart';
import '../models/expense_model.dart';

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

/// Stream of all expenses for the current user, newest first.
final expensesStreamProvider = StreamProvider<List<Expense>>((ref) {
  final service = ref.watch(firestoreServiceProvider);
  return service.expensesStream();
});

/// Current month's budget categories.
final budgetProvider =
    FutureProvider<Map<String, Map<String, dynamic>>>((ref) async {
  final service = ref.watch(firestoreServiceProvider);
  final now = DateTime.now();
  final month = '${now.year}-${now.month.toString().padLeft(2, '0')}';
  return service.getBudgetForMonth(month);
});

/// Notifier to add/delete expenses.
class ExpenseNotifier extends StateNotifier<AsyncValue<void>> {
  ExpenseNotifier(this._service) : super(const AsyncValue.data(null));

  final FirestoreService _service;

  Future<void> addExpense(Expense expense) async {
    state = const AsyncValue.loading();
    try {
      await _service.addExpense(expense);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteExpense(String id) async {
    await _service.deleteExpense(id);
  }
}

final expenseNotifierProvider =
    StateNotifierProvider<ExpenseNotifier, AsyncValue<void>>((ref) {
  final service = ref.watch(firestoreServiceProvider);
  return ExpenseNotifier(service);
});

/// Computed: total income (credit) for the current month.
final monthlyIncomeProvider = Provider<double>((ref) {
  final expenses = ref.watch(expensesStreamProvider).valueOrNull ?? [];
  final now = DateTime.now();
  return expenses
      .where((e) => e.date.year == now.year && e.date.month == now.month)
      .where((e) => e.amount < 0) // negative = credit in this model
      .fold(0.0, (sum, e) => sum + e.amount.abs());
});

/// Computed: total expenses for the current month.
final monthlyExpensesProvider = Provider<double>((ref) {
  final expenses = ref.watch(expensesStreamProvider).valueOrNull ?? [];
  final now = DateTime.now();
  return expenses
      .where((e) => e.date.year == now.year && e.date.month == now.month)
      .where((e) => e.amount > 0)
      .fold(0.0, (sum, e) => sum + e.amount);
});
