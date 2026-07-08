import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/repositories/i_investment_repository.dart';
import '../../models/investment_model.dart';

/// Firestore implementation of [IInvestmentRepository].
class FirestoreInvestmentRepository implements IInvestmentRepository {
  final FirebaseFirestore _db;

  FirestoreInvestmentRepository({FirebaseFirestore? db})
      : _db = db ?? FirebaseFirestore.instance;

  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  CollectionReference get _investmentsRef =>
      _db.collection('users').doc(_uid).collection('investments');

  @override
  Stream<List<Investment>> watchInvestments() {
    return _investmentsRef
        .orderBy('maturityDate')
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => Investment.fromJson(
                doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  @override
  Future<void> addInvestment(Investment investment) async {
    await _investmentsRef.doc(investment.id).set(investment.toJson());
  }

  @override
  Future<void> deleteInvestment(String id) async {
    await _investmentsRef.doc(id).delete();
  }
}
