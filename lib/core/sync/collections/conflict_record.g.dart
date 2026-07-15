// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conflict_record.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetConflictRecordCollection on Isar {
  IsarCollection<int, ConflictRecord> get conflictRecords => this.collection();
}

final ConflictRecordSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'ConflictRecord',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(name: 'entityType', type: IsarType.string),
      IsarPropertySchema(name: 'clientId', type: IsarType.string),
      IsarPropertySchema(name: 'localPayloadJson', type: IsarType.string),
      IsarPropertySchema(name: 'serverPayloadJson', type: IsarType.string),
      IsarPropertySchema(name: 'conflictAt', type: IsarType.dateTime),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'clientId',
        properties: ["clientId"],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, ConflictRecord>(
    serialize: serializeConflictRecord,
    deserialize: deserializeConflictRecord,
    deserializeProperty: deserializeConflictRecordProp,
  ),
  getEmbeddedSchemas: () => [],
);

@isarProtected
int serializeConflictRecord(IsarWriter writer, ConflictRecord object) {
  IsarCore.writeString(writer, 1, object.entityType);
  IsarCore.writeString(writer, 2, object.clientId);
  IsarCore.writeString(writer, 3, object.localPayloadJson);
  IsarCore.writeString(writer, 4, object.serverPayloadJson);
  IsarCore.writeLong(
    writer,
    5,
    object.conflictAt.toUtc().microsecondsSinceEpoch,
  );
  return object.id;
}

