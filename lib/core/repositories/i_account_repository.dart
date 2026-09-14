import '../../features/accounts/models/account_model.dart';

/// Contract for all account data operations.
abstract interface class IAccountRepository {
  /// Stream of active accounts (non-archived).
  Stream<List<Account>> watchAccounts();

  /// Get all accounts once.
  Future<List<Account>> getAccounts();

  /// Get account by ID.
  Future<Account?> getAccount(String id);

  /// Add a new account.
  Future<void> addAccount(Account account);

  /// Update account details.
  Future<void> updateAccount(Account account);

  /// Set explicit manual current balance override on an account.
  Future<void> updateAccountBalance(String id, double newBalance);

  /// Adjust account balance atomically by adding/subtracting delta.
  Future<void> adjustAccountBalance(String id, double delta);

  /// Soft delete or archive account.
  Future<void> deleteAccount(String id);

  /// Seed default accounts if none exist.
  Future<void> seedDefaultAccountsIfNeeded();
}
