import 'package:flutter/services.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../features/accounts/models/account_model.dart';

/// Prefilled transaction details extracted from SMS.
class ParsedSms {
  final double amount;
  final String merchant;
  final String account;
  final String bankName;
  final String accountSnippet;
  final AccountType accountType;
  final bool isDebit;
  final DateTime date;
  final String body;

  const ParsedSms({
    required this.amount,
    required this.merchant,
    required this.account,
    this.bankName = 'Bank',
    this.accountSnippet = '',
    this.accountType = AccountType.bank_account,
    required this.isDebit,
    required this.date,
    required this.body,
  });

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'merchant': merchant,
        'account': account,
        'bankName': bankName,
        'accountSnippet': accountSnippet,
        'accountType': accountType.name,
        'isDebit': isDebit,
        'date': date.toIso8601String(),
        'body': body,
      };
}

/// Service to handle SMS permissions, scanning local SMS inbox, and
/// listening to real-time auto-capture intents from the native BroadcastReceiver.
class SmsParserService {
  static const _channel = MethodChannel('com.surya.fiscora/sms_channel');
  final SmsQuery _query = SmsQuery();

  /// Requests SMS and Notification permissions on Android.
  Future<bool> requestPermissions() async {
    final smsStatus = await Permission.sms.request();
    final notifStatus = await Permission.notification.request();
    return smsStatus.isGranted && notifStatus.isGranted;
  }

  /// Scans the last [limit] messages in the device inbox and returns parsed transactions.
  /// Useful to backfill/import old expenses without waiting for new SMS messages.
  Future<List<ParsedSms>> scanInbox({int limit = 500}) async {
    final status = await Permission.sms.status;
    if (!status.isGranted) return [];

    try {
      final messages = await _query.querySms(
        kinds: [SmsQueryKind.inbox],
        count: limit,
      );
      final List<ParsedSms> transactions = [];
      for (final msg in messages) {
        final body = msg.body;
        final date = msg.date;
        final sender = msg.address ?? '';
        if (body != null && _isLikelyTransactionalSender(sender)) {
          final parsed = parseSmsBody(body, date ?? DateTime.now(), sender: sender);
          if (parsed != null) {
            transactions.add(parsed);
          }
        }
      }
      return transactions;
    } catch (e) {
      return [];
    }
  }

  Future<ParsedSms?> getPendingTransaction() async {
    try {
      final Map<dynamic, dynamic>? pending =
      await _channel.invokeMethod('getPendingTransaction');
      if (pending != null) {
        return _parsePlatformMap(pending);
      }
    } catch (_) {}
    return null;
  }

  Future<List<ParsedSms>> getPendingTransactions() async {
    try {
      final List<dynamic>? pendingList =
          await _channel.invokeListMethod('getPendingTransactions');
      if (pendingList != null && pendingList.isNotEmpty) {
        final List<ParsedSms> results = [];
        for (final item in pendingList) {
          if (item is Map) {
            final parsed = _parsePlatformMap(item);
            if (parsed != null) {
              results.add(parsed);
            }
          }
        }
        return results;
      }
    } catch (_) {}

    final single = await getPendingTransaction();
    if (single != null) {
      return [single];
    }
    return [];
  }

  Future<void> clearPendingTransactions() async {
    try {
      await _channel.invokeMethod('clearPendingTransactions');
    } catch (_) {}
  }

