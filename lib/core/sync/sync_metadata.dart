import 'package:isar_plus/isar_plus.dart';

enum SyncStatus {
  synced,
  pendingCreate,
  pendingUpdate,
  pendingDelete,
  conflict,
  failed,
}

mixin SyncMetadataMixin {
  String? serverId;
  
  late String clientId; // UUID v4, generated locally, sent to server for idempotency
  
  late DateTime updatedAt; // local last-modified time
  
  DateTime? serverUpdatedAt; // last-known server timestamp
  
  late String syncStatus; // stored as String in DB (synced, pendingCreate, etc.)
  
  late bool isDeleted; // soft-delete tombstone flag
  
  late int version; // optimistic concurrency control version
  
  late bool dirty; // true if local modifications are not synced yet

}
