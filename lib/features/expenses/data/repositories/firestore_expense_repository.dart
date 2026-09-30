import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/repositories/i_expense_repository.dart';
import '../../../categories/models/category.dart';
import '../../../categories/services/category_resolver.dart';
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
  Future<Set<String>> getAllExpenseIds() async {
    final snap = await _expensesRef.get();
    return snap.docs.map((d) => d.id).toSet();
  }

  @override
  Future<List<Expense>> findExpensesNear({
    required double amount,
    required DateTime date,
    Duration window = const Duration(minutes: 3),
  }) async {
    final snap = await _expensesRef
        .where('amount', isEqualTo: amount)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(date.subtract(window)))
        .where('date', isLessThanOrEqualTo: Timestamp.fromDate(date.add(window)))
        .get();
    return snap.docs
        .map((d) => Expense.fromJson(d.data() as Map<String, dynamic>, d.id))
        .toList();
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

  CollectionReference get _merchantRulesRef =>
      _db.collection('users').doc(_uid).collection('merchant_rules');

  @override
  Future<void> updateExpense(Expense expense) async {
    await _expensesRef.doc(expense.id).update(expense.toJson());
  }


  @override
  Future<void> setMerchantRule(String merchant, CategorySelection selection) async {
    final docName = merchant.toLowerCase().trim();
    if (docName.isEmpty) return;
    await _merchantRulesRef.doc(docName).set({
      'merchant': merchant.trim(),
      'categoryId': selection.categoryId,
      'subcategoryId': selection.subcategoryId,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<CategorySelection?> getMerchantRule(String merchant) async {
    final docName = merchant.toLowerCase().trim();
    if (docName.isEmpty) return null;
    final doc = await _merchantRulesRef.doc(docName).get();
    if (!doc.exists) return null;
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final categoryId = data['categoryId'] as String?;
    if (categoryId == null || categoryId.isEmpty) {
      return CategoryResolver.fromLegacyName(data['category'] as String? ?? '');
    }
    return CategorySelection(categoryId, data['subcategoryId'] as String? ?? '');
  }

  @override
  Future<void> updateExpensesCategory(String merchant, CategorySelection selection) async {
    if (merchant.trim().isEmpty) return;
    final snap = await _expensesRef.where('merchant', isEqualTo: merchant.trim()).get();
    if (snap.docs.isEmpty) return;

    final batch = _db.batch();
    for (final doc in snap.docs) {
      batch.update(doc.reference, {
        'categoryId': selection.categoryId,
        'subcategoryId': selection.subcategoryId,
      });
    }
    await batch.commit();
  }
}
