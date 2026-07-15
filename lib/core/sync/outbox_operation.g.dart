// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outbox_operation.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetOutboxOperationCollection on Isar {
  IsarCollection<int, OutboxOperation> get outboxOperations =>
      this.collection();
}

final OutboxOperationSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'OutboxOperation',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(name: 'entityType', type: IsarType.string),
      IsarPropertySchema(name: 'clientId', type: IsarType.string),
      IsarPropertySchema(name: 'operationType', type: IsarType.string),
      IsarPropertySchema(name: 'payloadJson', type: IsarType.string),
      IsarPropertySchema(name: 'createdAt', type: IsarType.dateTime),
      IsarPropertySchema(name: 'attemptCount', type: IsarType.long),
      IsarPropertySchema(name: 'lastAttemptAt', type: IsarType.dateTime),
      IsarPropertySchema(name: 'nextRetryAt', type: IsarType.dateTime),
      IsarPropertySchema(name: 'outboxStatus', type: IsarType.string),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<int, OutboxOperation>(
    serialize: serializeOutboxOperation,
    deserialize: deserializeOutboxOperation,
    deserializeProperty: deserializeOutboxOperationProp,
  ),
  getEmbeddedSchemas: () => [],
);

@isarProtected
int serializeOutboxOperation(IsarWriter writer, OutboxOperation object) {
  IsarCore.writeString(writer, 1, object.entityType);
  IsarCore.writeString(writer, 2, object.clientId);
  IsarCore.writeString(writer, 3, object.operationType);
  IsarCore.writeString(writer, 4, object.payloadJson);
  IsarCore.writeLong(
    writer,
    5,
    object.createdAt.toUtc().microsecondsSinceEpoch,
  );
  IsarCore.writeLong(writer, 6, object.attemptCount);
  IsarCore.writeLong(
    writer,
    7,
    object.lastAttemptAt.toUtc().microsecondsSinceEpoch,
  );
  IsarCore.writeLong(
    writer,
    8,
    object.nextRetryAt.toUtc().microsecondsSinceEpoch,
  );
  IsarCore.writeString(writer, 9, object.outboxStatus);
  return object.id;
}

