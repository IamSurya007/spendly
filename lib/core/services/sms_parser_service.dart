import 'package:flutter/services.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

/// Prefilled transaction details extracted from SMS.
class ParsedSms {
  final double amount;
  final String merchant;
  final String account;
  final bool isDebit;
  final DateTime date;
  final String body;

  const ParsedSms({
    required this.amount,
    required this.merchant,
    required this.account,
    required this.isDebit,
    required this.date,
    required this.body,
  });

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'merchant': merchant,
        'account': account,
        'isDebit': isDebit,
        'date': date.toIso8601String(),
        'body': body,
      };
}

/// Service to handle SMS permissions, scanning local SMS inbox, and
/// listening to real-time auto-capture intents from the native BroadcastReceiver.
class SmsParserService {
  static const _channel = MethodChannel('com.example.spendly/sms_channel');
  final SmsQuery _query = SmsQuery();

  /// Requests SMS and Notification permissions on Android.
  Future<bool> requestPermissions() async {
    final smsStatus = await Permission.sms.request();
    final notifStatus = await Permission.notification.request();
    return smsStatus.isGranted && notifStatus.isGranted;
  }

  /// Scans the last [limit] messages in the device inbox and returns parsed transactions.
  /// Useful to backfill/import old expenses without waiting for new SMS messages.
  Future<List<ParsedSms>> scanInbox({int limit = 50}) async {
    final status = await Permission.sms.status;
    if (!status.isGranted) return [];

    try {
      final messages = await _query.querySms(
        kinds: [SmsQueryKind.inbox],
        count: limit,
      );
      final uniqueSenders = messages.map((m) => m.address).toSet();
      print(uniqueSenders);
      final List<ParsedSms> transactions = [];
      for (final msg in messages) {
        final body = msg.body;
        final date = msg.date;
        final sender = msg.address ?? '';
        if (body != null && _isLikelyTransactionalSender(sender)) {
          final parsed = parseSmsBody(body, date ?? DateTime.now());
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

    return ParsedSms(
      amount: amount,
      merchant: map['merchant'] as String? ?? 'Unknown Merchant',
      account: 'SMS Capture',
      isDebit: map['isDebit'] as bool? ?? true,
      date: date,
      body: map['body'] as String? ?? '',
    );
  }

  static const _knownBankSenders = {
    'HDFCBK', 'ICICIB', 'SBIINB', 'SBIPSG', 'AXISBK', 'KOTAKB',
    'PAYTM', 'PYTM', 'GPAY', 'PHONPE', 'AMAZONP', 'YESBNK',
    'CENTBK', 'PNBSMS', 'BOIIND', 'UNIONB', 'CANBNK', 'IDFCFB',
  };

  static bool _isLikelyTransactionalSender(String sender) {
    final upper = sender.toUpperCase().trim();
    if (upper.isEmpty) return true; // don't reject on missing sender data — let content filters decide

    // Long plain phone numbers are never bank/DLT senders
    if (RegExp(r'^\+?\d{7,}$').hasMatch(upper)) return false;

    // DLT header pattern: XX-NAME-SUFFIX
    final match = RegExp(r'^[A-Z]{2}-([A-Z0-9]+)-([A-Z])$').firstMatch(upper);
    if (match != null) {
      final suffix = match.group(2);
      // T = Transactional, S = Service (explicit/implicit) — both can carry real transaction data
      // P = Promotional, G = Government — exclude
      return suffix == 'T' || suffix == 'S';
    }

    // Doesn't match the DLT pattern at all (e.g. bare shortcode) — pass through to content filters
    return true;
  }
  static ParsedSms? parseSmsBody(String body, DateTime smsTime) {
    final cleanBody = body.toLowerCase();

    // 1. Hard exclude promotional/marketing/offer language first
    const promoKeywords = [
      'sale', 'offer', 'cashback offer', '% off', 'discount', 'free',
      'win', 'buy now', 'shop now', 'voucher', 'coupon', 'deal',
      'subscribe', 'download the app', 'click here', 't&c apply',
      'limited period', 'extension', 'gift card', 'reward points expir',
      'pre-approved', 'preapproved', 'pre approved', 'eligib',
      'instant loan', 'apply now', 'interest rate', 'emi starts',
      'emi at', 'loan offer', 'credit limit enhance', 'insurance',
      'policy', 'invest now', 'mutual fund', 'trade now',
      'install', 'http://', 'https://', 'bit.ly', 'unsubscribe',
      'promo', 'flat ', 'starting at', 'hurry', 'last chance',
      'exclusive offer', 'congratulations', 'you have won', 'claim now',
    ];
    if (promoKeywords.any((k) => cleanBody.contains(k))) return null;

    // 2. Require SPECIFIC transaction evidence — masked account/card or txn ref
    final hasMaskedAccountOrCard = RegExp(
      r'(?:a/c|acc(?:t|ount)?|card)\s*(?:no\.?|number)?\s*[x*]{2,}\d{2,}',
      caseSensitive: false,
    ).hasMatch(cleanBody);

    final hasTxnRef = RegExp(
      r'(?:ref|txn|transaction)\s*(?:no|id)?[:.]?\s*\w{4,}',
      caseSensitive: false,
    ).hasMatch(cleanBody);

    final hasBalanceMention = cleanBody.contains('avl bal') ||
        cleanBody.contains('available balance') ||
        cleanBody.contains('bal:') ||
        cleanBody.contains('upi');

    final hasAccountEvidence =
        hasMaskedAccountOrCard || hasTxnRef || hasBalanceMention;

    final isDebit = cleanBody.contains('debited') ||
        cleanBody.contains('sent') ||
        cleanBody.contains('paid') ||
        cleanBody.contains('spent') ||
        cleanBody.contains('charged') ||
        cleanBody.contains('withdrawn');

    final isCredit = cleanBody.contains('credited') ||
        cleanBody.contains('received') ||
        cleanBody.contains('deposited') ||
        cleanBody.contains('refunded');

    // 3. Require explicit direction AND account evidence — no silent default
    if (!isDebit && !isCredit) return null;
    if (!hasAccountEvidence) return null;

    final amountRegex = RegExp(
      r'(?:rs\.?|inr|rupees?)\s*([0-9,]+\.?[0-9]*)',
      caseSensitive: false,
    );
    final amountMatch = amountRegex.firstMatch(body);
    if (amountMatch == null) return null;

    final amountStr = amountMatch.group(1)?.replaceAll(',', '') ?? '';
    final amount = double.tryParse(amountStr);
    if (amount == null || amount <= 0) return null;

    final debit = isDebit || !isCredit;

    // ... merchant + account extraction unchanged below
    // Extract Merchant Name (words after "to", "at", "towards", or "info:")
    String merchant = 'Unknown Merchant';
    final toAtPatterns = [
      RegExp(
        r'(?:to|at|towards)\s+([a-zA-Z0-9\s\.\-\*]+?)(?:\s+on|\s+ref|\s+via|\s+from|\s+balance|\.|$)',
        caseSensitive: false,
      ),
      RegExp(
        r'(?:info:?|vpa:?)\s*([a-zA-Z0-9\s\.\-\*@]+?)(?:\s+on|\s+ref|\.|$)',
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

    // Extract Bank Account Identifier
    String account = 'Bank Account';
    final acctPattern = RegExp(
      r'(?:a/c|acct|account|card)\s*(?:no\.?)?\s*\*?x*([0-9]{3,4})',
      caseSensitive: false,
    );
    final acctMatch = acctPattern.firstMatch(body);
    if (acctMatch != null) {
      account = 'A/c xxxx${acctMatch.group(1)}';
    }

    return ParsedSms(
      amount: amount,
      merchant: merchant,
      account: account,
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
}
