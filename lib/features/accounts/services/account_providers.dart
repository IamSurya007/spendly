import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/repository_providers.dart';
import '../../../core/repositories/i_account_repository.dart';
import '../models/account_model.dart';

/// Real-time stream of active accounts.
final accountsStreamProvider = StreamProvider<List<Account>>((ref) {
  final repo = ref.watch(accountRepositoryProvider);
  return repo.watchAccounts();
});

/// Total liquid balance across non-credit accounts (Bank + Cash + Wallet).
final totalLiquidBalanceProvider = Provider<double>((ref) {
  final accounts = ref.watch(accountsStreamProvider).valueOrNull ?? [];
  return accounts
      .where((a) => !a.isCreditCard)
      .fold(0.0, (sum, a) => sum + a.currentBalance);
});

/// Total credit card outstanding balance across credit card accounts.
final totalCreditOutstandingProvider = Provider<double>((ref) {
  final accounts = ref.watch(accountsStreamProvider).valueOrNull ?? [];
  return accounts
      .where((a) => a.isCreditCard)
      .fold(0.0, (sum, a) => sum + a.currentBalance);
});

/// Mutates accounts via [IAccountRepository].
class AccountNotifier extends StateNotifier<AsyncValue<void>> {
  AccountNotifier(this._repo) : super(const AsyncValue.data(null));

  final IAccountRepository _repo;

  Future<void> addAccount(Account account) async {
    state = const AsyncValue.loading();
    try {
      await _repo.addAccount(account);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateAccount(Account account) async {
    state = const AsyncValue.loading();
    try {
      await _repo.updateAccount(account);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateAccountBalance(String id, double newBalance) async {
    state = const AsyncValue.loading();
    try {
      await _repo.updateAccountBalance(id, newBalance);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteAccount(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repo.deleteAccount(id);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final accountNotifierProvider =
    StateNotifierProvider<AccountNotifier, AsyncValue<void>>((ref) {
  return AccountNotifier(ref.watch(accountRepositoryProvider));
});
