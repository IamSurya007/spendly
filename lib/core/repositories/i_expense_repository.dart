import '../../features/categories/models/category.dart';
import '../../features/expenses/models/expense_model.dart';

/// Contract for all expense + budget data operations.
///
/// Implementations:
///   - [FirestoreExpenseRepository]  (current, uses cloud_firestore)
///   - IsarExpenseRepository         (future, offline-first with Isar + REST)
///
/// Providers depend ONLY on this interface. To swap the backend, update
/// [repositoryProviders.dart] — nothing else changes.
abstract interface class IExpenseRepository {
  /// Real-time stream of all expenses, newest first.
  Stream<List<Expense>> watchExpenses();

  Future<void> addExpense(Expense expense);

  /// Ids of every locally stored expense, INCLUDING soft-deleted ones, so a
  /// transaction the user deleted is not offered for re-import.
  Future<Set<String>> getAllExpenseIds();

  /// Expenses with the same signed [amount] within [window] of [date]
  /// (deleted rows included). Used to recognise SMS imported under an older
  /// id scheme.
  Future<List<Expense>> findExpensesNear({
    required double amount,
    required DateTime date,
    Duration window = const Duration(minutes: 3),
  });
  Future<void> updateExpense(Expense expense);
  Future<void> deleteExpense(String id);

  /// Budget limits per category for [month] (format: 'yyyy-MM').
  Future<Map<String, Map<String, dynamic>>> getBudgetForMonth(String month);
  Future<void> setBudgetForMonth(
    String month,
    Map<String, Map<String, dynamic>> categories,
  );

  /// Auto-categorization rule operations
  Future<void> setMerchantRule(String merchant, CategorySelection selection);
  Future<CategorySelection?> getMerchantRule(String merchant);
  Future<void> updateExpensesCategory(String merchant, CategorySelection selection);
}
