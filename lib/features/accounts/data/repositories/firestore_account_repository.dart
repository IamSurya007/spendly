import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/repositories/i_account_repository.dart';
import '../../models/account_model.dart';

class FirestoreAccountRepository implements IAccountRepository {
  final FirebaseFirestore _db;

  FirestoreAccountRepository({FirebaseFirestore? db})
      : _db = db ?? FirebaseFirestore.instance;

  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  CollectionReference get _accountsRef =>
      _db.collection('users').doc(_uid).collection('accounts');

  @override
  Stream<List<Account>> watchAccounts() {
    return _accountsRef
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => Account.fromJson(doc.data() as Map<String, dynamic>, doc.id))
            .where((a) => !a.isArchived)
            .toList());
  }

  @override
  Future<List<Account>> getAccounts() async {
    final snap = await _accountsRef.get();
    return snap.docs
        .map((doc) => Account.fromJson(doc.data() as Map<String, dynamic>, doc.id))
        .where((a) => !a.isArchived)
        .toList();
  }

  @override
  Future<Account?> getAccount(String id) async {
    final doc = await _accountsRef.doc(id).get();
    if (!doc.exists) return null;
    return Account.fromJson(doc.data() as Map<String, dynamic>, doc.id);
  }

  @override
  Future<void> addAccount(Account account) async {
    await _accountsRef.doc(account.id).set(account.toJson());
  }

  @override
  Future<void> updateAccount(Account account) async {
    await _accountsRef.doc(account.id).update(account.toJson());
  }

  @override
  Future<void> updateAccountBalance(String id, double newBalance) async {
    await _accountsRef.doc(id).update({'currentBalance': newBalance});
  }

  @override
  Future<void> adjustAccountBalance(String id, double delta) async {
    if (delta == 0) return;
    await _accountsRef.doc(id).update({
      'currentBalance': FieldValue.increment(delta),
    });
  }

  @override
  Future<void> deleteAccount(String id) async {
    await _accountsRef.doc(id).delete();
  }

  @override
  Future<void> seedDefaultAccountsIfNeeded() async {
    // Accounts should only be created from SMS parsing or manual user creation.
    return;
  }
}
