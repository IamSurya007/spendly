// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_collection.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetBudgetCollectionCollection on Isar {
  IsarCollection<int, BudgetCollection> get budgetCollections =>
      this.collection();
}

final BudgetCollectionSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'BudgetCollection',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(name: 'month', type: IsarType.string),
      IsarPropertySchema(name: 'category', type: IsarType.string),
      IsarPropertySchema(name: 'amountLimit', type: IsarType.double),
      IsarPropertySchema(name: 'serverId', type: IsarType.string),
      IsarPropertySchema(name: 'clientId', type: IsarType.string),
      IsarPropertySchema(name: 'updatedAt', type: IsarType.dateTime),
      IsarPropertySchema(name: 'serverUpdatedAt', type: IsarType.dateTime),
      IsarPropertySchema(name: 'syncStatus', type: IsarType.string),
      IsarPropertySchema(name: 'isDeleted', type: IsarType.bool),
      IsarPropertySchema(name: 'version', type: IsarType.long),
      IsarPropertySchema(name: 'dirty', type: IsarType.bool),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<int, BudgetCollection>(
    serialize: serializeBudgetCollection,
    deserialize: deserializeBudgetCollection,
    deserializeProperty: deserializeBudgetCollectionProp,
  ),
  getEmbeddedSchemas: () => [],
);

@isarProtected
int serializeBudgetCollection(IsarWriter writer, BudgetCollection object) {
  IsarCore.writeString(writer, 1, object.month);
  IsarCore.writeString(writer, 2, object.category);
  IsarCore.writeDouble(writer, 3, object.amountLimit);
  {
    final value = object.serverId;
    if (value == null) {
      IsarCore.writeNull(writer, 4);
    } else {
      IsarCore.writeString(writer, 4, value);
    }
  }
  IsarCore.writeString(writer, 5, object.clientId);
  IsarCore.writeLong(
    writer,
    6,
    object.updatedAt.toUtc().microsecondsSinceEpoch,
  );
  IsarCore.writeLong(
    writer,
    7,
    object.serverUpdatedAt?.toUtc().microsecondsSinceEpoch ??
        -9223372036854775808,
  );
  IsarCore.writeString(writer, 8, object.syncStatus);
  IsarCore.writeBool(writer, 9, value: object.isDeleted);
  IsarCore.writeLong(writer, 10, object.version);
  IsarCore.writeBool(writer, 11, value: object.dirty);
  return object.id;
}

