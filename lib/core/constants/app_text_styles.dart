import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Spendly typography system using Google Fonts Inter.
/// Bold numbers, light labels — hierarchy readable at a glance.
class AppTextStyles {
  AppTextStyles._();

  // ── Display / Balance ──────────────────────────────
  static TextStyle get balanceLarge => GoogleFonts.inter(
        fontSize: 42,
        fontWeight: FontWeight.w800,
        color: AppColors.primaryNavy,
        letterSpacing: -1.5,
        height: 1.0,
      );

  static TextStyle get balanceMedium => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryNavy,
        letterSpacing: -0.5,
      );

  // ── Headings ──────────────────────────────────────
  static TextStyle get h1 => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryNavy,
        letterSpacing: -0.3,
      );

  static TextStyle get h2 => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryNavy,
        letterSpacing: -0.2,
      );

  static TextStyle get h3 => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryNavy,
      );

  // ── Body ──────────────────────────────────────────
  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryNavy,
        height: 1.5,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.mutedText,
        height: 1.4,
      );

  // ── Labels / Captions ─────────────────────────────
  static TextStyle get label => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.mutedText,
        letterSpacing: 0.2,
      );

  static TextStyle get labelBold => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryNavy,
        letterSpacing: 0.3,
      );

  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: AppColors.mutedText,
      );

  // ── Amount ────────────────────────────────────────
  static TextStyle amountStyle({
    required bool isDebit,
    double fontSize = 15,
  }) =>
      GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: isDebit ? AppColors.expenseRed : AppColors.incomeGreen,
        letterSpacing: -0.3,
      );

  // ── Buttons ───────────────────────────────────────
  static TextStyle get buttonText => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      );

  // ── Greeting ──────────────────────────────────────
  static TextStyle get greeting => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.mutedText,
      );
}
