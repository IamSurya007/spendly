import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/repository_providers.dart';
import '../../../core/repositories/i_loan_repository.dart';
import '../models/loan_model.dart';

/// Real-time stream of all loans, newest first.
final loansStreamProvider = StreamProvider<List<Loan>>((ref) {
  return ref.watch(loanRepositoryProvider).watchLoans();
});

/// Loans split into taken (you owe) and given (they owe you).
final loansGivenTakenProvider =
    Provider<({List<Loan> taken, List<Loan> given})>((ref) {
  final loans = ref.watch(loansStreamProvider).valueOrNull ?? [];
  return (
    taken: loans.where((l) => l.type == 'taken').toList(),
    given: loans.where((l) => l.type == 'given').toList(),
  );
});

/// Mutates loans via [ILoanRepository].
class LoanNotifier extends StateNotifier<AsyncValue<void>> {
  LoanNotifier(this._repo) : super(const AsyncValue.data(null));

  final ILoanRepository _repo;

  Future<void> addLoan(Loan loan) async {
    state = const AsyncValue.loading();
    try {
      await _repo.addLoan(loan);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateStatus(String id, String status) async {
    await _repo.updateLoanStatus(id, status);
  }

  Future<void> deleteLoan(String id) async {
    await _repo.deleteLoan(id);
  }
}

final loanNotifierProvider =
    StateNotifierProvider<LoanNotifier, AsyncValue<void>>((ref) {
  return LoanNotifier(ref.watch(loanRepositoryProvider));
});
