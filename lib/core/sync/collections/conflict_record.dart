import 'package:isar_plus/isar_plus.dart';

part 'conflict_record.g.dart';

@collection
class ConflictRecord {
  int id = 0;

  late String entityType; // 'expense', 'loan', 'investment', 'budget', 'category_rule'
  
  @Index(unique: true)
  late String clientId; // target record clientId
  
  late String localPayloadJson; // json-encoded local record fields
  
  late String serverPayloadJson; // json-encoded server record fields
  
  late DateTime conflictAt;
}
