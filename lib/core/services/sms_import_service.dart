import '../../features/accounts/models/account_model.dart';
import '../../features/categories/models/category.dart';
import '../../features/categories/services/category_resolver.dart';
import '../../features/categories/services/merchant_categorizer.dart';
import '../../features/expenses/models/expense_model.dart';
import '../repositories/i_account_repository.dart';
import '../repositories/i_expense_repository.dart';
import 'sms_account_resolver.dart';
import 'sms_dedup.dart';
import 'sms_parser_service.dart';

/// Turns parsed SMS into expenses. Shared by the inbox scan and live
/// auto-capture so both use the same id, duplicate check and categorisation.
class SmsImportService {
  final IExpenseRepository _expenseRepo;
  final IAccountRepository _accountRepo;

  SmsImportService(this._expenseRepo, this._accountRepo);

  /// Drops SMS that are already stored (including ones the user deleted) and
  /// repeats within [txns].
  Future<List<ParsedSms>> filterNew(List<ParsedSms> txns) async {
    final existingIds = await _expenseRepo.getAllExpenseIds();
    final seen = <String>{};
    final result = <ParsedSms>[];
    for (final txn in txns) {
      final key = txn.dedupKey;
      if (!seen.add(key)) continue;
      if (await _isDuplicate(txn, existingIds)) continue;
      result.add(txn);
    }
    return result;
  }

  Future<bool> _isDuplicate(ParsedSms txn, Set<String> existingIds) async {
    if (existingIds.contains(txn.dedupKey) || existingIds.contains(txn.legacyKey)) {
      return true;
    }
    // Rows saved by older builds used an id derived from the (receive) time,
    // amount and merchant, which cannot be recomputed from the inbox exactly.
    // Treat a nearby row with the same amount as a duplicate only when its
    // id proves it came from that legacy SMS scheme; genuine repeat payments
    // (two ₹20 chais) have different v2 ids and are kept.
    final signed = txn.isDebit ? txn.amount : -txn.amount;
    final near = await _expenseRepo.findExpensesNear(amount: signed, date: txn.date);
    return near.any(_isLegacySmsRow);
  }

  static bool _isLegacySmsRow(Expense e) {
    final ms = e.date.millisecondsSinceEpoch;
    final amount = e.amount.abs();
    return e.id == SmsDedup.legacyKey(dateMs: ms, amount: amount, merchant: e.merchant) ||
        e.id == SmsDedup.legacyKeyWithPrefix('spendly', dateMs: ms, amount: amount, merchant: e.merchant);
  }

  /// Category for [txn]: the user's merchant rule, then the keyword table,
  /// then the default for debits/credits.
  Future<({CategorySelection selection, bool fromRule})> categorize(ParsedSms txn) async {
    final rule = await _expenseRepo.getMerchantRule(txn.merchant);
    if (rule != null) return (selection: rule, fromRule: true);
    final guessed = MerchantCategorizer.categorize(txn.merchant);
    return (
      selection: guessed ?? CategoryResolver.defaultFor(isCredit: !txn.isDebit),
      fromRule: false,
    );
  }

  /// Saves [txn] unless it is a duplicate. Returns the saved expense, or null.
  Future<Expense?> import(ParsedSms txn, {required String note}) async {
    final existingIds = await _expenseRepo.getAllExpenseIds();
    if (await _isDuplicate(txn, existingIds)) return null;

    final accountId = await SmsAccountResolver(_accountRepo).resolveAccountId(txn);
    final (:selection, :fromRule) = await categorize(txn);

    final expense = Expense(
      id: txn.dedupKey,
      amount: txn.isDebit ? txn.amount : -txn.amount,
      category: '',
      categoryId: selection.categoryId,
      subcategoryId: selection.subcategoryId,
      note: note,
      date: txn.date,
      method: txn.accountType == AccountType.credit_card
          ? 'card'
          : (txn.accountType == AccountType.cash ? 'cash' : 'upi'),
      source: 'sms',
      merchant: txn.merchant,
      accountId: accountId,
      createdAt: DateTime.now(),
    );

    await _expenseRepo.addExpense(expense);
    return expense;
  }
}