@isarProtected
ConflictRecord deserializeConflictRecord(IsarReader reader) {
  final object = ConflictRecord();
  object.id = IsarCore.readId(reader);
  object.entityType = IsarCore.readString(reader, 1) ?? '';
  object.clientId = IsarCore.readString(reader, 2) ?? '';
  object.localPayloadJson = IsarCore.readString(reader, 3) ?? '';
  object.serverPayloadJson = IsarCore.readString(reader, 4) ?? '';
  {
    final value = IsarCore.readLong(reader, 5);
    if (value == -9223372036854775808) {
      object.conflictAt = DateTime.fromMillisecondsSinceEpoch(
        0,
        isUtc: true,
      ).toLocal();
    } else {
      object.conflictAt = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  return object;
}

@isarProtected
dynamic deserializeConflictRecordProp(IsarReader reader, int property) {
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
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _ConflictRecordUpdate {
  bool call({
    required int id,
    String? entityType,
    String? clientId,
    String? localPayloadJson,
    String? serverPayloadJson,
    DateTime? conflictAt,
  });
}

class _ConflictRecordUpdateImpl implements _ConflictRecordUpdate {
  const _ConflictRecordUpdateImpl(this.collection);

  final IsarCollection<int, ConflictRecord> collection;

  @override
  bool call({
    required int id,
    Object? entityType = ignore,
    Object? clientId = ignore,
    Object? localPayloadJson = ignore,
    Object? serverPayloadJson = ignore,
    Object? conflictAt = ignore,
  }) {
    return collection.updateProperties(
          [id],
          {
            if (entityType != ignore) 1: entityType as String?,
            if (clientId != ignore) 2: clientId as String?,
            if (localPayloadJson != ignore) 3: localPayloadJson as String?,
            if (serverPayloadJson != ignore) 4: serverPayloadJson as String?,
            if (conflictAt != ignore) 5: conflictAt as DateTime?,
          },
        ) >
        0;
  }
}

sealed class _ConflictRecordUpdateAll {
  int call({
    required List<int> id,
    String? entityType,
    String? clientId,
    String? localPayloadJson,
    String? serverPayloadJson,
    DateTime? conflictAt,
  });
}

class _ConflictRecordUpdateAllImpl implements _ConflictRecordUpdateAll {
  const _ConflictRecordUpdateAllImpl(this.collection);

  final IsarCollection<int, ConflictRecord> collection;

  @override
  int call({
    required List<int> id,
    Object? entityType = ignore,
    Object? clientId = ignore,
    Object? localPayloadJson = ignore,
    Object? serverPayloadJson = ignore,
    Object? conflictAt = ignore,
  }) {
    return collection.updateProperties(id, {
      if (entityType != ignore) 1: entityType as String?,
      if (clientId != ignore) 2: clientId as String?,
      if (localPayloadJson != ignore) 3: localPayloadJson as String?,
      if (serverPayloadJson != ignore) 4: serverPayloadJson as String?,
      if (conflictAt != ignore) 5: conflictAt as DateTime?,
    });
  }
}

extension ConflictRecordUpdate on IsarCollection<int, ConflictRecord> {
  _ConflictRecordUpdate get update => _ConflictRecordUpdateImpl(this);

  _ConflictRecordUpdateAll get updateAll => _ConflictRecordUpdateAllImpl(this);
}

sealed class _ConflictRecordQueryUpdate {
  int call({
    String? entityType,
    String? clientId,
    String? localPayloadJson,
    String? serverPayloadJson,
    DateTime? conflictAt,
  });
}

class _ConflictRecordQueryUpdateImpl implements _ConflictRecordQueryUpdate {
  const _ConflictRecordQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<ConflictRecord> query;
  final int? limit;

  @override
  int call({
    Object? entityType = ignore,
    Object? clientId = ignore,
    Object? localPayloadJson = ignore,
    Object? serverPayloadJson = ignore,
    Object? conflictAt = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (entityType != ignore) 1: entityType as String?,
      if (clientId != ignore) 2: clientId as String?,
      if (localPayloadJson != ignore) 3: localPayloadJson as String?,
      if (serverPayloadJson != ignore) 4: serverPayloadJson as String?,
      if (conflictAt != ignore) 5: conflictAt as DateTime?,
    });
  }
}

extension ConflictRecordQueryUpdate on IsarQuery<ConflictRecord> {
  _ConflictRecordQueryUpdate get updateFirst =>
      _ConflictRecordQueryUpdateImpl(this, limit: 1);

  _ConflictRecordQueryUpdate get updateAll =>
      _ConflictRecordQueryUpdateImpl(this);
}

class _ConflictRecordQueryBuilderUpdateImpl
    implements _ConflictRecordQueryUpdate {
  const _ConflictRecordQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<ConflictRecord, ConflictRecord, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? entityType = ignore,
    Object? clientId = ignore,
    Object? localPayloadJson = ignore,
    Object? serverPayloadJson = ignore,
    Object? conflictAt = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (entityType != ignore) 1: entityType as String?,
        if (clientId != ignore) 2: clientId as String?,
        if (localPayloadJson != ignore) 3: localPayloadJson as String?,
        if (serverPayloadJson != ignore) 4: serverPayloadJson as String?,
        if (conflictAt != ignore) 5: conflictAt as DateTime?,
      });
    } finally {
      q.close();
    }
  }
}

extension ConflictRecordQueryBuilderUpdate
    on QueryBuilder<ConflictRecord, ConflictRecord, QOperations> {
  _ConflictRecordQueryUpdate get updateFirst =>
      _ConflictRecordQueryBuilderUpdateImpl(this, limit: 1);

  _ConflictRecordQueryUpdate get updateAll =>
      _ConflictRecordQueryBuilderUpdateImpl(this);
}

extension ConflictRecordQueryFilter
    on QueryBuilder<ConflictRecord, ConflictRecord, QFilterCondition> {
  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition> idEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  idGreaterThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  idGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  idLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 0, value: value));
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  idLessThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition> idBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 0, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  entityTypeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  entityTypeLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  entityTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  entityTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  clientIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  clientIdLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  clientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  clientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  localPayloadJsonEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 3, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  localPayloadJsonGreaterThan(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  localPayloadJsonGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  localPayloadJsonLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 3, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  localPayloadJsonLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  localPayloadJsonBetween(
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  localPayloadJsonStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  localPayloadJsonEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  localPayloadJsonContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  localPayloadJsonMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  localPayloadJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 3, value: ''),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  localPayloadJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 3, value: ''),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  serverPayloadJsonEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 4, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  serverPayloadJsonGreaterThan(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  serverPayloadJsonGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  serverPayloadJsonLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 4, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  serverPayloadJsonLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  serverPayloadJsonBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  serverPayloadJsonStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  serverPayloadJsonEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  serverPayloadJsonContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  serverPayloadJsonMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  serverPayloadJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 4, value: ''),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  serverPayloadJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 4, value: ''),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  conflictAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  conflictAtGreaterThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  conflictAtGreaterThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  conflictAtLessThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 5, value: value));
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  conflictAtLessThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterFilterCondition>
  conflictAtBetween(DateTime lower, DateTime upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 5, lower: lower, upper: upper),
      );
    });
  }
}

