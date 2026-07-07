import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// Large bold amount display with ₹ prefix.
/// isDebit=true → red, isDebit=false → green.
class AmountDisplay extends StatelessWidget {
  final double amount;
  final bool isDebit;
  final double fontSize;
  final bool showSign;

  const AmountDisplay({
    super.key,
    required this.amount,
    required this.isDebit,
    this.fontSize = 42,
    this.showSign = true,
  });

  @override
  Widget build(BuildContext context) {
    final formatted = NumberFormat('#,##,###.##').format(amount.abs());
    final sign = showSign ? (isDebit ? '-' : '+') : '';
    return Text(
      '$sign₹$formatted',
      style: AppTextStyles.balanceLarge.copyWith(
        fontSize: fontSize,
        color: isDebit ? AppColors.expenseRed : AppColors.incomeGreen,
      ),
    );
  }
}
