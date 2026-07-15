import 'package:isar_plus/isar_plus.dart';

part 'sync_state.g.dart';

@collection
class SyncState {
  int id = 0;

  @Index(unique: true)
  late String entityType; // 'expense', 'loan', 'investment', 'budget', 'category_rule'
  
  String? lastPulledCursor; // opaque cursor token (e.g., ISO-8601 serverUpdatedAt of last pulled record)
  
  DateTime? lastPulledAt; // local time when sync was last executed
}
