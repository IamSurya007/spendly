// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_collection.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetExpenseCollectionCollection on Isar {
  IsarCollection<int, ExpenseCollection> get expenseCollections =>
      this.collection();
}

final ExpenseCollectionSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'ExpenseCollection',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(name: 'amount', type: IsarType.double),
      IsarPropertySchema(name: 'category', type: IsarType.string),
      IsarPropertySchema(name: 'note', type: IsarType.string),
      IsarPropertySchema(name: 'date', type: IsarType.dateTime),
      IsarPropertySchema(name: 'method', type: IsarType.string),
      IsarPropertySchema(name: 'source', type: IsarType.string),
      IsarPropertySchema(name: 'merchant', type: IsarType.string),
      IsarPropertySchema(name: 'createdAt', type: IsarType.dateTime),
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
  converter: IsarObjectConverter<int, ExpenseCollection>(
    serialize: serializeExpenseCollection,
    deserialize: deserializeExpenseCollection,
    deserializeProperty: deserializeExpenseCollectionProp,
  ),
  getEmbeddedSchemas: () => [],
);

@isarProtected
int serializeExpenseCollection(IsarWriter writer, ExpenseCollection object) {
  IsarCore.writeDouble(writer, 1, object.amount);
  IsarCore.writeString(writer, 2, object.category);
  IsarCore.writeString(writer, 3, object.note);
  IsarCore.writeLong(writer, 4, object.date.toUtc().microsecondsSinceEpoch);
  IsarCore.writeString(writer, 5, object.method);
  IsarCore.writeString(writer, 6, object.source);
  IsarCore.writeString(writer, 7, object.merchant);
  IsarCore.writeLong(
    writer,
    8,
    object.createdAt.toUtc().microsecondsSinceEpoch,
  );
  {
    final value = object.serverId;
    if (value == null) {
      IsarCore.writeNull(writer, 9);
    } else {
      IsarCore.writeString(writer, 9, value);
    }
  }
  IsarCore.writeString(writer, 10, object.clientId);
  IsarCore.writeLong(
    writer,
    11,
    object.updatedAt.toUtc().microsecondsSinceEpoch,
  );
  IsarCore.writeLong(
    writer,
    12,
    object.serverUpdatedAt?.toUtc().microsecondsSinceEpoch ??
        -9223372036854775808,
  );
  IsarCore.writeString(writer, 13, object.syncStatus);
  IsarCore.writeBool(writer, 14, value: object.isDeleted);
  IsarCore.writeLong(writer, 15, object.version);
  IsarCore.writeBool(writer, 16, value: object.dirty);
  return object.id;
}