@isarProtected
BudgetCollection deserializeBudgetCollection(IsarReader reader) {
  final object = BudgetCollection();
  object.id = IsarCore.readId(reader);
  object.month = IsarCore.readString(reader, 1) ?? '';
  object.category = IsarCore.readString(reader, 2) ?? '';
  object.amountLimit = IsarCore.readDouble(reader, 3);
  object.serverId = IsarCore.readString(reader, 4);
  object.clientId = IsarCore.readString(reader, 5) ?? '';
  {
    final value = IsarCore.readLong(reader, 6);
    if (value == -9223372036854775808) {
      object.updatedAt = DateTime.fromMillisecondsSinceEpoch(
        0,
        isUtc: true,
      ).toLocal();
    } else {
      object.updatedAt = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  {
    final value = IsarCore.readLong(reader, 7);
    if (value == -9223372036854775808) {
      object.serverUpdatedAt = null;
    } else {
      object.serverUpdatedAt = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  object.syncStatus = IsarCore.readString(reader, 8) ?? '';
  object.isDeleted = IsarCore.readBool(reader, 9);
  object.version = IsarCore.readLong(reader, 10);
  object.dirty = IsarCore.readBool(reader, 11);
  return object;
}

@isarProtected
dynamic deserializeBudgetCollectionProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readDouble(reader, 3);
    case 4:
      return IsarCore.readString(reader, 4);
    case 5:
      return IsarCore.readString(reader, 5) ?? '';
    case 6:
      {
        final value = IsarCore.readLong(reader, 6);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 7:
      {
        final value = IsarCore.readLong(reader, 7);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 8:
      return IsarCore.readString(reader, 8) ?? '';
    case 9:
      return IsarCore.readBool(reader, 9);
    case 10:
      return IsarCore.readLong(reader, 10);
    case 11:
      return IsarCore.readBool(reader, 11);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _BudgetCollectionUpdate {
  bool call({
    required int id,
    String? month,
    String? category,
    double? amountLimit,
    String? serverId,
    String? clientId,
    DateTime? updatedAt,
    DateTime? serverUpdatedAt,
    String? syncStatus,
    bool? isDeleted,
    int? version,
    bool? dirty,
  });
}

class _BudgetCollectionUpdateImpl implements _BudgetCollectionUpdate {
  const _BudgetCollectionUpdateImpl(this.collection);

  final IsarCollection<int, BudgetCollection> collection;

  @override
  bool call({
    required int id,
    Object? month = ignore,
    Object? category = ignore,
    Object? amountLimit = ignore,
    Object? serverId = ignore,
    Object? clientId = ignore,
    Object? updatedAt = ignore,
    Object? serverUpdatedAt = ignore,
    Object? syncStatus = ignore,
    Object? isDeleted = ignore,
    Object? version = ignore,
    Object? dirty = ignore,
  }) {
    return collection.updateProperties(
          [id],
          {
            if (month != ignore) 1: month as String?,
            if (category != ignore) 2: category as String?,
            if (amountLimit != ignore) 3: amountLimit as double?,
            if (serverId != ignore) 4: serverId as String?,
            if (clientId != ignore) 5: clientId as String?,
            if (updatedAt != ignore) 6: updatedAt as DateTime?,
            if (serverUpdatedAt != ignore) 7: serverUpdatedAt as DateTime?,
            if (syncStatus != ignore) 8: syncStatus as String?,
            if (isDeleted != ignore) 9: isDeleted as bool?,
            if (version != ignore) 10: version as int?,
            if (dirty != ignore) 11: dirty as bool?,
          },
        ) >
        0;
  }
}

sealed class _BudgetCollectionUpdateAll {
  int call({
    required List<int> id,
    String? month,
    String? category,
    double? amountLimit,
    String? serverId,
    String? clientId,
    DateTime? updatedAt,
    DateTime? serverUpdatedAt,
    String? syncStatus,
    bool? isDeleted,
    int? version,
    bool? dirty,
  });
}

class _BudgetCollectionUpdateAllImpl implements _BudgetCollectionUpdateAll {
  const _BudgetCollectionUpdateAllImpl(this.collection);

  final IsarCollection<int, BudgetCollection> collection;

  @override
  int call({
    required List<int> id,
    Object? month = ignore,
    Object? category = ignore,
    Object? amountLimit = ignore,
    Object? serverId = ignore,
    Object? clientId = ignore,
    Object? updatedAt = ignore,
    Object? serverUpdatedAt = ignore,
    Object? syncStatus = ignore,
    Object? isDeleted = ignore,
    Object? version = ignore,
    Object? dirty = ignore,
  }) {
    return collection.updateProperties(id, {
      if (month != ignore) 1: month as String?,
      if (category != ignore) 2: category as String?,
      if (amountLimit != ignore) 3: amountLimit as double?,
      if (serverId != ignore) 4: serverId as String?,
      if (clientId != ignore) 5: clientId as String?,
      if (updatedAt != ignore) 6: updatedAt as DateTime?,
      if (serverUpdatedAt != ignore) 7: serverUpdatedAt as DateTime?,
      if (syncStatus != ignore) 8: syncStatus as String?,
      if (isDeleted != ignore) 9: isDeleted as bool?,
      if (version != ignore) 10: version as int?,
      if (dirty != ignore) 11: dirty as bool?,
    });
  }
}

extension BudgetCollectionUpdate on IsarCollection<int, BudgetCollection> {
  _BudgetCollectionUpdate get update => _BudgetCollectionUpdateImpl(this);

  _BudgetCollectionUpdateAll get updateAll =>
      _BudgetCollectionUpdateAllImpl(this);
}

sealed class _BudgetCollectionQueryUpdate {
  int call({
    String? month,
    String? category,
    double? amountLimit,
    String? serverId,
    String? clientId,
    DateTime? updatedAt,
    DateTime? serverUpdatedAt,
    String? syncStatus,
    bool? isDeleted,
    int? version,
    bool? dirty,
  });
}

class _BudgetCollectionQueryUpdateImpl implements _BudgetCollectionQueryUpdate {
  const _BudgetCollectionQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<BudgetCollection> query;
  final int? limit;

  @override
  int call({
    Object? month = ignore,
    Object? category = ignore,
    Object? amountLimit = ignore,
    Object? serverId = ignore,
    Object? clientId = ignore,
    Object? updatedAt = ignore,
    Object? serverUpdatedAt = ignore,
    Object? syncStatus = ignore,
    Object? isDeleted = ignore,
    Object? version = ignore,
    Object? dirty = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (month != ignore) 1: month as String?,
      if (category != ignore) 2: category as String?,
      if (amountLimit != ignore) 3: amountLimit as double?,
      if (serverId != ignore) 4: serverId as String?,
      if (clientId != ignore) 5: clientId as String?,
      if (updatedAt != ignore) 6: updatedAt as DateTime?,
      if (serverUpdatedAt != ignore) 7: serverUpdatedAt as DateTime?,
      if (syncStatus != ignore) 8: syncStatus as String?,
      if (isDeleted != ignore) 9: isDeleted as bool?,
      if (version != ignore) 10: version as int?,
      if (dirty != ignore) 11: dirty as bool?,
    });
  }
}

extension BudgetCollectionQueryUpdate on IsarQuery<BudgetCollection> {
  _BudgetCollectionQueryUpdate get updateFirst =>
      _BudgetCollectionQueryUpdateImpl(this, limit: 1);

  _BudgetCollectionQueryUpdate get updateAll =>
      _BudgetCollectionQueryUpdateImpl(this);
}

class _BudgetCollectionQueryBuilderUpdateImpl
    implements _BudgetCollectionQueryUpdate {
  const _BudgetCollectionQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<BudgetCollection, BudgetCollection, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? month = ignore,
    Object? category = ignore,
    Object? amountLimit = ignore,
    Object? serverId = ignore,
    Object? clientId = ignore,
    Object? updatedAt = ignore,
    Object? serverUpdatedAt = ignore,
    Object? syncStatus = ignore,
    Object? isDeleted = ignore,
    Object? version = ignore,
    Object? dirty = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (month != ignore) 1: month as String?,
        if (category != ignore) 2: category as String?,
        if (amountLimit != ignore) 3: amountLimit as double?,
        if (serverId != ignore) 4: serverId as String?,
        if (clientId != ignore) 5: clientId as String?,
        if (updatedAt != ignore) 6: updatedAt as DateTime?,
        if (serverUpdatedAt != ignore) 7: serverUpdatedAt as DateTime?,
        if (syncStatus != ignore) 8: syncStatus as String?,
        if (isDeleted != ignore) 9: isDeleted as bool?,
        if (version != ignore) 10: version as int?,
        if (dirty != ignore) 11: dirty as bool?,
      });
    } finally {
      q.close();
    }
  }
}

extension BudgetCollectionQueryBuilderUpdate
    on QueryBuilder<BudgetCollection, BudgetCollection, QOperations> {
  _BudgetCollectionQueryUpdate get updateFirst =>
      _BudgetCollectionQueryBuilderUpdateImpl(this, limit: 1);

  _BudgetCollectionQueryUpdate get updateAll =>
      _BudgetCollectionQueryBuilderUpdateImpl(this);
}

extension BudgetCollectionQueryFilter
    on QueryBuilder<BudgetCollection, BudgetCollection, QFilterCondition> {
  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  idEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  idGreaterThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  idGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  idLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 0, value: value));
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  idLessThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  idBetween(int lower, int upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 0, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  monthEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  monthGreaterThan(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  monthGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  monthLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  monthLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  monthBetween(String lower, String upper, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  monthStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  monthEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  monthContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  monthMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  monthIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  monthIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  categoryEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  categoryGreaterThan(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  categoryGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  categoryLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  categoryLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  categoryBetween(String lower, String upper, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  categoryStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  categoryEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  categoryContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  categoryMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  amountLimitEqualTo(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 3, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  amountLimitGreaterThan(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 3, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  amountLimitGreaterThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 3, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  amountLimitLessThan(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 3, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  amountLimitLessThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 3, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  amountLimitBetween(
    double lower,
    double upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverIdIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 4, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverIdGreaterThan(String? value, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverIdGreaterThanOrEqualTo(String? value, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverIdLessThan(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 4, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverIdLessThanOrEqualTo(String? value, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverIdBetween(String? lower, String? upper, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverIdStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverIdEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 4, value: ''),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 4, value: ''),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  clientIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 5, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  clientIdGreaterThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  clientIdGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  clientIdLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 5, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  clientIdLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  clientIdBetween(String lower, String upper, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 5,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  clientIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  clientIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  clientIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  clientIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 5,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  clientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 5, value: ''),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  clientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 5, value: ''),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  updatedAtGreaterThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  updatedAtGreaterThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  updatedAtLessThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 6, value: value));
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  updatedAtLessThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  updatedAtBetween(DateTime lower, DateTime upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 6, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverUpdatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverUpdatedAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverUpdatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 7, value: value),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverUpdatedAtGreaterThan(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 7, value: value),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverUpdatedAtGreaterThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 7, value: value),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverUpdatedAtLessThan(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 7, value: value));
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverUpdatedAtLessThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 7, value: value),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  serverUpdatedAtBetween(DateTime? lower, DateTime? upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 7, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  syncStatusEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 8, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  syncStatusGreaterThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  syncStatusGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  syncStatusLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 8, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  syncStatusLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  syncStatusBetween(String lower, String upper, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 8,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  syncStatusStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  syncStatusEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  syncStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  syncStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 8,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  syncStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 8, value: ''),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  syncStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 8, value: ''),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  isDeletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 9, value: value),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  versionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 10, value: value),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  versionGreaterThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 10, value: value),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  versionGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 10, value: value),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  versionLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 10, value: value),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  versionLessThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 10, value: value),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  versionBetween(int lower, int upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 10, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterFilterCondition>
  dirtyEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 11, value: value),
      );
    });
  }
}

