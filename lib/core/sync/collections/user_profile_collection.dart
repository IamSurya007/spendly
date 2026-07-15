import 'package:isar_plus/isar_plus.dart';

part 'user_profile_collection.g.dart';

@collection
class UserProfileCollection {
  int id = 0;

  @Index(unique: true)
  late String uid;

  late String name;
  late String email;
  late String photoUrl;
  late bool seeded;
}
