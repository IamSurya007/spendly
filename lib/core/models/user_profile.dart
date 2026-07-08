/// A backend-agnostic profile DTO.
/// Used when creating/ensuring the user document on first sign-in.
/// Avoids coupling the repository interface to any auth provider SDK.
class UserProfile {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;

  const UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
  });
}