extension BudgetCollectionQueryObject
    on QueryBuilder<BudgetCollection, BudgetCollection, QFilterCondition> {}

extension BudgetCollectionQuerySortBy
    on QueryBuilder<BudgetCollection, BudgetCollection, QSortBy> {
  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy> sortByMonth({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortByMonthDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortByCategoryDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortByAmountLimit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortByAmountLimitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortByServerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortByServerIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortByClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortByClientIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortByServerUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortByServerUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortBySyncStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortBySyncStatusDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy> sortByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  sortByDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc);
    });
  }
}

extension BudgetCollectionQuerySortThenBy
    on QueryBuilder<BudgetCollection, BudgetCollection, QSortThenBy> {
  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy> thenByMonth({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenByMonthDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenByCategoryDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenByAmountLimit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenByAmountLimitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenByServerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenByServerIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenByClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenByClientIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenByServerUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenByServerUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenBySyncStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenBySyncStatusDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy> thenByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterSortBy>
  thenByDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc);
    });
  }
}

extension BudgetCollectionQueryWhereDistinct
    on QueryBuilder<BudgetCollection, BudgetCollection, QDistinct> {
  QueryBuilder<BudgetCollection, BudgetCollection, QAfterDistinct>
  distinctByMonth({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterDistinct>
  distinctByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterDistinct>
  distinctByAmountLimit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterDistinct>
  distinctByServerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterDistinct>
  distinctByClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterDistinct>
  distinctByServerUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterDistinct>
  distinctBySyncStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterDistinct>
  distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterDistinct>
  distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10);
    });
  }

  QueryBuilder<BudgetCollection, BudgetCollection, QAfterDistinct>
  distinctByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11);
    });
  }
}

