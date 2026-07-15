import 'package:isar_plus/isar_plus.dart';
import '../sync_metadata.dart';

part 'budget_collection.g.dart';

@collection
class BudgetCollection with SyncMetadataMixin {
  int id = 0;

  late String month; // YYYY-MM
  late String category;
  late double amountLimit;

  BudgetCollection();

  factory BudgetCollection.create({
    required String clientId,
    required String month,
    required String category,
    required double amountLimit,
    String? serverId,
    DateTime? serverUpdatedAt,
    SyncStatus syncStatus = SyncStatus.pendingCreate,
    int version = 1,
    bool dirty = true,
    bool isDeleted = false,
  }) {
    final col = BudgetCollection()
      ..month = month
      ..category = category
      ..amountLimit = amountLimit;

    col.clientId = clientId;
    col.serverId = serverId;
    col.serverUpdatedAt = serverUpdatedAt;
    col.syncStatus = syncStatus.name; // Serialize enum as string
    col.version = version;
    col.dirty = dirty;
    col.isDeleted = isDeleted;
    col.updatedAt = DateTime.now().toUtc();
    return col;
  }

  Map<String, dynamic> toSyncJson() {
    return {
      'month': month,
      'category': category,
      'limit': amountLimit,
    };
  }
}
