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

      final List<ParsedSms> transactions = [];
      for (final msg in messages) {
        final body = msg.body;
        final date = msg.date;
        if (body != null) {
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

  /// Checks if MainActivity has a pending transaction from a notification tap.
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

  /// The regex parsing logic for Indian Banking SMS messages (HDFC, ICICI, SBI, UPI, etc.)
  static ParsedSms? parseSmsBody(String body, DateTime smsTime) {
    final cleanBody = body.toLowerCase();

    // Check for currency symbols / transaction keywords
    if (!cleanBody.contains('rs') &&
        !cleanBody.contains('inr') &&
        !cleanBody.contains('rupee')) {
      return null;
    }

    // Extract amount: Matches "Rs. 150.00", "INR 500", "Rs 1,500.25", etc.
    final amountRegex = RegExp(
      r'(?:rs\.?|inr|rupees?)\s*([0-9,]+\.?[0-9]*)',
      caseSensitive: false,
    );
    final amountMatch = amountRegex.firstMatch(body);
    if (amountMatch == null) return null;

    final amountStr = amountMatch.group(1)?.replaceAll(',', '') ?? '';
    final amount = double.tryParse(amountStr);
    if (amount == null || amount <= 0) return null;

    // Check transaction flow type
    final isDebit = cleanBody.contains('debited') ||
        cleanBody.contains('sent') ||
        cleanBody.contains('paid') ||
        cleanBody.contains('spent') ||
        cleanBody.contains('charged') ||
        cleanBody.contains('withdrawn') ||
        cleanBody.contains('txn') ||
        cleanBody.contains('transacted');

    final isCredit = cleanBody.contains('credited') ||
        cleanBody.contains('received') ||
        cleanBody.contains('deposited') ||
        cleanBody.contains('refunded');

    final debit = isDebit || !isCredit;

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