  /// Listens to real-time platform channel transactions captured while app is open.
  void setIncomingTransactionListener(void Function(ParsedSms) onCaptured) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onTransactionCaptured') {
        final args = call.arguments;
        if (args is Map) {
          final parsed = _parsePlatformMap(args);
          if (parsed != null) {
            onCaptured(parsed);
          }
        }
      }
    });
  }

  ParsedSms? _parsePlatformMap(Map<dynamic, dynamic> map) {
    final amountVal = map['amount'];
    final amount = amountVal is num ? amountVal.toDouble() : 0.0;
    if (amount <= 0) return null;

    final dateStr = map['date'] as String? ?? '';
    final date = DateTime.tryParse(dateStr) ?? DateTime.now();
    final body = map['body'] as String? ?? '';
    final sender = map['sender'] as String? ?? '';

    return parseSmsBody(body, date, sender: sender) ??
        ParsedSms(
          amount: amount,
          merchant: map['merchant'] as String? ?? 'Unknown Merchant',
          account: 'SMS Account',
          bankName: 'Bank',
          accountSnippet: '',
          accountType: AccountType.bank_account,
          isDebit: map['isDebit'] as bool? ?? true,
          date: date,
          body: body,
        );
  }

  static String detectBankName(String sender, String body) {
    final upperSender = sender.toUpperCase();
    final lowerBody = body.toLowerCase();

    if (upperSender.contains('HDFC') || lowerBody.contains('hdfc')) return 'HDFC Bank';
    if (upperSender.contains('ICICI') || lowerBody.contains('icici')) return 'ICICI Bank';
    if (upperSender.contains('SBI') || lowerBody.contains('sbi')) return 'SBI';
    if (upperSender.contains('AXIS') || lowerBody.contains('axis')) return 'Axis Bank';
    if (upperSender.contains('KOTAK') || lowerBody.contains('kotak')) return 'Kotak Bank';
    if (upperSender.contains('PYTM') || upperSender.contains('PAYTM') || lowerBody.contains('paytm')) return 'Paytm';
    if (upperSender.contains('GPAY') || lowerBody.contains('gpay') || lowerBody.contains('google pay')) return 'Google Pay';
    if (upperSender.contains('PHONPE') || lowerBody.contains('phonepe')) return 'PhonePe';
    if (upperSender.contains('AMAZON') || lowerBody.contains('amazon pay')) return 'Amazon Pay';
    if (upperSender.contains('YES') || lowerBody.contains('yes bank')) return 'Yes Bank';
    if (upperSender.contains('IDFC') || lowerBody.contains('idfc')) return 'IDFC First Bank';
    if (upperSender.contains('PNB') || lowerBody.contains('pnb')) return 'PNB';
    if (upperSender.contains('BOI') || lowerBody.contains('bank of india')) return 'Bank of India';
    if (upperSender.contains('UNION') || lowerBody.contains('union bank')) return 'Union Bank';
    if (upperSender.contains('CANBNK') || lowerBody.contains('canara bank')) return 'Canara Bank';
    if (upperSender.contains('CENTBK') || lowerBody.contains('central bank')) return 'Central Bank';
    if (upperSender.contains('INDUS') || lowerBody.contains('indusind')) return 'IndusInd Bank';
    if (upperSender.contains('RBL') || lowerBody.contains('rbl')) return 'RBL Bank';
    if (upperSender.contains('BOB') || lowerBody.contains('bank of baroda')) return 'Bank of Baroda';
    if (upperSender.contains('HSBC') || lowerBody.contains('hsbc')) return 'HSBC Bank';
    if (upperSender.contains('FED') || lowerBody.contains('federal bank')) return 'Federal Bank';
    if (upperSender.contains('AUBNK') || lowerBody.contains('au bank')) return 'AU Small Finance Bank';

    return 'Bank';
  }

  static AccountType detectAccountType(String body) {
    final lower = body.toLowerCase();
    if (lower.contains('credit card') ||
        lower.contains('card ending') ||
        lower.contains('cc ending') ||
        lower.contains('cc no') ||
        lower.contains('card xx') ||
        lower.contains('card ending in') ||
        lower.contains('charged to card')) {
      return AccountType.credit_card;
    }
    if (lower.contains('wallet') ||
        lower.contains('paytm wallet') ||
        lower.contains('amazon balance') ||
        lower.contains('wallet balance')) {
      return AccountType.wallet;
    }
    return AccountType.bank_account;
  }

  static ParsedSms? parseSmsBody(String body, DateTime smsTime, {String sender = ''}) {
    final cleanBody = body.toLowerCase();

    // 1. Exclude explicit marketing / promotional spam (refined to avoid dropping real receipts)
    const promoSpamKeywords = [
      'pre-approved', 'preapproved', 'pre approved',
      'instant loan', 'apply now', 'apply for card', 'loan offer',
      'credit limit enhance', 'win up to', 'congratulations! you have won',
      'you have won', 'claim your reward', 'click to apply',
      'download the app to claim', 'buy now pay later', 'flat % off',
    ];
    if (promoSpamKeywords.any((k) => cleanBody.contains(k))) return null;

    // 2. Debit / Credit Direction Check
    final isDebit = cleanBody.contains('debited') ||
        cleanBody.contains('sent') ||
        cleanBody.contains('paid') ||
        cleanBody.contains('spent') ||
        cleanBody.contains('charged') ||
        cleanBody.contains('withdrawn') ||
        cleanBody.contains('transferred') ||
        cleanBody.contains('txnd') ||
        cleanBody.contains('txn of') ||
        cleanBody.contains('purchase of') ||
        cleanBody.contains('payment of') ||
        cleanBody.contains('transfer to') ||
        cleanBody.contains('used at') ||
        cleanBody.contains('drawn');

    final isCredit = cleanBody.contains('credited') ||
        cleanBody.contains('received') ||
        cleanBody.contains('deposited') ||
        cleanBody.contains('refunded') ||
        cleanBody.contains('added') ||
        cleanBody.contains('cashback of');

    if (!isDebit && !isCredit) return null;

    // 3. Amount Extraction (supports Rs, Rs., INR, Rupees, ₹, e.g. Rs 500 or 500 INR)
    final amountRegex = RegExp(
      r'(?:rs\.?|inr|rupees?|₹)\s*([0-9,]+(?:\.[0-9]+)?)|([0-9,]+(?:\.[0-9]+)?)\s*(?:rs\.?|inr|rupees?|₹|/-)',
      caseSensitive: false,
    );
    final amountMatch = amountRegex.firstMatch(body);
    if (amountMatch == null) return null;

    final amountStr = (amountMatch.group(1) ?? amountMatch.group(2))?.replaceAll(',', '') ?? '';
    final amount = double.tryParse(amountStr);
    if (amount == null || amount <= 0) return null;

    final debit = isDebit || !isCredit;

    // 4. Extract Merchant Name (words after "to", "at", "towards", "via", "spent on", or "info:")
    String merchant = 'Unknown Merchant';
    final toAtPatterns = [
      RegExp(
        r'(?:to|at|towards|via|spent on|paid to)\s+([a-zA-Z0-9\s\.\-\*@]+?)(?:\s+on|\s+ref|\s+via|\s+from|\s+bal|\s+avl|\.|$)',
        caseSensitive: false,
      ),
      RegExp(
        r'(?:info:?|vpa:?|merchant:?)\s*([a-zA-Z0-9\s\.\-\*@]+?)(?:\s+on|\s+ref|\.|$)',
        caseSensitive: false,
      ),
    ];

    for (final pattern in toAtPatterns) {
      final match = pattern.firstMatch(body);
      if (match != null) {
        final name = match.group(1)?.trim();
        if (name != null && name.isNotEmpty && name.length < 30) {
          merchant = _cleanMerchantName(name);
          break;
        }
      }
    }

    // 5. Extract Bank & Account Snippet
    final bankName = detectBankName(sender, body);
    final accType = detectAccountType(body);
    String snippet = '';

    final snippetPatterns = [
      RegExp(r'(?:a/c|acct|account|card|ending(?:\s+in)?)\s*(?:no\.?|num\.?|number)?\s*[:\s]*\*?[x*]*([0-9]{3,4})', caseSensitive: false),
      RegExp(r'[x*]{2,}([0-9]{3,4})', caseSensitive: false),
      RegExp(r'(?:a/c|acct|account|card)\s*(?:no\.?|num\.?|number)?\s*[:\s]*([0-9]{3,4})', caseSensitive: false),
    ];

    for (final pat in snippetPatterns) {
      final match = pat.firstMatch(body);
      if (match != null) {
        final digits = match.group(1);
        if (digits != null && digits.isNotEmpty) {
          snippet = 'xx$digits';
          break;
        }
      }
    }

    final accountTitle = snippet.isNotEmpty
        ? '$bankName ($snippet)'
        : (bankName != 'Bank' ? bankName : 'Bank Account');

    return ParsedSms(
      amount: amount,
      merchant: merchant,
      account: accountTitle,
      bankName: bankName,
      accountSnippet: snippet,
      accountType: accType,
      isDebit: debit,
      date: smsTime,
      body: body,
    );
  }

  static String _cleanMerchantName(String name) {
    var cleaned = name.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (cleaned.contains('@')) {
      cleaned = cleaned.split('@').first;
    }

    // Capitalize each word
    if (cleaned.isNotEmpty) {
      cleaned = cleaned.split(' ').map((word) {
        if (word.isEmpty) return '';
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }).join(' ');
    }

    return cleaned.isNotEmpty ? cleaned : 'Unknown Merchant';
  }

  static bool _isLikelyTransactionalSender(String sender) {
    final upper = sender.toUpperCase().trim();
    if (upper.isEmpty) return true;

    // Long plain phone numbers are usually not bank DLT headers
    if (RegExp(r'^\+?\d{10,}$').hasMatch(upper)) return false;

    return true;
  }
}
