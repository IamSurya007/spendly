import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/i_expense_repository.dart';
import '../repositories/i_investment_repository.dart';
import '../repositories/i_loan_repository.dart';
import '../repositories/i_user_repository.dart';
import '../../features/expenses/data/repositories/firestore_expense_repository.dart';
import '../../features/investments/data/repositories/firestore_investment_repository.dart';
import '../../features/loans/data/repositories/firestore_loan_repository.dart';
import '../../features/auth/data/repositories/firestore_user_repository.dart';

// ─────────────────────────────────────────────────────────────────────────────
// THE SINGLE FILE TO CHANGE WHEN SWAPPING THE DATA BACKEND.
//
// Current backend: Cloud Firestore (online-first, with native offline cache)
//
// To switch to Isar + Custom REST API (Phase 2+):
//   1. Create IsarExpenseRepository, IsarLoanRepository, etc.
//   2. Replace the RHS of each provider below with the new implementation.
//   3. Zero changes needed in providers, screens, or notifiers.
// ─────────────────────────────────────────────────────────────────────────────

final expenseRepositoryProvider = Provider<IExpenseRepository>((ref) {
  return FirestoreExpenseRepository();
});

final loanRepositoryProvider = Provider<ILoanRepository>((ref) {
  return FirestoreLoanRepository();
});

final investmentRepositoryProvider = Provider<IInvestmentRepository>((ref) {
  return FirestoreInvestmentRepository();
});

final userRepositoryProvider = Provider<IUserRepository>((ref) {
  return FirestoreUserRepository();
});
