import 'package:isar_plus/isar_plus.dart';
import '../../../../features/accounts/models/account_model.dart';
import '../sync_metadata.dart';

part 'account_collection.g.dart';

@collection
class AccountCollection with SyncMetadataMixin {
  int id = 0;

  late String name;
  late String type;
  late String institution;
  late double currentBalance;
  late double creditLimit;
  late int colorValue;
  late String iconName;
  late bool isArchived;
  late DateTime createdAt;

  AccountCollection();

  factory AccountCollection.fromDomain(
    Account account, {
    String? serverId,
    DateTime? serverUpdatedAt,
    SyncStatus syncStatus = SyncStatus.pendingCreate,
    int version = 1,
    bool dirty = true,
    bool isDeleted = false,
  }) {
    final col = AccountCollection()
      ..name = account.name
      ..type = account.type.name
      ..institution = account.institution
      ..currentBalance = account.currentBalance
      ..creditLimit = account.creditLimit
      ..colorValue = account.colorValue
      ..iconName = account.iconName
      ..isArchived = account.isArchived
      ..createdAt = account.createdAt;

    col.clientId = account.id;
    col.serverId = serverId;
    col.serverUpdatedAt = serverUpdatedAt;
    col.syncStatus = syncStatus.name;
    col.version = version;
    col.dirty = dirty;
    col.isDeleted = isDeleted;
    col.updatedAt = DateTime.now().toUtc();
    return col;
  }

  Account toDomain() {
    return Account(
      id: clientId,
      name: name,
      type: AccountType.values.firstWhere(
        (t) => t.name == type,
        orElse: () => AccountType.bank_account,
      ),
      institution: institution,
      currentBalance: currentBalance,
      creditLimit: creditLimit,
      colorValue: colorValue,
      iconName: iconName,
      isArchived: isArchived,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toSyncJson() {
    return {
      'name': name,
      'type': type,
      'institution': institution,
      'currentBalance': currentBalance,
      'current_balance': currentBalance,
      'creditLimit': creditLimit,
      'credit_limit': creditLimit,
      'colorValue': colorValue,
      'color_value': colorValue,
      'iconName': iconName,
      'icon_name': iconName,
      'isArchived': isArchived,
      'is_archived': isArchived,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'created_at': createdAt.toUtc().toIso8601String(),
    };
  }
}
