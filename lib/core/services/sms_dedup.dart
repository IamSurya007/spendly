import 'package:uuid/uuid.dart';

/// Single source of truth for the identity of an SMS-derived transaction.
///
/// The key is derived only from facts that are identical no matter how the
/// SMS reached us (inbox scan, live BroadcastReceiver, pending queue) and
/// that survive an app reinstall:
///   * the sender header (normalised),
///   * the network "sent" timestamp at second precision
///     (inbox `date_sent` == PDU `timestampMillis`),
///   * the full message body (normalised whitespace).
///
/// It is used as the expense `clientId`, so the backend's
/// `(userId, clientId)` lookup deduplicates re-imports across installs.
class SmsDedup {
  SmsDedup._();

  static const _uuid = Uuid();

  static String key({
    required String sender,
    required int sentAtMs,
    required String body,
  }) {
    final normSender = normaliseSender(sender);
    final normBody = body.replaceAll(RegExp(r'\s+'), ' ').trim();
    final sentSeconds = sentAtMs ~/ 1000;
    return _uuid.v5(
      Namespace.url.value,
      'fiscora:sms:v2:$normSender|$sentSeconds|$normBody',
    );
  }

  /// Legacy (v1) id used before 2026-10. Kept so rows imported by older
  /// builds are still recognised as duplicates.
  static String legacyKey({
    required int dateMs,
    required double amount,
    required String merchant,
  }) =>
      legacyKeyWithPrefix('fiscora', dateMs: dateMs, amount: amount, merchant: merchant);

  /// Builds before the Fiscora rename used the `spendly:` prefix.
  static String legacyKeyWithPrefix(
    String prefix, {
    required int dateMs,
    required double amount,
    required String merchant,
  }) {
    return _uuid.v5(
      Namespace.url.value,
      '$prefix:sms:${dateMs}_${amount}_$merchant',
    );
  }

  /// "VM-HDFCBK", "JD-HDFCBK-S" and "HDFCBK" all map to "HDFCBK".
  static String normaliseSender(String sender) {
    var s = sender.toUpperCase().trim();
    final parts = s.split('-');
    if (parts.length >= 2 && parts[0].length == 2) {
      s = parts[1];
    }
    return s.replaceAll(RegExp(r'[^A-Z0-9+]'), '');
  }
}
