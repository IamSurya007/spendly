import 'package:isar_plus/isar_plus.dart';
import '../sync_metadata.dart';

part 'category_rule_collection.g.dart';

@collection
class CategoryRuleCollection with SyncMetadataMixin {
  int id = 0;

  late String merchant;

  /// Display name of the category (kept for older clients / web).
  late String category;

  /// Parent category id (e.g. `food`).
  String categoryId = '';

  /// Subcategory id (e.g. `food.delivery`), empty if none.
  String subcategoryId = '';

  CategoryRuleCollection();

  factory CategoryRuleCollection.create({
    required String clientId,
    required String merchant,
    required String category,
    String categoryId = '',
    String subcategoryId = '',
    String? serverId,
    DateTime? serverUpdatedAt,
    SyncStatus syncStatus = SyncStatus.pendingCreate,
    int version = 1,
    bool dirty = true,
    bool isDeleted = false,
  }) {
    final col = CategoryRuleCollection()
      ..merchant = merchant
      ..category = category
      ..categoryId = categoryId
      ..subcategoryId = subcategoryId;

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
      'merchant': merchant,
      'category': category,
      'categoryId': categoryId,
      'subcategoryId': subcategoryId,
    };
  }
}