@isarProtected
ExpenseCollection deserializeExpenseCollection(IsarReader reader) {
  final object = ExpenseCollection();
  object.id = IsarCore.readId(reader);
  object.amount = IsarCore.readDouble(reader, 1);
  object.category = IsarCore.readString(reader, 2) ?? '';
  object.note = IsarCore.readString(reader, 3) ?? '';
  {
    final value = IsarCore.readLong(reader, 4);
    if (value == -9223372036854775808) {
      object.date = DateTime.fromMillisecondsSinceEpoch(
        0,
        isUtc: true,
      ).toLocal();
    } else {
      object.date = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  object.method = IsarCore.readString(reader, 5) ?? '';
  object.source = IsarCore.readString(reader, 6) ?? '';
  object.merchant = IsarCore.readString(reader, 7) ?? '';
  {
    final value = IsarCore.readLong(reader, 8);
    if (value == -9223372036854775808) {
      object.createdAt = DateTime.fromMillisecondsSinceEpoch(
        0,
        isUtc: true,
      ).toLocal();
    } else {
      object.createdAt = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  object.serverId = IsarCore.readString(reader, 9);
  object.clientId = IsarCore.readString(reader, 10) ?? '';
  {
    final value = IsarCore.readLong(reader, 11);
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
    final value = IsarCore.readLong(reader, 12);
    if (value == -9223372036854775808) {
      object.serverUpdatedAt = null;
    } else {
      object.serverUpdatedAt = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  object.syncStatus = IsarCore.readString(reader, 13) ?? '';
  object.isDeleted = IsarCore.readBool(reader, 14);
  object.version = IsarCore.readLong(reader, 15);
  object.dirty = IsarCore.readBool(reader, 16);
  return object;
}

@isarProtected
dynamic deserializeExpenseCollectionProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readDouble(reader, 1);
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readString(reader, 3) ?? '';
    case 4:
      {
        final value = IsarCore.readLong(reader, 4);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 5:
      return IsarCore.readString(reader, 5) ?? '';
    case 6:
      return IsarCore.readString(reader, 6) ?? '';
    case 7:
      return IsarCore.readString(reader, 7) ?? '';
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
      return IsarCore.readString(reader, 9);
    case 10:
      return IsarCore.readString(reader, 10) ?? '';
    case 11:
      {
        final value = IsarCore.readLong(reader, 11);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 12:
      {
        final value = IsarCore.readLong(reader, 12);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 13:
      return IsarCore.readString(reader, 13) ?? '';
    case 14:
      return IsarCore.readBool(reader, 14);
    case 15:
      return IsarCore.readLong(reader, 15);
    case 16:
      return IsarCore.readBool(reader, 16);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _ExpenseCollectionUpdate {
  bool call({
    required int id,
    double? amount,
    String? category,
    String? note,
    DateTime? date,
    String? method,
    String? source,
    String? merchant,
    DateTime? createdAt,
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

class _ExpenseCollectionUpdateImpl implements _ExpenseCollectionUpdate {
  const _ExpenseCollectionUpdateImpl(this.collection);

  final IsarCollection<int, ExpenseCollection> collection;

  @override
  bool call({
    required int id,
    Object? amount = ignore,
    Object? category = ignore,
    Object? note = ignore,
    Object? date = ignore,
    Object? method = ignore,
    Object? source = ignore,
    Object? merchant = ignore,
    Object? createdAt = ignore,
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
            if (amount != ignore) 1: amount as double?,
            if (category != ignore) 2: category as String?,
            if (note != ignore) 3: note as String?,
            if (date != ignore) 4: date as DateTime?,
            if (method != ignore) 5: method as String?,
            if (source != ignore) 6: source as String?,
            if (merchant != ignore) 7: merchant as String?,
            if (createdAt != ignore) 8: createdAt as DateTime?,
            if (serverId != ignore) 9: serverId as String?,
            if (clientId != ignore) 10: clientId as String?,
            if (updatedAt != ignore) 11: updatedAt as DateTime?,
            if (serverUpdatedAt != ignore) 12: serverUpdatedAt as DateTime?,
            if (syncStatus != ignore) 13: syncStatus as String?,
            if (isDeleted != ignore) 14: isDeleted as bool?,
            if (version != ignore) 15: version as int?,
            if (dirty != ignore) 16: dirty as bool?,
          },
        ) >
        0;
  }
}

sealed class _ExpenseCollectionUpdateAll {
  int call({
    required List<int> id,
    double? amount,
    String? category,
    String? note,
    DateTime? date,
    String? method,
    String? source,
    String? merchant,
    DateTime? createdAt,
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

class _ExpenseCollectionUpdateAllImpl implements _ExpenseCollectionUpdateAll {
  const _ExpenseCollectionUpdateAllImpl(this.collection);

  final IsarCollection<int, ExpenseCollection> collection;

  @override
  int call({
    required List<int> id,
    Object? amount = ignore,
    Object? category = ignore,
    Object? note = ignore,
    Object? date = ignore,
    Object? method = ignore,
    Object? source = ignore,
    Object? merchant = ignore,
    Object? createdAt = ignore,
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
      if (amount != ignore) 1: amount as double?,
      if (category != ignore) 2: category as String?,
      if (note != ignore) 3: note as String?,
      if (date != ignore) 4: date as DateTime?,
      if (method != ignore) 5: method as String?,
      if (source != ignore) 6: source as String?,
      if (merchant != ignore) 7: merchant as String?,
      if (createdAt != ignore) 8: createdAt as DateTime?,
      if (serverId != ignore) 9: serverId as String?,
      if (clientId != ignore) 10: clientId as String?,
      if (updatedAt != ignore) 11: updatedAt as DateTime?,
      if (serverUpdatedAt != ignore) 12: serverUpdatedAt as DateTime?,
      if (syncStatus != ignore) 13: syncStatus as String?,
      if (isDeleted != ignore) 14: isDeleted as bool?,
      if (version != ignore) 15: version as int?,
      if (dirty != ignore) 16: dirty as bool?,
    });
  }
}

extension ExpenseCollectionUpdate on IsarCollection<int, ExpenseCollection> {
  _ExpenseCollectionUpdate get update => _ExpenseCollectionUpdateImpl(this);

  _ExpenseCollectionUpdateAll get updateAll =>
      _ExpenseCollectionUpdateAllImpl(this);
}

sealed class _ExpenseCollectionQueryUpdate {
  int call({
    double? amount,
    String? category,
    String? note,
    DateTime? date,
    String? method,
    String? source,
    String? merchant,
    DateTime? createdAt,
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

class _ExpenseCollectionQueryUpdateImpl
    implements _ExpenseCollectionQueryUpdate {
  const _ExpenseCollectionQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<ExpenseCollection> query;
  final int? limit;

  @override
  int call({
    Object? amount = ignore,
    Object? category = ignore,
    Object? note = ignore,
    Object? date = ignore,
    Object? method = ignore,
    Object? source = ignore,
    Object? merchant = ignore,
    Object? createdAt = ignore,
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
      if (amount != ignore) 1: amount as double?,
      if (category != ignore) 2: category as String?,
      if (note != ignore) 3: note as String?,
      if (date != ignore) 4: date as DateTime?,
      if (method != ignore) 5: method as String?,
      if (source != ignore) 6: source as String?,
      if (merchant != ignore) 7: merchant as String?,
      if (createdAt != ignore) 8: createdAt as DateTime?,
      if (serverId != ignore) 9: serverId as String?,
      if (clientId != ignore) 10: clientId as String?,
      if (updatedAt != ignore) 11: updatedAt as DateTime?,
      if (serverUpdatedAt != ignore) 12: serverUpdatedAt as DateTime?,
      if (syncStatus != ignore) 13: syncStatus as String?,
      if (isDeleted != ignore) 14: isDeleted as bool?,
      if (version != ignore) 15: version as int?,
      if (dirty != ignore) 16: dirty as bool?,
    });
  }
}

extension ExpenseCollectionQueryUpdate on IsarQuery<ExpenseCollection> {
  _ExpenseCollectionQueryUpdate get updateFirst =>
      _ExpenseCollectionQueryUpdateImpl(this, limit: 1);

  _ExpenseCollectionQueryUpdate get updateAll =>
      _ExpenseCollectionQueryUpdateImpl(this);
}

class _ExpenseCollectionQueryBuilderUpdateImpl
    implements _ExpenseCollectionQueryUpdate {
  const _ExpenseCollectionQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<ExpenseCollection, ExpenseCollection, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? amount = ignore,
    Object? category = ignore,
    Object? note = ignore,
    Object? date = ignore,
    Object? method = ignore,
    Object? source = ignore,
    Object? merchant = ignore,
    Object? createdAt = ignore,
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
        if (amount != ignore) 1: amount as double?,
        if (category != ignore) 2: category as String?,
        if (note != ignore) 3: note as String?,
        if (date != ignore) 4: date as DateTime?,
        if (method != ignore) 5: method as String?,
        if (source != ignore) 6: source as String?,
        if (merchant != ignore) 7: merchant as String?,
        if (createdAt != ignore) 8: createdAt as DateTime?,
        if (serverId != ignore) 9: serverId as String?,
        if (clientId != ignore) 10: clientId as String?,
        if (updatedAt != ignore) 11: updatedAt as DateTime?,
        if (serverUpdatedAt != ignore) 12: serverUpdatedAt as DateTime?,
        if (syncStatus != ignore) 13: syncStatus as String?,
        if (isDeleted != ignore) 14: isDeleted as bool?,
        if (version != ignore) 15: version as int?,
        if (dirty != ignore) 16: dirty as bool?,
      });
    } finally {
      q.close();
    }
  }
}

extension ExpenseCollectionQueryBuilderUpdate
    on QueryBuilder<ExpenseCollection, ExpenseCollection, QOperations> {
  _ExpenseCollectionQueryUpdate get updateFirst =>
      _ExpenseCollectionQueryBuilderUpdateImpl(this, limit: 1);

  _ExpenseCollectionQueryUpdate get updateAll =>
      _ExpenseCollectionQueryBuilderUpdateImpl(this);
}

extension ExpenseCollectionQueryFilter
    on QueryBuilder<ExpenseCollection, ExpenseCollection, QFilterCondition> {
  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  idEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  idGreaterThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  idGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  idLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 0, value: value));
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  idLessThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  idBetween(int lower, int upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 0, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  amountEqualTo(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 1, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  amountGreaterThan(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 1, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  amountGreaterThanOrEqualTo(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 1, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  amountLessThan(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 1, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  amountLessThanOrEqualTo(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 1, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  amountBetween(double lower, double upper, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  categoryEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  categoryLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  noteEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 3, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  noteGreaterThan(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  noteGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  noteLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 3, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  noteLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  noteBetween(String lower, String upper, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  noteStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  noteEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  noteContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  noteMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 3, value: ''),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 3, value: ''),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 4, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  dateGreaterThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 4, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  dateGreaterThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 4, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  dateLessThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 4, value: value));
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  dateLessThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 4, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  dateBetween(DateTime lower, DateTime upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 4, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  methodEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 5, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  methodGreaterThan(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  methodGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  methodLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 5, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  methodLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  methodBetween(String lower, String upper, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  methodStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  methodEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  methodContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  methodMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  methodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 5, value: ''),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  methodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 5, value: ''),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  sourceEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 6, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  sourceGreaterThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  sourceGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  sourceLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 6, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  sourceLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  sourceBetween(String lower, String upper, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 6,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  sourceStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  sourceEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  sourceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  sourceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 6,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  sourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 6, value: ''),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  sourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 6, value: ''),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  merchantEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 7, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  merchantGreaterThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  merchantGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  merchantLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 7, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  merchantLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  merchantBetween(String lower, String upper, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 7,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  merchantStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  merchantEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  merchantContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  merchantMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 7,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  merchantIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 7, value: ''),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  merchantIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 7, value: ''),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  createdAtGreaterThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  createdAtLessThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 8, value: value));
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  createdAtLessThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  createdAtBetween(DateTime lower, DateTime upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 8, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverIdIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 9, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverIdGreaterThan(String? value, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverIdGreaterThanOrEqualTo(String? value, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverIdLessThan(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 9, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverIdLessThanOrEqualTo(String? value, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverIdBetween(String? lower, String? upper, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverIdStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverIdEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 9, value: ''),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 9, value: ''),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  clientIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  clientIdGreaterThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  clientIdGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  clientIdLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 10, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  clientIdLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  clientIdBetween(String lower, String upper, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 10,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  clientIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  clientIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  clientIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  clientIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 10,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  clientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 10, value: ''),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  clientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 10, value: ''),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 11, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  updatedAtGreaterThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 11, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  updatedAtGreaterThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 11, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  updatedAtLessThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 11, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  updatedAtLessThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 11, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  updatedAtBetween(DateTime lower, DateTime upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 11, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverUpdatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 12));
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverUpdatedAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 12));
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverUpdatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverUpdatedAtGreaterThan(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverUpdatedAtGreaterThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverUpdatedAtLessThan(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverUpdatedAtLessThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  serverUpdatedAtBetween(DateTime? lower, DateTime? upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 12, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  syncStatusEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  syncStatusGreaterThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  syncStatusGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  syncStatusLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 13, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  syncStatusLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  syncStatusBetween(String lower, String upper, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 13,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  syncStatusStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  syncStatusEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  syncStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  syncStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 13,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  syncStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 13, value: ''),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  syncStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 13, value: ''),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  isDeletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 14, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  versionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 15, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  versionGreaterThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 15, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  versionGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 15, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  versionLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 15, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  versionLessThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 15, value: value),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  versionBetween(int lower, int upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 15, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterFilterCondition>
  dirtyEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 16, value: value),
      );
    });
  }
}

extension ExpenseCollectionQueryObject
    on QueryBuilder<ExpenseCollection, ExpenseCollection, QFilterCondition> {}

extension ExpenseCollectionQuerySortBy
    on QueryBuilder<ExpenseCollection, ExpenseCollection, QSortBy> {
  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByCategoryDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy> sortByNote({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByNoteDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByMethod({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByMethodDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortBySource({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortBySourceDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByMerchant({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByMerchantDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByServerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByServerIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByClientIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByServerUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByServerUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortBySyncStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortBySyncStatusDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, sort: Sort.desc);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  sortByDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, sort: Sort.desc);
    });
  }
}

extension ExpenseCollectionQuerySortThenBy
    on QueryBuilder<ExpenseCollection, ExpenseCollection, QSortThenBy> {
  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByCategoryDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy> thenByNote({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByNoteDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByMethod({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByMethodDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenBySource({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenBySourceDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByMerchant({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByMerchantDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByServerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByServerIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByClientIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByServerUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByServerUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenBySyncStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenBySyncStatusDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, sort: Sort.desc);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterSortBy>
  thenByDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, sort: Sort.desc);
    });
  }
}

extension ExpenseCollectionQueryWhereDistinct
    on QueryBuilder<ExpenseCollection, ExpenseCollection, QDistinct> {
  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterDistinct>
  distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterDistinct>
  distinctByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterDistinct>
  distinctByNote({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterDistinct>
  distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterDistinct>
  distinctByMethod({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterDistinct>
  distinctBySource({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterDistinct>
  distinctByMerchant({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterDistinct>
  distinctByServerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterDistinct>
  distinctByClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterDistinct>
  distinctByServerUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(12);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterDistinct>
  distinctBySyncStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(13, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterDistinct>
  distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(14);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterDistinct>
  distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(15);
    });
  }

  QueryBuilder<ExpenseCollection, ExpenseCollection, QAfterDistinct>
  distinctByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(16);
    });
  }
}

extension ExpenseCollectionQueryProperty1
    on QueryBuilder<ExpenseCollection, ExpenseCollection, QProperty> {
  QueryBuilder<ExpenseCollection, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ExpenseCollection, double, QAfterProperty> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ExpenseCollection, String, QAfterProperty> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ExpenseCollection, String, QAfterProperty> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ExpenseCollection, DateTime, QAfterProperty> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ExpenseCollection, String, QAfterProperty> methodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<ExpenseCollection, String, QAfterProperty> sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<ExpenseCollection, String, QAfterProperty> merchantProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<ExpenseCollection, DateTime, QAfterProperty>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<ExpenseCollection, String?, QAfterProperty> serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<ExpenseCollection, String, QAfterProperty> clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<ExpenseCollection, DateTime, QAfterProperty>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<ExpenseCollection, DateTime?, QAfterProperty>
  serverUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<ExpenseCollection, String, QAfterProperty> syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<ExpenseCollection, bool, QAfterProperty> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<ExpenseCollection, int, QAfterProperty> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<ExpenseCollection, bool, QAfterProperty> dirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }
}

extension ExpenseCollectionQueryProperty2<R>
    on QueryBuilder<ExpenseCollection, R, QAfterProperty> {
  QueryBuilder<ExpenseCollection, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ExpenseCollection, (R, double), QAfterProperty>
  amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ExpenseCollection, (R, String), QAfterProperty>
  categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ExpenseCollection, (R, String), QAfterProperty> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ExpenseCollection, (R, DateTime), QAfterProperty>
  dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ExpenseCollection, (R, String), QAfterProperty>
  methodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<ExpenseCollection, (R, String), QAfterProperty>
  sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<ExpenseCollection, (R, String), QAfterProperty>
  merchantProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<ExpenseCollection, (R, DateTime), QAfterProperty>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<ExpenseCollection, (R, String?), QAfterProperty>
  serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<ExpenseCollection, (R, String), QAfterProperty>
  clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<ExpenseCollection, (R, DateTime), QAfterProperty>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<ExpenseCollection, (R, DateTime?), QAfterProperty>
  serverUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<ExpenseCollection, (R, String), QAfterProperty>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<ExpenseCollection, (R, bool), QAfterProperty>
  isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<ExpenseCollection, (R, int), QAfterProperty> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<ExpenseCollection, (R, bool), QAfterProperty> dirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }
}

extension ExpenseCollectionQueryProperty3<R1, R2>
    on QueryBuilder<ExpenseCollection, (R1, R2), QAfterProperty> {
  QueryBuilder<ExpenseCollection, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ExpenseCollection, (R1, R2, double), QOperations>
  amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ExpenseCollection, (R1, R2, String), QOperations>
  categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ExpenseCollection, (R1, R2, String), QOperations>
  noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ExpenseCollection, (R1, R2, DateTime), QOperations>
  dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ExpenseCollection, (R1, R2, String), QOperations>
  methodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<ExpenseCollection, (R1, R2, String), QOperations>
  sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<ExpenseCollection, (R1, R2, String), QOperations>
  merchantProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<ExpenseCollection, (R1, R2, DateTime), QOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<ExpenseCollection, (R1, R2, String?), QOperations>
  serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<ExpenseCollection, (R1, R2, String), QOperations>
  clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<ExpenseCollection, (R1, R2, DateTime), QOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<ExpenseCollection, (R1, R2, DateTime?), QOperations>
  serverUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<ExpenseCollection, (R1, R2, String), QOperations>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<ExpenseCollection, (R1, R2, bool), QOperations>
  isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<ExpenseCollection, (R1, R2, int), QOperations>
  versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<ExpenseCollection, (R1, R2, bool), QOperations> dirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }
}
