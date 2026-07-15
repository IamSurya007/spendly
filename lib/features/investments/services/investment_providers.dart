import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/repository_providers.dart';
import '../../../core/repositories/i_investment_repository.dart';
import '../models/investment_model.dart';

/// Real-time stream of all investments, sorted by maturity date.
final investmentsStreamProvider = StreamProvider<List<Investment>>((ref) {
  return ref.watch(investmentRepositoryProvider).watchInvestments();
});

/// Mutates investments via [IInvestmentRepository].
class InvestmentNotifier extends StateNotifier<AsyncValue<void>> {
  InvestmentNotifier(this._repo) : super(const AsyncValue.data(null));

  final IInvestmentRepository _repo;

  Future<void> addInvestment(Investment investment) async {
    state = const AsyncValue.loading();
    try {
      await _repo.addInvestment(investment);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateInvestment(Investment investment) async {
    state = const AsyncValue.loading();
    try {
      await _repo.updateInvestment(investment);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteInvestment(String id) async {
    await _repo.deleteInvestment(id);
  }
}

final investmentNotifierProvider =
    StateNotifierProvider<InvestmentNotifier, AsyncValue<void>>((ref) {
  return InvestmentNotifier(ref.watch(investmentRepositoryProvider));
});
