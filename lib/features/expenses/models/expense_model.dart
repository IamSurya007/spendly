import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  final String id;
  final double amount;
  final String category;
  final String note;
  final DateTime date;
  final String method; // cash | upi | card
  final String source; // manual | sms | ocr
  final String merchant;
  final DateTime createdAt;

  const Expense({
    required this.id,
    required this.amount,
    required this.category,
    this.note = '',
    required this.date,
    this.method = 'upi',
    this.source = 'manual',
    this.merchant = '',
    required this.createdAt,
  });

  factory Expense.fromJson(Map<String, dynamic> json, String docId) {
    return Expense(
      id: docId,
      amount: (json['amount'] as num).toDouble(),
      category: json['category'] as String? ?? 'Other',
      note: json['note'] as String? ?? '',
      date: (json['date'] as Timestamp).toDate(),
      method: json['method'] as String? ?? 'upi',
      source: json['source'] as String? ?? 'manual',
      merchant: json['merchant'] as String? ?? '',
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'category': category,
        'note': note,
        'date': Timestamp.fromDate(date),
        'method': method,
        'source': source,
        'merchant': merchant,
        'createdAt': Timestamp.fromDate(createdAt),
      };

  Expense copyWith({
    String? id,
    double? amount,
    String? category,
    String? note,
    DateTime? date,
    String? method,
    String? source,
    String? merchant,
    DateTime? createdAt,
  }) {
    return Expense(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      note: note ?? this.note,
      date: date ?? this.date,
      method: method ?? this.method,
      source: source ?? this.source,
      merchant: merchant ?? this.merchant,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

/// All supported expense categories matching the founder's sheet.
class ExpenseCategories {
  static const List<String> all = [
    'PG Rent',
    'Spends',
    'Dad',
    'Friends',
    'CC 1 Bill',
    'CC 2 Bill',
    'Splitwise',
    'Loan',
    'Office Chitti',
    'RD',
    'Other',
  ];

  static String iconEmoji(String category) {
    switch (category) {
      case 'PG Rent':
        return '🏠';
      case 'Spends':
        return '🛒';
      case 'Dad':
        return '👨';
      case 'Friends':
        return '👥';
      case 'CC 1 Bill':
        return '💳';
      case 'CC 2 Bill':
        return '💳';
      case 'Splitwise':
        return '🔀';
      case 'Loan':
        return '🤝';
      case 'Office Chitti':
        return '🏢';
      case 'RD':
        return '📈';
      case 'Other':
        return '📦';
      default:
        return '💰';
    }
  }
}
