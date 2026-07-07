import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/firebase_service.dart';
import '../models/investment_model.dart';
import '../../expenses/services/expense_providers.dart';

/// Stream of all investments.
final investmentsStreamProvider = StreamProvider<List<Investment>>((ref) {
  final service = ref.watch(firestoreServiceProvider);
  return service.investmentsStream();
});

class InvestmentNotifier extends StateNotifier<AsyncValue<void>> {
  InvestmentNotifier(this._service) : super(const AsyncValue.data(null));

  final FirestoreService _service;

  Future<void> addInvestment(Investment investment) async {
    state = const AsyncValue.loading();
    try {
      await _service.addInvestment(investment);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteInvestment(String id) async {
    await _service.deleteInvestment(id);
  }
}

final investmentNotifierProvider =
    StateNotifierProvider<InvestmentNotifier, AsyncValue<void>>((ref) {
  final service = ref.watch(firestoreServiceProvider);
  return InvestmentNotifier(service);
});
