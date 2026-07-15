import 'package:isar_plus/isar_plus.dart';
import '../../../../features/loans/models/loan_model.dart';
import '../sync_metadata.dart';

part 'loan_collection.g.dart';

@collection
class LoanCollection with SyncMetadataMixin {
  int id = 0;

  late String type; // taken | given
  late String name;
  late double principal;
  late double total;
  late double interestRate;
  DateTime? repaymentDate;
  late String status; // active | paid | overdue
  late String notes;
  late DateTime createdAt;

  LoanCollection();

  factory LoanCollection.fromDomain(
    Loan loan, {
    String? serverId,
    DateTime? serverUpdatedAt,
    SyncStatus syncStatus = SyncStatus.pendingCreate,
    int version = 1,
    bool dirty = true,
    bool isDeleted = false,
  }) {
    final col = LoanCollection()
      ..type = loan.type
      ..name = loan.name
      ..principal = loan.principal
      ..total = loan.total
      ..interestRate = loan.interestRate
      ..repaymentDate = loan.repaymentDate
      ..status = loan.status
      ..notes = loan.notes
      ..createdAt = loan.createdAt;

    col.clientId = loan.id;
    col.serverId = serverId;
    col.serverUpdatedAt = serverUpdatedAt;
    col.syncStatus = syncStatus.name; // Serialize enum as string
    col.version = version;
    col.dirty = dirty;
    col.isDeleted = isDeleted;
    col.updatedAt = DateTime.now().toUtc();
    return col;
  }

  Loan toDomain() {
    return Loan(
      id: clientId,
      type: type,
      name: name,
      principal: principal,
      total: total,
      interestRate: interestRate,
      repaymentDate: repaymentDate,
      status: status,
      notes: notes,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toSyncJson() {
    return {
      'type': type.toUpperCase(), // backend expect: TAKEN | GIVEN
      'name': name,
      'principal': principal,
      'total': total,
      'interestRate': interestRate,
      'repaymentDate': repaymentDate != null
          ? "${repaymentDate!.year.toString().padLeft(4, '0')}-${repaymentDate!.month.toString().padLeft(2, '0')}-${repaymentDate!.day.toString().padLeft(2, '0')}"
          : null,
      'status': status.toUpperCase(), // backend expect: ACTIVE | PAID | OVERDUE | PARTIAL
      'notes': notes,
      'createdAt': createdAt.toUtc().toIso8601String(),
    };
  }
}
