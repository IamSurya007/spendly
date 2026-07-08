import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/models/user_profile.dart';
import '../../../../core/repositories/i_user_repository.dart';

/// Firestore implementation of [IUserRepository].
class FirestoreUserRepository implements IUserRepository {
  final FirebaseFirestore _db;

  FirestoreUserRepository({FirebaseFirestore? db})
      : _db = db ?? FirebaseFirestore.instance;

  DocumentReference _userDoc(String uid) =>
      _db.collection('users').doc(uid);

  // We cache the uid in ensureUserProfile so isSeeded/markSeeded can use it.
  // In the Firestore model uid is embedded in the doc, so we need it.
  String? _cachedUid;

  @override
  Future<void> ensureUserProfile(UserProfile profile) async {
    _cachedUid = profile.uid;
    final doc = await _userDoc(profile.uid).get();
    if (!doc.exists) {
      await _userDoc(profile.uid).set({
        'uid': profile.uid,
        'name': profile.name,
        'email': profile.email,
        'photoUrl': profile.photoUrl,
        'createdAt': FieldValue.serverTimestamp(),
        'sheetsConnected': false,
        'sheetsId': '',
        'seeded': false,
      });
    }
  }

  @override
  Future<bool> isSeeded() async {
    if (_cachedUid == null) return false;
    final doc = await _userDoc(_cachedUid!).get();
    if (!doc.exists) return false;
    final data = doc.data() as Map<String, dynamic>?;
    return data?['seeded'] == true;
  }

  @override
  Future<void> markSeeded() async {
    if (_cachedUid == null) return;
    await _userDoc(_cachedUid!).update({'seeded': true});
  }
}