@isarProtected
OutboxOperation deserializeOutboxOperation(IsarReader reader) {
  final int _id;
  _id = IsarCore.readId(reader);
  final String _entityType;
  _entityType = IsarCore.readString(reader, 1) ?? '';
  final String _clientId;
  _clientId = IsarCore.readString(reader, 2) ?? '';
  final String _operationType;
  _operationType = IsarCore.readString(reader, 3) ?? '';
  final String _payloadJson;
  _payloadJson = IsarCore.readString(reader, 4) ?? '';
  final DateTime _createdAt;
  {
    final value = IsarCore.readLong(reader, 5);
    if (value == -9223372036854775808) {
      _createdAt = DateTime.fromMillisecondsSinceEpoch(
        0,
        isUtc: true,
      ).toLocal();
    } else {
      _createdAt = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  final int _attemptCount;
  _attemptCount = IsarCore.readLong(reader, 6);
  final DateTime _lastAttemptAt;
  {
    final value = IsarCore.readLong(reader, 7);
    if (value == -9223372036854775808) {
      _lastAttemptAt = DateTime.fromMillisecondsSinceEpoch(
        0,
        isUtc: true,
      ).toLocal();
    } else {
      _lastAttemptAt = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  final DateTime _nextRetryAt;
  {
    final value = IsarCore.readLong(reader, 8);
    if (value == -9223372036854775808) {
      _nextRetryAt = DateTime.fromMillisecondsSinceEpoch(
        0,
        isUtc: true,
      ).toLocal();
    } else {
      _nextRetryAt = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  final String _outboxStatus;
  _outboxStatus = IsarCore.readString(reader, 9) ?? '';
  final object = OutboxOperation(
    id: _id,
    entityType: _entityType,
    clientId: _clientId,
    operationType: _operationType,
    payloadJson: _payloadJson,
    createdAt: _createdAt,
    attemptCount: _attemptCount,
    lastAttemptAt: _lastAttemptAt,
    nextRetryAt: _nextRetryAt,
    outboxStatus: _outboxStatus,
  );
  return object;
}

@isarProtected
dynamic deserializeOutboxOperationProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readString(reader, 3) ?? '';
    case 4:
      return IsarCore.readString(reader, 4) ?? '';
    case 5:
      {
        final value = IsarCore.readLong(reader, 5);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 6:
      return IsarCore.readLong(reader, 6);
    case 7:
      {
        final value = IsarCore.readLong(reader, 7);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 8:
      {
        final value = IsarCore.readLong(reader, 8);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 9:
      return IsarCore.readString(reader, 9) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _OutboxOperationUpdate {
  bool call({
    required int id,
    String? entityType,
    String? clientId,
    String? operationType,
    String? payloadJson,
    DateTime? createdAt,
    int? attemptCount,
    DateTime? lastAttemptAt,
    DateTime? nextRetryAt,
    String? outboxStatus,
  });
}

class _OutboxOperationUpdateImpl implements _OutboxOperationUpdate {
  const _OutboxOperationUpdateImpl(this.collection);

  final IsarCollection<int, OutboxOperation> collection;

  @override
  bool call({
    required int id,
    Object? entityType = ignore,
    Object? clientId = ignore,
    Object? operationType = ignore,
    Object? payloadJson = ignore,
    Object? createdAt = ignore,
    Object? attemptCount = ignore,
    Object? lastAttemptAt = ignore,
    Object? nextRetryAt = ignore,
    Object? outboxStatus = ignore,
  }) {
    return collection.updateProperties(
          [id],
          {
            if (entityType != ignore) 1: entityType as String?,
            if (clientId != ignore) 2: clientId as String?,
            if (operationType != ignore) 3: operationType as String?,
            if (payloadJson != ignore) 4: payloadJson as String?,
            if (createdAt != ignore) 5: createdAt as DateTime?,
            if (attemptCount != ignore) 6: attemptCount as int?,
            if (lastAttemptAt != ignore) 7: lastAttemptAt as DateTime?,
            if (nextRetryAt != ignore) 8: nextRetryAt as DateTime?,
            if (outboxStatus != ignore) 9: outboxStatus as String?,
          },
        ) >
        0;
  }
}

sealed class _OutboxOperationUpdateAll {
  int call({
    required List<int> id,
    String? entityType,
    String? clientId,
    String? operationType,
    String? payloadJson,
    DateTime? createdAt,
    int? attemptCount,
    DateTime? lastAttemptAt,
    DateTime? nextRetryAt,
    String? outboxStatus,
  });
}

class _OutboxOperationUpdateAllImpl implements _OutboxOperationUpdateAll {
  const _OutboxOperationUpdateAllImpl(this.collection);

  final IsarCollection<int, OutboxOperation> collection;

  @override
  int call({
    required List<int> id,
    Object? entityType = ignore,
    Object? clientId = ignore,
    Object? operationType = ignore,
    Object? payloadJson = ignore,
    Object? createdAt = ignore,
    Object? attemptCount = ignore,
    Object? lastAttemptAt = ignore,
    Object? nextRetryAt = ignore,
    Object? outboxStatus = ignore,
  }) {
    return collection.updateProperties(id, {
      if (entityType != ignore) 1: entityType as String?,
      if (clientId != ignore) 2: clientId as String?,
      if (operationType != ignore) 3: operationType as String?,
      if (payloadJson != ignore) 4: payloadJson as String?,
      if (createdAt != ignore) 5: createdAt as DateTime?,
      if (attemptCount != ignore) 6: attemptCount as int?,
      if (lastAttemptAt != ignore) 7: lastAttemptAt as DateTime?,
      if (nextRetryAt != ignore) 8: nextRetryAt as DateTime?,
      if (outboxStatus != ignore) 9: outboxStatus as String?,
    });
  }
}

extension OutboxOperationUpdate on IsarCollection<int, OutboxOperation> {
  _OutboxOperationUpdate get update => _OutboxOperationUpdateImpl(this);

  _OutboxOperationUpdateAll get updateAll =>
      _OutboxOperationUpdateAllImpl(this);
}

sealed class _OutboxOperationQueryUpdate {
  int call({
    String? entityType,
    String? clientId,
    String? operationType,
    String? payloadJson,
    DateTime? createdAt,
    int? attemptCount,
    DateTime? lastAttemptAt,
    DateTime? nextRetryAt,
    String? outboxStatus,
  });
}

class _OutboxOperationQueryUpdateImpl implements _OutboxOperationQueryUpdate {
  const _OutboxOperationQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<OutboxOperation> query;
  final int? limit;

  @override
  int call({
    Object? entityType = ignore,
    Object? clientId = ignore,
    Object? operationType = ignore,
    Object? payloadJson = ignore,
    Object? createdAt = ignore,
    Object? attemptCount = ignore,
    Object? lastAttemptAt = ignore,
    Object? nextRetryAt = ignore,
    Object? outboxStatus = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (entityType != ignore) 1: entityType as String?,
      if (clientId != ignore) 2: clientId as String?,
      if (operationType != ignore) 3: operationType as String?,
      if (payloadJson != ignore) 4: payloadJson as String?,
      if (createdAt != ignore) 5: createdAt as DateTime?,
      if (attemptCount != ignore) 6: attemptCount as int?,
      if (lastAttemptAt != ignore) 7: lastAttemptAt as DateTime?,
      if (nextRetryAt != ignore) 8: nextRetryAt as DateTime?,
      if (outboxStatus != ignore) 9: outboxStatus as String?,
    });
  }
}

extension OutboxOperationQueryUpdate on IsarQuery<OutboxOperation> {
  _OutboxOperationQueryUpdate get updateFirst =>
      _OutboxOperationQueryUpdateImpl(this, limit: 1);

  _OutboxOperationQueryUpdate get updateAll =>
      _OutboxOperationQueryUpdateImpl(this);
}

class _OutboxOperationQueryBuilderUpdateImpl
    implements _OutboxOperationQueryUpdate {
  const _OutboxOperationQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<OutboxOperation, OutboxOperation, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? entityType = ignore,
    Object? clientId = ignore,
    Object? operationType = ignore,
    Object? payloadJson = ignore,
    Object? createdAt = ignore,
    Object? attemptCount = ignore,
    Object? lastAttemptAt = ignore,
    Object? nextRetryAt = ignore,
    Object? outboxStatus = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (entityType != ignore) 1: entityType as String?,
        if (clientId != ignore) 2: clientId as String?,
        if (operationType != ignore) 3: operationType as String?,
        if (payloadJson != ignore) 4: payloadJson as String?,
        if (createdAt != ignore) 5: createdAt as DateTime?,
        if (attemptCount != ignore) 6: attemptCount as int?,
        if (lastAttemptAt != ignore) 7: lastAttemptAt as DateTime?,
        if (nextRetryAt != ignore) 8: nextRetryAt as DateTime?,
        if (outboxStatus != ignore) 9: outboxStatus as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension OutboxOperationQueryBuilderUpdate
    on QueryBuilder<OutboxOperation, OutboxOperation, QOperations> {
  _OutboxOperationQueryUpdate get updateFirst =>
      _OutboxOperationQueryBuilderUpdateImpl(this, limit: 1);

  _OutboxOperationQueryUpdate get updateAll =>
      _OutboxOperationQueryBuilderUpdateImpl(this);
}

extension OutboxOperationQueryFilter
    on QueryBuilder<OutboxOperation, OutboxOperation, QFilterCondition> {
  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  idEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  idGreaterThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  idGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  idLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 0, value: value));
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  idLessThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  idBetween(int lower, int upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 0, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  entityTypeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  entityTypeGreaterThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  entityTypeGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  entityTypeLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  entityTypeLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  entityTypeBetween(String lower, String upper, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  entityTypeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  entityTypeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  entityTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  entityTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  entityTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  entityTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  clientIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  clientIdGreaterThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  clientIdGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  clientIdLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  clientIdLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  clientIdBetween(String lower, String upper, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  clientIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  clientIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  clientIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  clientIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  clientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  clientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  operationTypeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 3, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  operationTypeGreaterThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  operationTypeGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  operationTypeLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 3, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  operationTypeLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  operationTypeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  operationTypeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  operationTypeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  operationTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  operationTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 3,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  operationTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 3, value: ''),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  operationTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 3, value: ''),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  payloadJsonEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 4, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  payloadJsonGreaterThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  payloadJsonGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  payloadJsonLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 4, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  payloadJsonLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  payloadJsonBetween(String lower, String upper, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  payloadJsonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  payloadJsonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  payloadJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  payloadJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 4,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  payloadJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 4, value: ''),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  payloadJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 4, value: ''),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  createdAtGreaterThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  createdAtLessThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 5, value: value));
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  createdAtLessThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  createdAtBetween(DateTime lower, DateTime upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 5, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  attemptCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  attemptCountGreaterThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  attemptCountGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  attemptCountLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 6, value: value));
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  attemptCountLessThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  attemptCountBetween(int lower, int upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 6, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  lastAttemptAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 7, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  lastAttemptAtGreaterThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 7, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  lastAttemptAtGreaterThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 7, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  lastAttemptAtLessThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 7, value: value));
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  lastAttemptAtLessThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 7, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  lastAttemptAtBetween(DateTime lower, DateTime upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 7, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  nextRetryAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  nextRetryAtGreaterThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  nextRetryAtGreaterThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  nextRetryAtLessThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 8, value: value));
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  nextRetryAtLessThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  nextRetryAtBetween(DateTime lower, DateTime upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 8, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  outboxStatusEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 9, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  outboxStatusGreaterThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  outboxStatusGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  outboxStatusLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 9, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  outboxStatusLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  outboxStatusBetween(String lower, String upper, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 9,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  outboxStatusStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  outboxStatusEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  outboxStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  outboxStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 9,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  outboxStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 9, value: ''),
      );
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterFilterCondition>
  outboxStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 9, value: ''),
      );
    });
  }
}