extension BudgetCollectionQueryProperty1
    on QueryBuilder<BudgetCollection, BudgetCollection, QProperty> {
  QueryBuilder<BudgetCollection, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<BudgetCollection, String, QAfterProperty> monthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<BudgetCollection, String, QAfterProperty> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<BudgetCollection, double, QAfterProperty> amountLimitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<BudgetCollection, String?, QAfterProperty> serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<BudgetCollection, String, QAfterProperty> clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<BudgetCollection, DateTime, QAfterProperty> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<BudgetCollection, DateTime?, QAfterProperty>
  serverUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<BudgetCollection, String, QAfterProperty> syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<BudgetCollection, bool, QAfterProperty> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<BudgetCollection, int, QAfterProperty> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<BudgetCollection, bool, QAfterProperty> dirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }
}

extension BudgetCollectionQueryProperty2<R>
    on QueryBuilder<BudgetCollection, R, QAfterProperty> {
  QueryBuilder<BudgetCollection, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<BudgetCollection, (R, String), QAfterProperty> monthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<BudgetCollection, (R, String), QAfterProperty>
  categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<BudgetCollection, (R, double), QAfterProperty>
  amountLimitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<BudgetCollection, (R, String?), QAfterProperty>
  serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<BudgetCollection, (R, String), QAfterProperty>
  clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<BudgetCollection, (R, DateTime), QAfterProperty>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<BudgetCollection, (R, DateTime?), QAfterProperty>
  serverUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<BudgetCollection, (R, String), QAfterProperty>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<BudgetCollection, (R, bool), QAfterProperty>
  isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<BudgetCollection, (R, int), QAfterProperty> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<BudgetCollection, (R, bool), QAfterProperty> dirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }
}

extension BudgetCollectionQueryProperty3<R1, R2>
    on QueryBuilder<BudgetCollection, (R1, R2), QAfterProperty> {
  QueryBuilder<BudgetCollection, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<BudgetCollection, (R1, R2, String), QOperations>
  monthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<BudgetCollection, (R1, R2, String), QOperations>
  categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<BudgetCollection, (R1, R2, double), QOperations>
  amountLimitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<BudgetCollection, (R1, R2, String?), QOperations>
  serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<BudgetCollection, (R1, R2, String), QOperations>
  clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<BudgetCollection, (R1, R2, DateTime), QOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<BudgetCollection, (R1, R2, DateTime?), QOperations>
  serverUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<BudgetCollection, (R1, R2, String), QOperations>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<BudgetCollection, (R1, R2, bool), QOperations>
  isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<BudgetCollection, (R1, R2, int), QOperations> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<BudgetCollection, (R1, R2, bool), QOperations> dirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }
}
