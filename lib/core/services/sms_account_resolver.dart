import '../repositories/i_account_repository.dart';
import '../../features/accounts/models/account_model.dart';
import 'sms_parser_service.dart';

/// Helper service to auto-resolve or auto-create an Account from parsed SMS data.
class SmsAccountResolver {
  final IAccountRepository _accountRepo;

  SmsAccountResolver(this._accountRepo);

  /// Resolves an account for [sms]. If no matching account exists, auto-creates one.
  Future<String> resolveAccountId(ParsedSms sms) async {
    final bank = sms.bankName.isNotEmpty && sms.bankName != 'Bank' ? sms.bankName : 'Bank';
    final snippet = sms.accountSnippet.isNotEmpty ? sms.accountSnippet : 'xx----';
    final accName = '$bank ($snippet)';
    final accId = 'sms_acc_${bank.replaceAll(' ', '_').toLowerCase()}_${snippet.replaceAll('x', '').replaceAll('-', '')}';

    final accounts = await _accountRepo.getAccounts();

    // 1. The account this SMS would have created (stable across installs).
    for (final acc in accounts) {
      if (acc.id == accId) return acc.id;
    }

    // 2. Exact last-4 match wins over a bank-name match, so the second HDFC
    //    card does not get attributed to the first HDFC account.
    if (sms.accountSnippet.isNotEmpty) {
      for (final acc in accounts) {
        if (acc.name.contains(sms.accountSnippet)) return acc.id;
      }
    }

    // 3. Same bank, when the SMS did not reveal the last 4 digits.
    if (sms.accountSnippet.isEmpty &&
        sms.bankName.isNotEmpty &&
        sms.bankName != 'Bank' &&
        sms.bankName != 'Bank Account') {
      final bankLower = sms.bankName.toLowerCase();
      for (final acc in accounts) {
        if (acc.institution.toLowerCase().contains(bankLower) ||
            acc.name.toLowerCase().contains(bankLower)) {
          return acc.id;
        }
      }
    }

    // 4. No matching account found — auto-create account from SMS

    final newAccount = Account(
      id: accId,
      name: accName,
      type: sms.accountType,
      institution: bank,
      currentBalance: 0.0,
      colorValue: sms.accountType.defaultColor.value,
      createdAt: DateTime.now(),
    );

    await _accountRepo.addAccount(newAccount);
    return newAccount.id;
  }
}
