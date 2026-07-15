import 'package:flutter_test/flutter_test.dart';
import 'package:spendly/core/sync/conflict_resolver.dart';
import 'package:spendly/core/sync/sync_metadata.dart';
import 'package:spendly/core/sync/outbox_operation.dart';

void main() {
  group('ConflictResolver Tests', () {
    test('Remote overwrite when local is not dirty', () {
      final res = ConflictResolver.resolve(
        entityType: 'expense',
        localIsDirty: false,
        localVersion: 1,
        localUpdatedAt: DateTime(2026, 7, 10),
        localIsDeleted: false,
        remoteVersion: 2,
        remoteUpdatedAt: DateTime(2026, 7, 11),
        remoteIsDeleted: false,
        localPayload: {'amount': 100.0},
        remotePayload: {'amount': 120.0},
      );
      expect(res.action, equals(ConflictResolution.useRemote));
    });

    test('Local wins when remote is older or equal version', () {
      final res = ConflictResolver.resolve(
        entityType: 'expense',
        localIsDirty: true,
        localVersion: 2,
        localUpdatedAt: DateTime(2026, 7, 12),
        localIsDeleted: false,
        remoteVersion: 2,
        remoteUpdatedAt: DateTime(2026, 7, 11),
        remoteIsDeleted: false,
        localPayload: {'amount': 150.0},
        remotePayload: {'amount': 120.0},
      );
      expect(res.action, equals(ConflictResolution.useLocal));
    });

    test('Delete wins over edit', () {
      final res = ConflictResolver.resolve(
        entityType: 'expense',
        localIsDirty: true,
        localVersion: 2,
        localUpdatedAt: DateTime(2026, 7, 12),
        localIsDeleted: true,
        remoteVersion: 3,
        remoteUpdatedAt: DateTime(2026, 7, 13),
        remoteIsDeleted: false,
        localPayload: {'amount': 150.0},
        remotePayload: {'amount': 120.0},
      );
      expect(res.action, equals(ConflictResolution.delete));
    });

    test('Divergent loan status triggers conflict', () {
      final res = ConflictResolver.resolve(
        entityType: 'loan',
        localIsDirty: true,
        localVersion: 2,
        localUpdatedAt: DateTime(2026, 7, 12),
        localIsDeleted: false,
        remoteVersion: 3,
        remoteUpdatedAt: DateTime(2026, 7, 13),
        remoteIsDeleted: false,
        localPayload: {'status': 'PAID', 'principal': 5000.0},
        remotePayload: {'status': 'OVERDUE', 'principal': 5000.0},
      );
      expect(res.action, equals(ConflictResolution.conflict));
    });

    test('Standard LWW by timestamp when version conflict occurs and status is same', () {
      final res = ConflictResolver.resolve(
        entityType: 'loan',
        localIsDirty: true,
        localVersion: 1,
        localUpdatedAt: DateTime(2026, 7, 12, 10),
        localIsDeleted: false,
        remoteVersion: 2,
        remoteUpdatedAt: DateTime(2026, 7, 12, 11),
        remoteIsDeleted: false,
        localPayload: {'status': 'ACTIVE', 'principal': 4000.0},
        remotePayload: {'status': 'ACTIVE', 'principal': 5000.0},
      );
      expect(res.action, equals(ConflictResolution.useRemote));
    });
  });

  group('Outbox Retry Policy Test', () {
    test('Exponential retry calculation has correct backoff bounds', () {
      int calculateDelaySecs(int attemptCount) {
        const base = 2;
        const maxDelay = 300;
        return (base * (1 << attemptCount)).clamp(base, maxDelay);
      }

      expect(calculateDelaySecs(0), equals(2));
      expect(calculateDelaySecs(1), equals(4));
      expect(calculateDelaySecs(2), equals(8));
      expect(calculateDelaySecs(3), equals(16));
      expect(calculateDelaySecs(8), equals(300)); // Cap at 300 seconds (5 min)
      expect(calculateDelaySecs(12), equals(300));
    });
  });
}
