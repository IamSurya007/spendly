import 'package:isar_plus/isar_plus.dart';
import '../../../../features/investments/models/investment_model.dart';
import '../sync_metadata.dart';

part 'investment_collection.g.dart';

@collection
class InvestmentCollection with SyncMetadataMixin {
  int id = 0;

  late String type; // RD | SIP | MF
  late String name;
  late double monthlyAmount;
  late double principal;
  late double maturityAmount;
  late int durationMonths;
  late DateTime startDate;
  late DateTime maturityDate;
  late String institution;

  InvestmentCollection();

  factory InvestmentCollection.fromDomain(
    Investment investment, {
    String? serverId,
    DateTime? serverUpdatedAt,
    SyncStatus syncStatus = SyncStatus.pendingCreate,
    int version = 1,
    bool dirty = true,
    bool isDeleted = false,
  }) {
    final col = InvestmentCollection()
      ..type = investment.type
      ..name = investment.name
      ..monthlyAmount = investment.monthlyAmount
      ..principal = investment.principal
      ..maturityAmount = investment.maturityAmount
      ..durationMonths = investment.durationMonths
      ..startDate = investment.startDate
      ..maturityDate = investment.maturityDate
      ..institution = investment.institution;

    col.clientId = investment.id;
    col.serverId = serverId;
    col.serverUpdatedAt = serverUpdatedAt;
    col.syncStatus = syncStatus.name; // Serialize enum as string
    col.version = version;
    col.dirty = dirty;
    col.isDeleted = isDeleted;
    col.updatedAt = DateTime.now().toUtc();
    return col;
  }

  Investment toDomain() {
    return Investment(
      id: clientId,
      type: type,
      name: name,
      monthlyAmount: monthlyAmount,
      principal: principal,
      maturityAmount: maturityAmount,
      durationMonths: durationMonths,
      startDate: startDate,
      maturityDate: maturityDate,
      institution: institution,
    );
  }

  Map<String, dynamic> toSyncJson() {
    return {
      'type': type.toUpperCase(), // backend enums: RD, SIP, MF, FD, PPF, OTHER
      'name': name,
      'monthlyAmount': monthlyAmount,
      'principal': principal,
      'maturityAmount': maturityAmount,
      'durationMonths': durationMonths,
      'startDate': "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}", // YYYY-MM-DD
      'maturityDate': "${maturityDate.year.toString().padLeft(4, '0')}-${maturityDate.month.toString().padLeft(2, '0')}-${maturityDate.day.toString().padLeft(2, '0')}", // YYYY-MM-DD
      'institution': institution,
    };
  }
}
