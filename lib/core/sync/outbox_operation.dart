import 'package:isar_plus/isar_plus.dart';

part 'outbox_operation.g.dart';

enum OutboxStatus {
  queued,
  inFlight,
  failed,
  done,
}

@collection
class OutboxOperation {
  OutboxOperation({
    this.id = 0,
    required this.entityType,
    required this.clientId,
    required this.operationType,
    required this.payloadJson,
    required this.createdAt,
    required this.attemptCount,
    required this.lastAttemptAt,
    required this.nextRetryAt,
    required this.outboxStatus,
  });

  int id;
  late String entityType;
  late String clientId;
  late String operationType;
  late String payloadJson;
  late DateTime createdAt;
  int attemptCount;
  late DateTime lastAttemptAt;
  late DateTime nextRetryAt;
  late String outboxStatus;

  @ignore
  OutboxStatus get status {
    return OutboxStatus.values.firstWhere(
          (e) => e.name == outboxStatus,
      orElse: () => OutboxStatus.failed,
    );
  }
}