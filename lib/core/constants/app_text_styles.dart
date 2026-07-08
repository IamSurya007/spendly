import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Spendly typography system — uses the locally bundled Inter font.
/// Zero network calls. Works fully offline.
/// Font weights declared in pubspec.yaml: 300 / 400 / 500 / 600 / 700 / 800.
class AppTextStyles {
  AppTextStyles._();

  // ── Shared base — all styles inherit this ──────────────────────────────
  static const String _family = 'Inter';

  static TextStyle _style({
    required double fontSize,
    required FontWeight weight,
    Color color = AppColors.primaryNavy,
    double? letterSpacing,
    double? height,
  }) =>
      TextStyle(
        fontFamily: _family,
        fontSize: fontSize,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );

  // ── Display / Balance ──────────────────────────────────────────────────
  static TextStyle get balanceLarge => _style(
        fontSize: 42,
        weight: FontWeight.w800,
        letterSpacing: -1.5,
        height: 1.0,
      );

  static TextStyle get balanceMedium => _style(
        fontSize: 28,
        weight: FontWeight.w700,
        letterSpacing: -0.5,
      );

  // ── Headings ──────────────────────────────────────────────────────────
  static TextStyle get h1 => _style(
        fontSize: 24,
        weight: FontWeight.w700,
        letterSpacing: -0.3,
      );

  static TextStyle get h2 => _style(
        fontSize: 18,
        weight: FontWeight.w700,
        letterSpacing: -0.2,
      );

  static TextStyle get h3 => _style(
        fontSize: 15,
        weight: FontWeight.w600,
      );

  // ── Body ──────────────────────────────────────────────────────────────
  static TextStyle get bodyMedium => _style(
        fontSize: 14,
        weight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle get bodySmall => _style(
        fontSize: 12,
        weight: FontWeight.w400,
        color: AppColors.mutedText,
        height: 1.4,
      );

  // ── Labels / Captions ─────────────────────────────────────────────────
  static TextStyle get label => _style(
        fontSize: 12,
        weight: FontWeight.w500,
        color: AppColors.mutedText,
        letterSpacing: 0.2,
      );

  static TextStyle get labelBold => _style(
        fontSize: 12,
        weight: FontWeight.w700,
        letterSpacing: 0.3,
      );

  static TextStyle get caption => _style(
        fontSize: 11,
        weight: FontWeight.w400,
        color: AppColors.mutedText,
      );

  // ── Amount ────────────────────────────────────────────────────────────
  static TextStyle amountStyle({required bool isDebit, double fontSize = 15}) =>
      _style(
        fontSize: fontSize,
        weight: FontWeight.w700,
        color: isDebit ? AppColors.expenseRed : AppColors.incomeGreen,
        letterSpacing: -0.3,
      );

  // ── Buttons ───────────────────────────────────────────────────────────
  static TextStyle get buttonText => _style(
        fontSize: 15,
        weight: FontWeight.w600,
        letterSpacing: 0.2,
      );

  // ── Greeting ──────────────────────────────────────────────────────────
  static TextStyle get greeting => _style(
        fontSize: 15,
        weight: FontWeight.w500,
        color: AppColors.mutedText,
      );

  // ── Full ThemeData text theme ─────────────────────────────────────────
  /// Pass this to [ThemeData.textTheme] in main.dart. Replaces the
  /// GoogleFonts.interTextTheme() call — no network required.
  static TextTheme get textTheme => TextTheme(
        displayLarge: _style(
            fontSize: 57, weight: FontWeight.w700, letterSpacing: -0.25),
        displayMedium: _style(
            fontSize: 45, weight: FontWeight.w700, letterSpacing: -0.25),
        displaySmall: _style(fontSize: 36, weight: FontWeight.w700),
        headlineLarge: h1,
        headlineMedium: h2,
        headlineSmall: h3,
        titleLarge: _style(
            fontSize: 22, weight: FontWeight.w700, letterSpacing: -0.2),
        titleMedium: _style(
            fontSize: 16, weight: FontWeight.w600, letterSpacing: -0.1),
        titleSmall: _style(fontSize: 14, weight: FontWeight.w600),
        bodyLarge: bodyMedium,
        bodyMedium: bodySmall,
        bodySmall: caption,
        labelLarge: buttonText,
        labelMedium: label,
        labelSmall: caption,
      );
}
