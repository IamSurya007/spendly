import '../../features/loans/models/loan_model.dart';

/// Contract for all loan data operations.
///
/// Implementations:
///   - [FirestoreLoanRepository]  (current)
///   - IsarLoanRepository         (future)
abstract interface class ILoanRepository {
  /// Real-time stream of all loans, newest first.
  Stream<List<Loan>> watchLoans();

  Future<void> addLoan(Loan loan);
  Future<void> updateLoan(Loan loan);
  Future<void> updateLoanStatus(String id, String status);
  Future<void> deleteLoan(String id);
}
