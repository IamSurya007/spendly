import 'package:isar_plus/isar_plus.dart';
import 'package:spendly/core/models/user_profile.dart';
import 'package:spendly/core/repositories/i_user_repository.dart';
import 'package:spendly/core/sync/collections/user_profile_collection.dart';
import 'package:spendly/core/sync/isar_database.dart';
import 'package:spendly/core/sync/sync_api_client.dart';

class IsarUserRepository implements IUserRepository {
  final SyncApiClient _apiClient;
  
  IsarUserRepository(this._apiClient);

  Isar get _isar => IsarDatabase.instance.isar;

  @override
  Future<void> ensureUserProfile(UserProfile profile) async {
    // 1. Save locally in Isar
    await _isar.writeAsync((isar) {
      final existing = isar.userProfileCollections
          .where()
          .uidEqualTo(profile.uid)
          .findFirst();
      if (existing == null) {
        final newId = isar.userProfileCollections.autoIncrement();
        final col = UserProfileCollection()
          ..id = newId
          ..uid = profile.uid
          ..name = profile.name
          ..email = profile.email
          ..photoUrl = profile.photoUrl
          ..seeded = false;
        isar.userProfileCollections.put(col);
      } else {
        existing.name = profile.name;
        existing.email = profile.email;
        existing.photoUrl = profile.photoUrl;
        isar.userProfileCollections.put(existing);
      }
    });

    // 2. Call backend /users/me API to register/update profile (unawaited in background)
    _apiClient.dio.post('/users/me', data: {
      'name': profile.name,
      'email': profile.email,
      'photoUrl': profile.photoUrl,
    }).then((_) {
      print('IsarUserRepository: ensureUserProfile remote call succeeded');
    }).catchError((e) {
      print('IsarUserRepository: ensureUserProfile remote call failed: $e');
    });
  }

  @override
  Future<bool> isSeeded() async {
    final profile = await _isar.userProfileCollections.where().findFirst();
    return profile?.seeded ?? false;
  }

  @override
  Future<void> markSeeded() async {
    await _isar.writeAsync((isar) {
      final profile = isar.userProfileCollections.where().findFirst();
      if (profile != null) {
        profile.seeded = true;
        isar.userProfileCollections.put(profile);
      }
    });
  }
}
