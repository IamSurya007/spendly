import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/i_expense_repository.dart';
import '../repositories/i_investment_repository.dart';
import '../repositories/i_loan_repository.dart';
import '../repositories/i_user_repository.dart';
import '../repositories/isar_expense_repository.dart';
import '../repositories/isar_loan_repository.dart';
import '../repositories/isar_investment_repository.dart';
import '../repositories/isar_user_repository.dart';
import '../sync/sync_api_client.dart';

// ─────────────────────────────────────────────────────────────────────────────
// THE SINGLE FILE TO CHANGE WHEN SWAPPING THE DATA BACKEND.
//
// Current backend: Isar Local DB (Offline-First) + REST Sync API
// ─────────────────────────────────────────────────────────────────────────────

final syncApiClientProvider = Provider<SyncApiClient>((ref) {
  return SyncApiClient();
});

final expenseRepositoryProvider = Provider<IExpenseRepository>((ref) {
  return IsarExpenseRepository();
});

final loanRepositoryProvider = Provider<ILoanRepository>((ref) {
  return IsarLoanRepository();
});

final investmentRepositoryProvider = Provider<IInvestmentRepository>((ref) {
  return IsarInvestmentRepository();
});

final userRepositoryProvider = Provider<IUserRepository>((ref) {
  return IsarUserRepository(ref.watch(syncApiClientProvider));
});
