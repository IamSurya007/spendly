import '../models/user_profile.dart';

/// Contract for user account / metadata operations.
///
/// Implementations:
///   - [FirestoreUserRepository]  (current)
///   - ApiUserRepository          (future, talks to your custom backend)
///
/// Note: accepts [UserProfile] (a plain Dart DTO), NOT firebase_auth's User,
/// so swapping auth providers never touches this interface.
abstract interface class IUserRepository {
  /// Ensures the user document exists. Creates it on first sign-in.
  Future<void> ensureUserProfile(UserProfile profile);

  /// Returns true if demo/seed data has already been written for this user.
  Future<bool> isSeeded();

  /// Marks seeding as complete — called once after [SeedService] finishes.
  Future<void> markSeeded();
}
