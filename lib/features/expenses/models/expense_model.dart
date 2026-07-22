import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      method: (json['method'] as String? ?? 'upi').toLowerCase(),
      source: (json['source'] as String? ?? 'manual').toLowerCase(),
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

class ExpenseCategory {
  final String name;
  final IconData icon;
  final String emoji;

  const ExpenseCategory({
    required this.name,
    required this.icon,
    required this.emoji,
  });
}

class ExpenseCategories {
  static const List<ExpenseCategory> all = [
    // 🏠 Housing
    ExpenseCategory(name: 'Rent', icon: Icons.home_rounded, emoji: '🏠'),
    ExpenseCategory(name: 'Electricity', icon: Icons.bolt_rounded, emoji: '⚡'),
    ExpenseCategory(name: 'Water Bill', icon: Icons.water_drop_rounded, emoji: '💧'),
    ExpenseCategory(name: 'Gas', icon: Icons.local_fire_department_rounded, emoji: '🔥'),
    ExpenseCategory(name: 'Internet', icon: Icons.wifi_rounded, emoji: '📶'),
    ExpenseCategory(name: 'Maintenance', icon: Icons.build_rounded, emoji: '🔧'),

    // 🍔 Food & Dining
    ExpenseCategory(name: 'Groceries', icon: Icons.shopping_basket_rounded, emoji: '🛒'),
    ExpenseCategory(name: 'Restaurants', icon: Icons.restaurant_rounded, emoji: '🍽️'),
    ExpenseCategory(name: 'Food Delivery', icon: Icons.delivery_dining_rounded, emoji: '🛵'),
    ExpenseCategory(name: 'Coffee & Snacks', icon: Icons.coffee_rounded, emoji: '☕'),

    // 🚗 Transport
    ExpenseCategory(name: 'Fuel', icon: Icons.local_gas_station_rounded, emoji: '⛽'),
    ExpenseCategory(name: 'Auto / Cab', icon: Icons.local_taxi_rounded, emoji: '🚕'),
    ExpenseCategory(name: 'Public Transport', icon: Icons.directions_bus_rounded, emoji: '🚌'),
    ExpenseCategory(name: 'Vehicle EMI', icon: Icons.two_wheeler_rounded, emoji: '🏍️'),
    ExpenseCategory(name: 'Parking', icon: Icons.local_parking_rounded, emoji: '🅿️'),
    ExpenseCategory(name: 'Flight', icon: Icons.flight_rounded, emoji: '✈️'),

    // 💳 Financial
    ExpenseCategory(name: 'CC Bill', icon: Icons.credit_card_rounded, emoji: '💳'),
    ExpenseCategory(name: 'Loan EMI', icon: Icons.account_balance_rounded, emoji: '🏦'),
    ExpenseCategory(name: 'Insurance', icon: Icons.security_rounded, emoji: '🛡️'),
    ExpenseCategory(name: 'Investment', icon: Icons.trending_up_rounded, emoji: '📈'),
    ExpenseCategory(name: 'RD / SIP', icon: Icons.savings_rounded, emoji: '💰'),
    ExpenseCategory(name: 'Tax', icon: Icons.receipt_long_rounded, emoji: '🧾'),

    // 🏥 Health
    ExpenseCategory(name: 'Doctor', icon: Icons.local_hospital_rounded, emoji: '🏥'),
    ExpenseCategory(name: 'Medicines', icon: Icons.medication_rounded, emoji: '💊'),
    ExpenseCategory(name: 'Gym / Fitness', icon: Icons.fitness_center_rounded, emoji: '💪'),
    ExpenseCategory(name: 'Lab Tests', icon: Icons.biotech_rounded, emoji: '🔬'),

    // 🛍️ Shopping
    ExpenseCategory(name: 'Clothing', icon: Icons.checkroom_rounded, emoji: '👕'),
    ExpenseCategory(name: 'Electronics', icon: Icons.devices_rounded, emoji: '📱'),
    ExpenseCategory(name: 'Home Decor', icon: Icons.chair_rounded, emoji: '🛋️'),
    ExpenseCategory(name: 'Personal Care', icon: Icons.face_retouching_natural_rounded, emoji: '🪥'),

    // 🎮 Entertainment
    ExpenseCategory(name: 'OTT / Subscriptions', icon: Icons.play_circle_rounded, emoji: '📺'),
    ExpenseCategory(name: 'Movies', icon: Icons.movie_rounded, emoji: '🎬'),
    ExpenseCategory(name: 'Gaming', icon: Icons.sports_esports_rounded, emoji: '🎮'),
    ExpenseCategory(name: 'Events / Concerts', icon: Icons.celebration_rounded, emoji: '🎉'),

    // 👨👩👧 Family & Social
    ExpenseCategory(name: 'Family', icon: Icons.people_rounded, emoji: '👨👩👧'),
    ExpenseCategory(name: 'Friends', icon: Icons.group_rounded, emoji: '👫'),
    ExpenseCategory(name: 'Gifts', icon: Icons.card_giftcard_rounded, emoji: '🎁'),
    ExpenseCategory(name: 'Donations', icon: Icons.volunteer_activism_rounded, emoji: '🤝'),
    ExpenseCategory(name: 'Marriage / Events', icon: Icons.favorite_rounded, emoji: '💍'),

    // 📚 Education
    ExpenseCategory(name: 'Courses', icon: Icons.school_rounded, emoji: '📚'),
    ExpenseCategory(name: 'Books', icon: Icons.menu_book_rounded, emoji: '📖'),
    ExpenseCategory(name: 'Tuition', icon: Icons.cast_for_education_rounded, emoji: '🎓'),

    // 📚 Others
    ExpenseCategory(name: 'Office Expenses', icon: Icons.business_center_rounded, emoji: '💼'),
    ExpenseCategory(name: 'Chitti / Savings Group', icon: Icons.group_work_rounded, emoji: '🫙'),
    ExpenseCategory(name: 'Splitwise', icon: Icons.call_split_rounded, emoji: '🔀'),
    ExpenseCategory(name: 'Cash Withdrawal', icon: Icons.atm_rounded, emoji: '🏧'),
    ExpenseCategory(name: 'Travel', icon: Icons.luggage_rounded, emoji: '🧳'),
    ExpenseCategory(name: 'Pets', icon: Icons.pets_rounded, emoji: '🐾'),
    ExpenseCategory(name: 'Other', icon: Icons.more_horiz_rounded, emoji: '•••'),
  ];

  // helper — find by name
  static ExpenseCategory? findByName(String name) {
    try {
      return all.firstWhere((c) => c.name.toLowerCase() == name.toLowerCase());
    } catch (_) {
      return null;
    }
  }

  // helper — get emoji for backward compatibility
  static String iconEmoji(String categoryName) {
    return findByName(categoryName)?.emoji ?? '💰';
  }

  // helper — get icon data
  static IconData iconData(String categoryName) {
    return findByName(categoryName)?.icon ?? Icons.more_horiz_rounded;
  }

  // just the names — for Firestore storage
  static List<String> get names => all.map((c) => c.name).toList();
}
