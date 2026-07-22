import 'package:cloud_firestore/cloud_firestore.dart';

class Loan {
  final String id;
  final String type; // taken | given
  final String name;
  final double principal;
  final double total;
  final double interestRate;
  final DateTime? repaymentDate;
  final String status; // active | paid | overdue
  final String notes;
  final DateTime createdAt;

  const Loan({
    required this.id,
    required this.type,
    required this.name,
    required this.principal,
    required this.total,
    this.interestRate = 0.0,
    this.repaymentDate,
    this.status = 'active',
    this.notes = '',
    required this.createdAt,
  });

  factory Loan.fromJson(Map<String, dynamic> json, String docId) {
    return Loan(
      id: docId,
      type: (json['type'] as String? ?? 'given').toLowerCase(),
      name: json['name'] as String? ?? '',
      principal: (json['principal'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      interestRate: (json['interestRate'] as num?)?.toDouble() ?? 0.0,
      repaymentDate: json['repaymentDate'] != null
          ? (json['repaymentDate'] as Timestamp).toDate()
          : null,
      status: (json['status'] as String? ?? 'active').toLowerCase(),
      notes: json['notes'] as String? ?? '',
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'name': name,
        'principal': principal,
        'total': total,
        'interestRate': interestRate,
        'repaymentDate':
            repaymentDate != null ? Timestamp.fromDate(repaymentDate!) : null,
        'status': status,
        'notes': notes,
        'createdAt': Timestamp.fromDate(createdAt),
      };

  Loan copyWith({
    String? id,
    String? type,
    String? name,
    double? principal,
    double? total,
    double? interestRate,
    DateTime? repaymentDate,
    String? status,
    String? notes,
    DateTime? createdAt,
  }) {
    return Loan(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      principal: principal ?? this.principal,
      total: total ?? this.total,
      interestRate: interestRate ?? this.interestRate,
      repaymentDate: repaymentDate ?? this.repaymentDate,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  double get currentTotal {
    if (status == 'paid') return total;
    if (interestRate <= 0.0) return principal;
    final days = DateTime.now().difference(createdAt).inDays;
    if (days <= 0) return principal;
    return principal * (1.0 + (interestRate / 100.0) * (days / 365.0));
  }

  int? get daysRemaining {
    if (repaymentDate == null) return null;
    return repaymentDate!.difference(DateTime.now()).inDays;
  }

  bool get isOverdue {
    if (repaymentDate == null) return false;
    return DateTime.now().isAfter(repaymentDate!) && status == 'active';
  }
}