extension ConflictRecordQueryObject
    on QueryBuilder<ConflictRecord, ConflictRecord, QFilterCondition> {}

extension ConflictRecordQuerySortBy
    on QueryBuilder<ConflictRecord, ConflictRecord, QSortBy> {
  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy> sortByEntityType({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy>
  sortByEntityTypeDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy> sortByClientId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy>
  sortByClientIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy>
  sortByLocalPayloadJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy>
  sortByLocalPayloadJsonDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy>
  sortByServerPayloadJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy>
  sortByServerPayloadJsonDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy>
  sortByConflictAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy>
  sortByConflictAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }
}

extension ConflictRecordQuerySortThenBy
    on QueryBuilder<ConflictRecord, ConflictRecord, QSortThenBy> {
  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy> thenByEntityType({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy>
  thenByEntityTypeDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy> thenByClientId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy>
  thenByClientIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy>
  thenByLocalPayloadJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy>
  thenByLocalPayloadJsonDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy>
  thenByServerPayloadJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy>
  thenByServerPayloadJsonDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy>
  thenByConflictAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterSortBy>
  thenByConflictAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }
}

extension ConflictRecordQueryWhereDistinct
    on QueryBuilder<ConflictRecord, ConflictRecord, QDistinct> {
  QueryBuilder<ConflictRecord, ConflictRecord, QAfterDistinct>
  distinctByEntityType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterDistinct>
  distinctByClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterDistinct>
  distinctByLocalPayloadJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterDistinct>
  distinctByServerPayloadJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConflictRecord, ConflictRecord, QAfterDistinct>
  distinctByConflictAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }
}

extension ConflictRecordQueryProperty1
    on QueryBuilder<ConflictRecord, ConflictRecord, QProperty> {
  QueryBuilder<ConflictRecord, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ConflictRecord, String, QAfterProperty> entityTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ConflictRecord, String, QAfterProperty> clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ConflictRecord, String, QAfterProperty>
  localPayloadJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ConflictRecord, String, QAfterProperty>
  serverPayloadJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ConflictRecord, DateTime, QAfterProperty> conflictAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}

extension ConflictRecordQueryProperty2<R>
    on QueryBuilder<ConflictRecord, R, QAfterProperty> {
  QueryBuilder<ConflictRecord, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ConflictRecord, (R, String), QAfterProperty>
  entityTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ConflictRecord, (R, String), QAfterProperty> clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ConflictRecord, (R, String), QAfterProperty>
  localPayloadJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ConflictRecord, (R, String), QAfterProperty>
  serverPayloadJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ConflictRecord, (R, DateTime), QAfterProperty>
  conflictAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}

extension ConflictRecordQueryProperty3<R1, R2>
    on QueryBuilder<ConflictRecord, (R1, R2), QAfterProperty> {
  QueryBuilder<ConflictRecord, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ConflictRecord, (R1, R2, String), QOperations>
  entityTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ConflictRecord, (R1, R2, String), QOperations>
  clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ConflictRecord, (R1, R2, String), QOperations>
  localPayloadJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ConflictRecord, (R1, R2, String), QOperations>
  serverPayloadJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ConflictRecord, (R1, R2, DateTime), QOperations>
  conflictAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}