extension OutboxOperationQueryObject
    on QueryBuilder<OutboxOperation, OutboxOperation, QFilterCondition> {}

extension OutboxOperationQuerySortBy
    on QueryBuilder<OutboxOperation, OutboxOperation, QSortBy> {
  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  sortByEntityType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  sortByEntityTypeDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy> sortByClientId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  sortByClientIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  sortByOperationType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  sortByOperationTypeDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  sortByPayloadJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  sortByPayloadJsonDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  sortByAttemptCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  sortByAttemptCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  sortByLastAttemptAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  sortByLastAttemptAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  sortByNextRetryAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  sortByNextRetryAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  sortByOutboxStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  sortByOutboxStatusDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension OutboxOperationQuerySortThenBy
    on QueryBuilder<OutboxOperation, OutboxOperation, QSortThenBy> {
  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  thenByEntityType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  thenByEntityTypeDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy> thenByClientId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  thenByClientIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  thenByOperationType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  thenByOperationTypeDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  thenByPayloadJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  thenByPayloadJsonDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  thenByAttemptCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  thenByAttemptCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  thenByLastAttemptAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  thenByLastAttemptAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  thenByNextRetryAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  thenByNextRetryAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  thenByOutboxStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterSortBy>
  thenByOutboxStatusDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension OutboxOperationQueryWhereDistinct
    on QueryBuilder<OutboxOperation, OutboxOperation, QDistinct> {
  QueryBuilder<OutboxOperation, OutboxOperation, QAfterDistinct>
  distinctByEntityType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterDistinct>
  distinctByClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterDistinct>
  distinctByOperationType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterDistinct>
  distinctByPayloadJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterDistinct>
  distinctByAttemptCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterDistinct>
  distinctByLastAttemptAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterDistinct>
  distinctByNextRetryAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8);
    });
  }

  QueryBuilder<OutboxOperation, OutboxOperation, QAfterDistinct>
  distinctByOutboxStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9, caseSensitive: caseSensitive);
    });
  }
}

