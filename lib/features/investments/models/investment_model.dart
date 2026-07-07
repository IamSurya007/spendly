import 'package:cloud_firestore/cloud_firestore.dart';

class Investment {
  final String id;
  final String type; // RD | SIP | MF
  final String name;
  final double monthlyAmount;
  final double principal;
  final double maturityAmount;
  final int durationMonths;
  final DateTime startDate;
  final DateTime maturityDate;
  final String institution;

  const Investment({
    required this.id,
    required this.type,
    required this.name,
    required this.monthlyAmount,
    required this.principal,
    required this.maturityAmount,
    required this.durationMonths,
    required this.startDate,
    required this.maturityDate,
    this.institution = '',
  });

  factory Investment.fromJson(Map<String, dynamic> json, String docId) {
    return Investment(
      id: docId,
      type: json['type'] as String? ?? 'RD',
      name: json['name'] as String? ?? '',
      monthlyAmount: (json['monthlyAmount'] as num).toDouble(),
      principal: (json['principal'] as num).toDouble(),
      maturityAmount: (json['maturityAmount'] as num).toDouble(),
      durationMonths: (json['durationMonths'] as num).toInt(),
      startDate: (json['startDate'] as Timestamp).toDate(),
      maturityDate: (json['maturityDate'] as Timestamp).toDate(),
      institution: json['institution'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'name': name,
        'monthlyAmount': monthlyAmount,
        'principal': principal,
        'maturityAmount': maturityAmount,
        'durationMonths': durationMonths,
        'startDate': Timestamp.fromDate(startDate),
        'maturityDate': Timestamp.fromDate(maturityDate),
        'institution': institution,
      };

  Investment copyWith({
    String? id,
    String? type,
    String? name,
    double? monthlyAmount,
    double? principal,
    double? maturityAmount,
    int? durationMonths,
    DateTime? startDate,
    DateTime? maturityDate,
    String? institution,
  }) {
    return Investment(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      monthlyAmount: monthlyAmount ?? this.monthlyAmount,
      principal: principal ?? this.principal,
      maturityAmount: maturityAmount ?? this.maturityAmount,
      durationMonths: durationMonths ?? this.durationMonths,
      startDate: startDate ?? this.startDate,
      maturityDate: maturityDate ?? this.maturityDate,
      institution: institution ?? this.institution,
    );
  }

  int get daysToMaturity =>
      maturityDate.difference(DateTime.now()).inDays.clamp(0, 99999);

  double get progressFraction {
    final totalDays =
        maturityDate.difference(startDate).inDays;
    if (totalDays == 0) return 1.0;
    final elapsed = DateTime.now().difference(startDate).inDays;
    return (elapsed / totalDays).clamp(0.0, 1.0);
  }
}
