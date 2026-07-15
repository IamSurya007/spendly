import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/repositories/i_loan_repository.dart';
import '../../models/loan_model.dart';

/// Firestore implementation of [ILoanRepository].
class FirestoreLoanRepository implements ILoanRepository {
  final FirebaseFirestore _db;

  FirestoreLoanRepository({FirebaseFirestore? db})
      : _db = db ?? FirebaseFirestore.instance;

  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  CollectionReference get _loansRef =>
      _db.collection('users').doc(_uid).collection('loans');

  @override
  Stream<List<Loan>> watchLoans() {
    return _loansRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) =>
                Loan.fromJson(doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  @override
  Future<void> addLoan(Loan loan) async {
    await _loansRef.doc(loan.id).set(loan.toJson());
  }

  @override
  Future<void> updateLoan(Loan loan) async {
    await _loansRef.doc(loan.id).update(loan.toJson());
  }

  @override
  Future<void> updateLoanStatus(String id, String status) async {
    await _loansRef.doc(id).update({'status': status});
  }

  @override
  Future<void> deleteLoan(String id) async {
    await _loansRef.doc(id).delete();
  }
}
