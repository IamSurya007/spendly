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
  Future<void> deleteExpense(String id);

  /// Budget limits per category for [month] (format: 'yyyy-MM').
  Future<Map<String, Map<String, dynamic>>> getBudgetForMonth(String month);
  Future<void> setBudgetForMonth(
    String month,
    Map<String, Map<String, dynamic>> categories,
  );
}
