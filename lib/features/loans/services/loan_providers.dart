import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/firebase_service.dart';
import '../models/loan_model.dart';
import '../../expenses/services/expense_providers.dart';

/// Stream of all loans.
final loansStreamProvider = StreamProvider<List<Loan>>((ref) {
  final service = ref.watch(firestoreServiceProvider);
  return service.loansStream();
});

/// Loans you have taken (you owe).
final loansGivenTakenProvider = Provider<({List<Loan> taken, List<Loan> given})>(
  (ref) {
    final loans = ref.watch(loansStreamProvider).valueOrNull ?? [];
    return (
      taken: loans.where((l) => l.type == 'taken').toList(),
      given: loans.where((l) => l.type == 'given').toList(),
    );
  },
);

class LoanNotifier extends StateNotifier<AsyncValue<void>> {
  LoanNotifier(this._service) : super(const AsyncValue.data(null));

  final FirestoreService _service;

  Future<void> addLoan(Loan loan) async {
    state = const AsyncValue.loading();
    try {
      await _service.addLoan(loan);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateStatus(String id, String status) async {
    await _service.updateLoanStatus(id, status);
  }

  Future<void> deleteLoan(String id) async {
    await _service.deleteLoan(id);
  }
}

final loanNotifierProvider =
    StateNotifierProvider<LoanNotifier, AsyncValue<void>>((ref) {
  final service = ref.watch(firestoreServiceProvider);
  return LoanNotifier(service);
});
