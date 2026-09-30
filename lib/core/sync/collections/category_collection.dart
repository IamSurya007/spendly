import 'package:isar_plus/isar_plus.dart';
import '../../../features/categories/models/category.dart';
import '../sync_metadata.dart';

part 'category_collection.g.dart';

/// A user-created category/subcategory, or a user override (rename, recolour,
/// hide, reorder) of a system category. [clientId] is the category id: a UUID
/// for custom categories, the system slug (e.g. `food`) for overrides.
@collection
class CategoryCollection with SyncMetadataMixin {
  int id = 0;

  late String name;
  late String iconKey;
  late int color;
  late String kind;

  /// Empty for top-level categories.
  String parentId = '';
  bool isSystem = false;
  bool isHidden = false;
  int sortOrder = 0;

  CategoryCollection();

  factory CategoryCollection.fromDomain(
    Category category, {
    String? serverId,
    DateTime? serverUpdatedAt,
    SyncStatus syncStatus = SyncStatus.pendingCreate,
    int version = 1,
    bool dirty = true,
    bool isDeleted = false,
  }) {
    final col = CategoryCollection()
      ..name = category.name
      ..iconKey = category.iconKey
      ..color = category.color
      ..kind = category.kind.name
      ..parentId = category.parentId ?? ''
      ..isSystem = category.isSystem
      ..isHidden = category.isHidden
      ..sortOrder = category.sortOrder;

    col.clientId = category.id;
    col.serverId = serverId;
    col.serverUpdatedAt = serverUpdatedAt;
    col.syncStatus = syncStatus.name;
    col.version = version;
    col.dirty = dirty;
    col.isDeleted = isDeleted;
    col.updatedAt = DateTime.now().toUtc();
    return col;
  }

  factory CategoryCollection.fromSyncJson(
    String clientId,
    Map<String, dynamic> json, {
    String? serverId,
    DateTime? serverUpdatedAt,
    int version = 1,
  }) {
    final parent = json['parentId'] as String?;
    return CategoryCollection.fromDomain(
      Category(
        id: clientId,
        name: json['name'] as String? ?? 'Category',
        iconKey: json['icon'] as String? ?? 'tag',
        color: Category.colorFromHex(json['color'] as String?),
        kind: Category.kindFromName(json['kind'] as String?),
        parentId: (parent == null || parent.isEmpty) ? null : parent,
        isSystem: json['isSystem'] as bool? ?? false,
        isHidden: json['isHidden'] as bool? ?? false,
        sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      ),
      serverId: serverId,
      serverUpdatedAt: serverUpdatedAt,
      syncStatus: SyncStatus.synced,
      version: version,
      dirty: false,
    );
  }

  Category toDomain() {
    return Category(
      id: clientId,
      name: name,
      iconKey: iconKey,
      color: color,
      kind: Category.kindFromName(kind),
      parentId: parentId.isEmpty ? null : parentId,
      isSystem: isSystem,
      isHidden: isHidden,
      sortOrder: sortOrder,
    );
  }

  Map<String, dynamic> toSyncJson() {
    return {
      'name': name,
      'icon': iconKey,
      'color': Category.colorToHex(color),
      'kind': kind,
      'parentId': parentId.isEmpty ? null : parentId,
      'isSystem': isSystem,
      'isHidden': isHidden,
      'sortOrder': sortOrder,
    };
  }
}
