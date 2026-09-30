import 'package:cloud_firestore/cloud_firestore.dart';

import '../../categories/services/category_resolver.dart';

class Expense {
  final String id;
  final double amount;

  /// Display name of the parent category at write time. Kept for the web app,
  /// Sheets export and older clients; the app resolves names from [categoryId].
  final String category;
  final String note;
  final DateTime date;
  final String method; // cash | upi | card
  final String source; // manual | sms | ocr
  final String merchant;
  final String accountId;
  final DateTime createdAt;

  /// Display name of the subcategory at write time ('' if none).
  final String subcategory;

  /// Parent category id, e.g. `food` (see categories/data/category_taxonomy.g.dart).
  final String categoryId;

  /// Subcategory id, e.g. `food.delivery`, or '' when only a parent is set.
  final String subcategoryId;

  /// Only applicable to debit (amount > 0) transactions.
  /// When false, this transaction is excluded from spend totals & budget tracking.
  /// Income (amount < 0) is always counted — this flag has no effect on credits.
  final bool isCountedAsSpend;

  const Expense({
    required this.id,
    required this.amount,
    required this.category,
    this.subcategory = '',
    this.categoryId = '',
    this.subcategoryId = '',
    this.note = '',
    required this.date,
    this.method = 'upi',
    this.source = 'manual',
    this.merchant = '',
    this.accountId = 'default_bank',
    required this.createdAt,
    this.isCountedAsSpend = true,
  });

  factory Expense.fromJson(
    Map<String, dynamic> json,
    String docId, {
    bool? defaultIsCountedAsSpend,
  }) {
    DateTime parseDate(dynamic val) {
      if (val is Timestamp) return val.toDate();
      if (val is String) return DateTime.tryParse(val) ?? DateTime.now();
      if (val is int) return DateTime.fromMillisecondsSinceEpoch(val);
      return DateTime.now();
    }

    final parsedCountAsSpend = json['isCountedAsSpend'] as bool? ??
        json['is_counted_as_spend'] as bool? ??
        json['isCountedAsExpense'] as bool? ??
        json['is_counted_as_expense'] as bool?;

    final amount = (json['amount'] as num? ?? 0).toDouble();
    final categoryName = json['category'] as String? ?? '';

    // Records written before category ids existed only carry a name.
    var categoryId = json['categoryId'] as String? ?? '';
    var subcategoryId = json['subcategoryId'] as String? ?? '';
    if (categoryId.isEmpty) {
      final legacy = CategoryResolver.fromLegacyName(categoryName, isCredit: amount < 0);
      categoryId = legacy.categoryId;
      subcategoryId = legacy.subcategoryId;
    }

    return Expense(
      id: docId,
      amount: amount,
      category: categoryName.isEmpty ? 'Other' : categoryName,
      subcategory: json['subcategory'] as String? ?? '',
      categoryId: categoryId,
      subcategoryId: subcategoryId,
      note: json['note'] as String? ?? '',
      date: parseDate(json['date']),
      method: (json['method'] as String? ?? 'upi').toLowerCase(),
      source: (json['source'] as String? ?? 'manual').toLowerCase(),
      merchant: json['merchant'] as String? ?? '',
      accountId: json['accountId'] as String? ??
          json['account_id'] as String? ??
          'default_bank',
      createdAt: parseDate(json['createdAt']),
      isCountedAsSpend: parsedCountAsSpend ?? defaultIsCountedAsSpend ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'category': category,
        'subcategory': subcategory,
        'categoryId': categoryId,
        'subcategoryId': subcategoryId,
        'note': note,
        'date': Timestamp.fromDate(date),
        'method': method,
        'source': source,
        'merchant': merchant,
        'accountId': accountId,
        'createdAt': Timestamp.fromDate(createdAt),
        'isCountedAsSpend': isCountedAsSpend,
      };

  Expense copyWith({
    String? id,
    double? amount,
    String? category,
    String? subcategory,
    String? categoryId,
    String? subcategoryId,
    String? note,
    DateTime? date,
    String? method,
    String? source,
    String? merchant,
    String? accountId,
    DateTime? createdAt,
    bool? isCountedAsSpend,
  }) {
    return Expense(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      categoryId: categoryId ?? this.categoryId,
      subcategoryId: subcategoryId ?? this.subcategoryId,
      note: note ?? this.note,
      date: date ?? this.date,
      method: method ?? this.method,
      source: source ?? this.source,
      merchant: merchant ?? this.merchant,
      accountId: accountId ?? this.accountId,
      createdAt: createdAt ?? this.createdAt,
      isCountedAsSpend: isCountedAsSpend ?? this.isCountedAsSpend,
    );
  }
}
