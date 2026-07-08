import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/repositories/i_expense_repository.dart';
import '../../models/expense_model.dart';

/// Firestore implementation of [IExpenseRepository].
///
/// Scope: all documents live under `users/{uid}/expenses` and
/// `users/{uid}/budgets`. Firestore offline persistence is enabled globally
/// in [main.dart], so reads and writes work even without network — the SDK
/// queues writes and syncs them when connectivity is restored.
class FirestoreExpenseRepository implements IExpenseRepository {
  final FirebaseFirestore _db;

  FirestoreExpenseRepository({FirebaseFirestore? db})
      : _db = db ?? FirebaseFirestore.instance;

  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  CollectionReference get _expensesRef =>
      _db.collection('users').doc(_uid).collection('expenses');

  CollectionReference get _budgetsRef =>
      _db.collection('users').doc(_uid).collection('budgets');

  @override
  Stream<List<Expense>> watchExpenses() {
    return _expensesRef
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) =>
                Expense.fromJson(doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  @override
  Future<void> addExpense(Expense expense) async {
    await _expensesRef.doc(expense.id).set(expense.toJson());
  }

  @override
  Future<void> deleteExpense(String id) async {
    await _expensesRef.doc(id).delete();
  }

  @override
  Future<Map<String, Map<String, dynamic>>> getBudgetForMonth(
      String month) async {
    final doc = await _budgetsRef.doc(month).get();
    if (!doc.exists) return {};
    final raw = (doc.data() as Map<String, dynamic>)['categories']
        as Map<String, dynamic>? ?? {};
    return raw.map((k, v) => MapEntry(k, v as Map<String, dynamic>));
  }

  @override
  Future<void> setBudgetForMonth(
    String month,
    Map<String, Map<String, dynamic>> categories,
  ) async {
    await _budgetsRef.doc(month).set({
      'month': month,
      'categories': categories,
    });
  }
}