extension OutboxOperationQueryProperty1
    on QueryBuilder<OutboxOperation, OutboxOperation, QProperty> {
  QueryBuilder<OutboxOperation, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<OutboxOperation, String, QAfterProperty> entityTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<OutboxOperation, String, QAfterProperty> clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<OutboxOperation, String, QAfterProperty>
  operationTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<OutboxOperation, String, QAfterProperty> payloadJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<OutboxOperation, DateTime, QAfterProperty> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<OutboxOperation, int, QAfterProperty> attemptCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<OutboxOperation, DateTime, QAfterProperty>
  lastAttemptAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<OutboxOperation, DateTime, QAfterProperty>
  nextRetryAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<OutboxOperation, String, QAfterProperty> outboxStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }
}

extension OutboxOperationQueryProperty2<R>
    on QueryBuilder<OutboxOperation, R, QAfterProperty> {
  QueryBuilder<OutboxOperation, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<OutboxOperation, (R, String), QAfterProperty>
  entityTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<OutboxOperation, (R, String), QAfterProperty>
  clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<OutboxOperation, (R, String), QAfterProperty>
  operationTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<OutboxOperation, (R, String), QAfterProperty>
  payloadJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<OutboxOperation, (R, DateTime), QAfterProperty>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<OutboxOperation, (R, int), QAfterProperty>
  attemptCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<OutboxOperation, (R, DateTime), QAfterProperty>
  lastAttemptAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<OutboxOperation, (R, DateTime), QAfterProperty>
  nextRetryAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<OutboxOperation, (R, String), QAfterProperty>
  outboxStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }
}

extension OutboxOperationQueryProperty3<R1, R2>
    on QueryBuilder<OutboxOperation, (R1, R2), QAfterProperty> {
  QueryBuilder<OutboxOperation, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<OutboxOperation, (R1, R2, String), QOperations>
  entityTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<OutboxOperation, (R1, R2, String), QOperations>
  clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<OutboxOperation, (R1, R2, String), QOperations>
  operationTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<OutboxOperation, (R1, R2, String), QOperations>
  payloadJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<OutboxOperation, (R1, R2, DateTime), QOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<OutboxOperation, (R1, R2, int), QOperations>
  attemptCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<OutboxOperation, (R1, R2, DateTime), QOperations>
  lastAttemptAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<OutboxOperation, (R1, R2, DateTime), QOperations>
  nextRetryAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<OutboxOperation, (R1, R2, String), QOperations>
  outboxStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }
}
