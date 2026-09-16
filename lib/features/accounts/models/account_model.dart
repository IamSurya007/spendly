import 'package:flutter/material.dart';

enum AccountType {
  bank_account,
  credit_card,
  wallet,
  cash,
  other;

  String get displayName {
    switch (this) {
      case AccountType.bank_account:
        return 'Bank Account';
      case AccountType.credit_card:
        return 'Credit Card';
      case AccountType.wallet:
        return 'Wallet';
      case AccountType.cash:
        return 'Cash';
      case AccountType.other:
        return 'Other';
    }
  }

  IconData get icon {
    switch (this) {
      case AccountType.bank_account:
        return Icons.account_balance_rounded;
      case AccountType.credit_card:
        return Icons.credit_card_rounded;
      case AccountType.wallet:
        return Icons.account_balance_wallet_rounded;
      case AccountType.cash:
        return Icons.payments_rounded;
      case AccountType.other:
        return Icons.savings_rounded;
    }
  }

  Color get defaultColor {
    switch (this) {
      case AccountType.bank_account:
        return const Color(0xFF1E3A8A); // Navy / Blue
      case AccountType.credit_card:
        return const Color(0xFF991B1B); // Crimson Red
      case AccountType.wallet:
        return const Color(0xFF0284C7); // Cyan / Blue
      case AccountType.cash:
        return const Color(0xFF16A34A); // Emerald Green
      case AccountType.other:
        return const Color(0xFF6B7280); // Slate Gray
    }
  }
}

class Account {
  final String id;
  final String name;
  final AccountType type;
  final String institution;
  final double currentBalance; // For bank/cash/wallet: available money. For CC: outstanding balance owed.
  final double creditLimit;    // For credit cards only
  final int colorValue;
  final String iconName;
  final bool isArchived;
  final DateTime createdAt;

  const Account({
    required this.id,
    required this.name,
    required this.type,
    this.institution = '',
    required this.currentBalance,
    this.creditLimit = 0.0,
    required this.colorValue,
    this.iconName = '',
    this.isArchived = false,
    required this.createdAt,
  });

  bool get isCreditCard => type == AccountType.credit_card;

  /// Available credit for credit cards
  double get availableCredit => (creditLimit - currentBalance).clamp(0.0, double.infinity);

  factory Account.fromJson(Map<String, dynamic> json, String docId) {
    final rawType = (json['type'] as String? ?? '').toLowerCase();
    AccountType parsedType = AccountType.values.firstWhere(
      (t) => t.name.toLowerCase() == rawType,
      orElse: () => AccountType.bank_account,
    );

    DateTime parseDate(dynamic val) {
      if (val is String) return DateTime.tryParse(val) ?? DateTime.now();
      if (val is int) return DateTime.fromMillisecondsSinceEpoch(val);
      return DateTime.now();
    }

    return Account(
      id: docId,
      name: json['name'] as String? ?? 'Account',
      type: parsedType,
      institution: json['institution'] as String? ?? '',
      currentBalance: (json['currentBalance'] as num?)?.toDouble() ??
          (json['current_balance'] as num?)?.toDouble() ??
          0.0,
      creditLimit: (json['creditLimit'] as num?)?.toDouble() ??
          (json['credit_limit'] as num?)?.toDouble() ??
          0.0,
      colorValue: (json['colorValue'] as num?)?.toInt() ??
          (json['color_value'] as num?)?.toInt() ??
          parsedType.defaultColor.value,
      iconName: json['iconName'] as String? ?? json['icon_name'] as String? ?? '',
      isArchived: json['isArchived'] as bool? ?? json['is_archived'] as bool? ?? false,
      createdAt: parseDate(json['createdAt'] ?? json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type.name,
        'institution': institution,
        'currentBalance': currentBalance,
        'creditLimit': creditLimit,
        'colorValue': colorValue,
        'iconName': iconName,
        'isArchived': isArchived,
        'createdAt': createdAt.toIso8601String(),
      };

  Account copyWith({
    String? id,
    String? name,
    AccountType? type,
    String? institution,
    double? currentBalance,
    double? creditLimit,
    int? colorValue,
    String? iconName,
    bool? isArchived,
    DateTime? createdAt,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      institution: institution ?? this.institution,
      currentBalance: currentBalance ?? this.currentBalance,
      creditLimit: creditLimit ?? this.creditLimit,
      colorValue: colorValue ?? this.colorValue,
      iconName: iconName ?? this.iconName,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
