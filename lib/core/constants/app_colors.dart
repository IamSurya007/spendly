import 'package:flutter/material.dart';

/// Spendly locked color palette — do not modify tokens, only add semantic aliases.
class AppColors {
  AppColors._();

  // ── Core palette ────────────────────────────────────
  /// Primary text, nav bar, headings
  static const Color primaryNavy = Color(0xFF0D1B3E);

  /// App background — cool blue-grey
  static const Color pageBackground = Color(0xFFECEEF4);

  /// All cards, list items
  static const Color cardSurface = Color(0xFFFFFFFF);

  /// Input backgrounds, icon chips
  static const Color inputFill = Color(0xFFF0F2F6);

  /// Active nav tab background
  static const Color activeNavBg = Color(0xFFEEF1F8);

  /// Active nav icon, interactive highlights, links
  static const Color accent = Color(0xFF3D7FE8);

  /// Labels, subtitles, secondary info
  static const Color mutedText = Color(0xFF7B8399);

  /// Card borders, dividers
  static const Color borderLight = Color(0xFFE4E7EF);

  /// Debit, expense amounts
  static const Color expenseRed = Color(0xFFC0293E);

  /// Credit, income amounts
  static const Color incomeGreen = Color(0xFF1A7A4A);

  // ── Nav bar ────────────────────────────────────────
  static const Color navBarBackground = Color(0x8CFFFFFF); // ~55% white
  static const Color navBarBorder = Color(0xCCFFFFFF);     // ~80% white
  static const Color inactiveNavIcon = Color(0xFFB0B8CC);

  // ── Login screen (kept dark) ───────────────────────
  static const Color loginNavy = Color(0xFF0F1729);
  static const Color loginNavyLight = Color(0xFF1A2540);
  static const Color loginGold = Color(0xFFF5C518);
  static const Color loginSlate = Color(0xFF8B95B0);
  static const Color loginOffWhite = Color(0xFFF0F4FF);

  // ── Category icon chip backgrounds ────────────────
  static const Color chipRent = Color(0xFFEFF3FF);
  static const Color chipSpends = Color(0xFFFFF3E0);
  static const Color chipLoans = Color(0xFFFFEBEE);
  static const Color chipInvest = Color(0xFFE8F5E9);
  static const Color chipOther = Color(0xFFF3E5F5);

  // ── Status chips ──────────────────────────────────
  static const Color statusActive = Color(0xFF1A7A4A);
  static const Color statusActiveBackground = Color(0xFFE8F5E9);
  static const Color statusOverdue = Color(0xFFC0293E);
  static const Color statusOverdueBackground = Color(0xFFFFEBEE);
  static const Color statusPaid = Color(0xFF7B8399);
  static const Color statusPaidBackground = Color(0xFFF0F2F6);
}
