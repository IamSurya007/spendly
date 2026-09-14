import '../repositories/i_account_repository.dart';
import '../../features/accounts/models/account_model.dart';
import 'sms_parser_service.dart';

/// Helper service to auto-resolve or auto-create an Account from parsed SMS data.
class SmsAccountResolver {
  final IAccountRepository _accountRepo;

  SmsAccountResolver(this._accountRepo);

  /// Resolves an account for [sms]. If no matching account exists, auto-creates one.
  Future<String> resolveAccountId(ParsedSms sms) async {
    final accounts = await _accountRepo.getAccounts();

    // 1. Try to find an account matching exact snippet or bank name
    for (final acc in accounts) {
      if (sms.accountSnippet.isNotEmpty && acc.name.contains(sms.accountSnippet)) {
        return acc.id;
      }
      if (sms.bankName.isNotEmpty &&
          sms.bankName != 'Bank' &&
          sms.bankName != 'Bank Account' &&
          (acc.institution.toLowerCase().contains(sms.bankName.toLowerCase()) ||
              acc.name.toLowerCase().contains(sms.bankName.toLowerCase()))) {
        return acc.id;
      }
    }

    // 2. No matching account found — auto-create account from SMS
    final bank = sms.bankName.isNotEmpty && sms.bankName != 'Bank' ? sms.bankName : 'Bank';
    final snippet = sms.accountSnippet.isNotEmpty ? sms.accountSnippet : 'xx----';
    final accName = '$bank ($snippet)';

    final accId = 'sms_acc_${bank.replaceAll(' ', '_').toLowerCase()}_${snippet.replaceAll('x', '').replaceAll('-', '')}';

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
