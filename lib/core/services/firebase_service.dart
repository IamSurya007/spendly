import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../features/expenses/models/expense_model.dart';
import '../../features/investments/models/investment_model.dart';
import '../../features/loans/models/loan_model.dart';

/// Central Firestore service. All reads/writes are scoped to the
/// authenticated user's sub-collection: `users/{uid}/...`
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  // ── Collection refs ───────────────────────────────
  CollectionReference get _expensesRef =>
      _db.collection('users').doc(_uid).collection('expenses');

  CollectionReference get _budgetsRef =>
      _db.collection('users').doc(_uid).collection('budgets');

  CollectionReference get _loansRef =>
      _db.collection('users').doc(_uid).collection('loans');

  CollectionReference get _investmentsRef =>
      _db.collection('users').doc(_uid).collection('investments');

  DocumentReference get _userDoc => _db.collection('users').doc(_uid);

  // ── User doc ──────────────────────────────────────
  Future<void> ensureUserDoc(User user) async {
    final doc = await _userDoc.get();
    if (!doc.exists) {
      await _userDoc.set({
        'uid': user.uid,
        'name': user.displayName ?? '',
        'email': user.email ?? '',
        'photoUrl': user.photoURL ?? '',
        'createdAt': FieldValue.serverTimestamp(),
        'sheetsConnected': false,
        'sheetsId': '',
        'seeded': false,
      });
    }
  }

  Future<bool> isSeeded() async {
    final doc = await _userDoc.get();
    if (!doc.exists) return false;
    final data = doc.data() as Map<String, dynamic>?;
    return data?['seeded'] == true;
  }

  Future<void> markSeeded() async {
    await _userDoc.update({'seeded': true});
  }

  // ── Expenses ──────────────────────────────────────
  Stream<List<Expense>> expensesStream() {
    return _expensesRef
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) =>
                Expense.fromJson(doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  Future<void> addExpense(Expense expense) async {
    await _expensesRef.doc(expense.id).set(expense.toJson());
  }

  Future<void> deleteExpense(String id) async {
    await _expensesRef.doc(id).delete();
  }

  // ── Budgets ───────────────────────────────────────
  Future<Map<String, Map<String, dynamic>>> getBudgetForMonth(
      String month) async {
    final doc = await _budgetsRef.doc(month).get();
    if (!doc.exists) return {};
    final data = (doc.data() as Map<String, dynamic>)['categories']
        as Map<String, dynamic>? ?? {};
    return data.map((k, v) => MapEntry(k, v as Map<String, dynamic>));
  }

  Future<void> setBudgetForMonth(
      String month, Map<String, Map<String, dynamic>> categories) async {
    await _budgetsRef.doc(month).set({
      'month': month,
      'categories': categories,
    });
  }

  // ── Loans ─────────────────────────────────────────
  Stream<List<Loan>> loansStream() {
    return _loansRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) =>
                Loan.fromJson(doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  Future<void> addLoan(Loan loan) async {
    await _loansRef.doc(loan.id).set(loan.toJson());
  }

  Future<void> updateLoanStatus(String id, String status) async {
    await _loansRef.doc(id).update({'status': status});
  }

  Future<void> deleteLoan(String id) async {
    await _loansRef.doc(id).delete();
  }

  // ── Investments ───────────────────────────────────
  Stream<List<Investment>> investmentsStream() {
    return _investmentsRef
        .orderBy('maturityDate')
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => Investment.fromJson(
                doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  Future<void> addInvestment(Investment investment) async {
    await _investmentsRef.doc(investment.id).set(investment.toJson());
  }

  Future<void> deleteInvestment(String id) async {
    await _investmentsRef.doc(id).delete();
  }
}
