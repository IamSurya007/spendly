import '../../features/investments/models/investment_model.dart';

/// Contract for all investment data operations.
///
/// Implementations:
///   - [FirestoreInvestmentRepository]  (current)
///   - IsarInvestmentRepository         (future)
abstract interface class IInvestmentRepository {
  /// Real-time stream of all investments, sorted by maturity date ascending.
  Stream<List<Investment>> watchInvestments();

  Future<void> addInvestment(Investment investment);
  Future<void> updateInvestment(Investment investment);
  Future<void> deleteInvestment(String id);
}
