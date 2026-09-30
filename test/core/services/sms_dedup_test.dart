import 'package:flutter_test/flutter_test.dart';
import 'package:fiscora/core/services/sms_dedup.dart';
import 'package:fiscora/core/services/sms_parser_service.dart';

void main() {
  const body = 'Rs.450.00 debited from A/c XX1234 on 12-09-26 to VPA swiggy@icici. Ref 123456789012';

  group('SmsDedup.key', () {
    test('is stable for the same SMS', () {
      final a = SmsDedup.key(sender: 'VM-HDFCBK', sentAtMs: 1757650000123, body: body);
      final b = SmsDedup.key(sender: 'VM-HDFCBK', sentAtMs: 1757650000123, body: body);
      expect(a, b);
    });

    test('ignores sender route prefix/suffix and sub-second jitter', () {
      final inbox = SmsDedup.key(sender: 'VM-HDFCBK', sentAtMs: 1757650000123, body: body);
      final live = SmsDedup.key(sender: 'JD-HDFCBK-S', sentAtMs: 1757650000999, body: body);
      final plain = SmsDedup.key(sender: 'HDFCBK', sentAtMs: 1757650000000, body: body);
      expect(live, inbox);
      expect(plain, inbox);
    });

    test('ignores whitespace differences from joining multipart SMS', () {
      final a = SmsDedup.key(sender: 'HDFCBK', sentAtMs: 1, body: body);
      final b = SmsDedup.key(sender: 'HDFCBK', sentAtMs: 1, body: '  ${body.replaceAll(' ', '  ')}\n');
      expect(a, b);
    });

    test('differs for different SMS', () {
      final a = SmsDedup.key(sender: 'HDFCBK', sentAtMs: 1757650000000, body: body);
      final laterSecond = SmsDedup.key(sender: 'HDFCBK', sentAtMs: 1757650001000, body: body);
      final otherBody = SmsDedup.key(sender: 'HDFCBK', sentAtMs: 1757650000000, body: '$body.');
      expect(laterSecond, isNot(a));
      expect(otherBody, isNot(a));
    });
  });

  group('ParsedSms keys', () {
    test('inbox scan and live capture of the same SMS produce the same id', () {
      final received = DateTime.fromMillisecondsSinceEpoch(1757650004000);
      final fromInbox = SmsParserService.parseSmsBody(body, received, sender: 'VM-HDFCBK')!
          .withSource(sender: 'VM-HDFCBK', sentAtMs: 1757650000000);
      // Live receiver sees the PDU timestamp (same second) and a later receive time.
      final fromLive = SmsParserService.parseSmsBody(body, received.add(const Duration(seconds: 2)), sender: 'JD-HDFCBK')!
          .withSource(sender: 'JD-HDFCBK', sentAtMs: 1757650000450);
      expect(fromLive.dedupKey, fromInbox.dedupKey);
    });

    test('legacy key matches the formula older builds used', () {
      final parsed = SmsParserService.parseSmsBody(body, DateTime.fromMillisecondsSinceEpoch(1000), sender: 'HDFCBK')!;
      expect(
        parsed.legacyKey,
        SmsDedup.legacyKey(dateMs: 1000, amount: parsed.amount, merchant: parsed.merchant),
      );
    });
  });
}
