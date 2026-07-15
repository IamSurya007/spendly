import 'package:isar_plus/isar_plus.dart';
import '../../../../features/expenses/models/expense_model.dart';
import '../sync_metadata.dart';

part 'expense_collection.g.dart';

@collection
class ExpenseCollection with SyncMetadataMixin {
  int id = 0;

  late double amount;
  late String category;
  late String note;
  late DateTime date;
  late String method;
  late String source;
  late String merchant;
  late DateTime createdAt;

  ExpenseCollection();

  factory ExpenseCollection.fromDomain(
    Expense expense, {
    String? serverId,
    DateTime? serverUpdatedAt,
    SyncStatus syncStatus = SyncStatus.pendingCreate,
    int version = 1,
    bool dirty = true,
    bool isDeleted = false,
  }) {
    final col = ExpenseCollection()
      ..amount = expense.amount
      ..category = expense.category
      ..note = expense.note
      ..date = expense.date
      ..method = expense.method
      ..source = expense.source
      ..merchant = expense.merchant
      ..createdAt = expense.createdAt;

    col.clientId = expense.id;
    col.serverId = serverId;
    col.serverUpdatedAt = serverUpdatedAt;
    col.syncStatus = syncStatus.name; // Serialize enum as string
    col.version = version;
    col.dirty = dirty;
    col.isDeleted = isDeleted;
    col.updatedAt = DateTime.now().toUtc();
    return col;
  }

  Expense toDomain() {
    return Expense(
      id: clientId,
      amount: amount,
      category: category,
      note: note,
      date: date,
      method: method,
      source: source,
      merchant: merchant,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toSyncJson() {
    return {
      'amount': amount,
      'category': category,
      'note': note,
      'date': date.toUtc().toIso8601String(),
      'method': method.toUpperCase(), // backend enums: CASH, UPI, CARD, etc.
      'source': source.toUpperCase(), // backend enums: MANUAL, SMS, OCR
      'merchant': merchant,
      'createdAt': createdAt.toUtc().toIso8601String(),
    };
  }
}
