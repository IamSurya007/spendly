// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_rule_collection.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetCategoryRuleCollectionCollection on Isar {
  IsarCollection<int, CategoryRuleCollection> get categoryRuleCollections =>
      this.collection();
}

final CategoryRuleCollectionSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'CategoryRuleCollection',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(name: 'merchant', type: IsarType.string),
      IsarPropertySchema(name: 'category', type: IsarType.string),
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
  converter: IsarObjectConverter<int, CategoryRuleCollection>(
    serialize: serializeCategoryRuleCollection,
    deserialize: deserializeCategoryRuleCollection,
    deserializeProperty: deserializeCategoryRuleCollectionProp,
  ),
  getEmbeddedSchemas: () => [],
);

@isarProtected
int serializeCategoryRuleCollection(
  IsarWriter writer,
  CategoryRuleCollection object,
) {
  IsarCore.writeString(writer, 1, object.merchant);
  IsarCore.writeString(writer, 2, object.category);
  {
    final value = object.serverId;
    if (value == null) {
      IsarCore.writeNull(writer, 3);
    } else {
      IsarCore.writeString(writer, 3, value);
    }
  }
  IsarCore.writeString(writer, 4, object.clientId);
  IsarCore.writeLong(
    writer,
    5,
    object.updatedAt.toUtc().microsecondsSinceEpoch,
  );
  IsarCore.writeLong(
    writer,
    6,
    object.serverUpdatedAt?.toUtc().microsecondsSinceEpoch ??
        -9223372036854775808,
  );
  IsarCore.writeString(writer, 7, object.syncStatus);
  IsarCore.writeBool(writer, 8, value: object.isDeleted);
  IsarCore.writeLong(writer, 9, object.version);
  IsarCore.writeBool(writer, 10, value: object.dirty);
  return object.id;
}

@isarProtected
CategoryRuleCollection deserializeCategoryRuleCollection(IsarReader reader) {
  final object = CategoryRuleCollection();
  object.id = IsarCore.readId(reader);
  object.merchant = IsarCore.readString(reader, 1) ?? '';
  object.category = IsarCore.readString(reader, 2) ?? '';
  object.serverId = IsarCore.readString(reader, 3);
  object.clientId = IsarCore.readString(reader, 4) ?? '';
  {
    final value = IsarCore.readLong(reader, 5);
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
    final value = IsarCore.readLong(reader, 6);
    if (value == -9223372036854775808) {
      object.serverUpdatedAt = null;
    } else {
      object.serverUpdatedAt = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  object.syncStatus = IsarCore.readString(reader, 7) ?? '';
  object.isDeleted = IsarCore.readBool(reader, 8);
  object.version = IsarCore.readLong(reader, 9);
  object.dirty = IsarCore.readBool(reader, 10);
  return object;
}

@isarProtected
dynamic deserializeCategoryRuleCollectionProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readString(reader, 3);
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
      {
        final value = IsarCore.readLong(reader, 6);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 7:
      return IsarCore.readString(reader, 7) ?? '';
    case 8:
      return IsarCore.readBool(reader, 8);
    case 9:
      return IsarCore.readLong(reader, 9);
    case 10:
      return IsarCore.readBool(reader, 10);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _CategoryRuleCollectionUpdate {
  bool call({
    required int id,
    String? merchant,
    String? category,
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

class _CategoryRuleCollectionUpdateImpl
    implements _CategoryRuleCollectionUpdate {
  const _CategoryRuleCollectionUpdateImpl(this.collection);

  final IsarCollection<int, CategoryRuleCollection> collection;

  @override
  bool call({
    required int id,
    Object? merchant = ignore,
    Object? category = ignore,
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
            if (merchant != ignore) 1: merchant as String?,
            if (category != ignore) 2: category as String?,
            if (serverId != ignore) 3: serverId as String?,
            if (clientId != ignore) 4: clientId as String?,
            if (updatedAt != ignore) 5: updatedAt as DateTime?,
            if (serverUpdatedAt != ignore) 6: serverUpdatedAt as DateTime?,
            if (syncStatus != ignore) 7: syncStatus as String?,
            if (isDeleted != ignore) 8: isDeleted as bool?,
            if (version != ignore) 9: version as int?,
            if (dirty != ignore) 10: dirty as bool?,
          },
        ) >
        0;
  }
}

sealed class _CategoryRuleCollectionUpdateAll {
  int call({
    required List<int> id,
    String? merchant,
    String? category,
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

class _CategoryRuleCollectionUpdateAllImpl
    implements _CategoryRuleCollectionUpdateAll {
  const _CategoryRuleCollectionUpdateAllImpl(this.collection);

  final IsarCollection<int, CategoryRuleCollection> collection;

  @override
  int call({
    required List<int> id,
    Object? merchant = ignore,
    Object? category = ignore,
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
      if (merchant != ignore) 1: merchant as String?,
      if (category != ignore) 2: category as String?,
      if (serverId != ignore) 3: serverId as String?,
      if (clientId != ignore) 4: clientId as String?,
      if (updatedAt != ignore) 5: updatedAt as DateTime?,
      if (serverUpdatedAt != ignore) 6: serverUpdatedAt as DateTime?,
      if (syncStatus != ignore) 7: syncStatus as String?,
      if (isDeleted != ignore) 8: isDeleted as bool?,
      if (version != ignore) 9: version as int?,
      if (dirty != ignore) 10: dirty as bool?,
    });
  }
}

extension CategoryRuleCollectionUpdate
    on IsarCollection<int, CategoryRuleCollection> {
  _CategoryRuleCollectionUpdate get update =>
      _CategoryRuleCollectionUpdateImpl(this);

  _CategoryRuleCollectionUpdateAll get updateAll =>
      _CategoryRuleCollectionUpdateAllImpl(this);
}

sealed class _CategoryRuleCollectionQueryUpdate {
  int call({
    String? merchant,
    String? category,
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

class _CategoryRuleCollectionQueryUpdateImpl
    implements _CategoryRuleCollectionQueryUpdate {
  const _CategoryRuleCollectionQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<CategoryRuleCollection> query;
  final int? limit;

  @override
  int call({
    Object? merchant = ignore,
    Object? category = ignore,
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
      if (merchant != ignore) 1: merchant as String?,
      if (category != ignore) 2: category as String?,
      if (serverId != ignore) 3: serverId as String?,
      if (clientId != ignore) 4: clientId as String?,
      if (updatedAt != ignore) 5: updatedAt as DateTime?,
      if (serverUpdatedAt != ignore) 6: serverUpdatedAt as DateTime?,
      if (syncStatus != ignore) 7: syncStatus as String?,
      if (isDeleted != ignore) 8: isDeleted as bool?,
      if (version != ignore) 9: version as int?,
      if (dirty != ignore) 10: dirty as bool?,
    });
  }
}

extension CategoryRuleCollectionQueryUpdate
    on IsarQuery<CategoryRuleCollection> {
  _CategoryRuleCollectionQueryUpdate get updateFirst =>
      _CategoryRuleCollectionQueryUpdateImpl(this, limit: 1);

  _CategoryRuleCollectionQueryUpdate get updateAll =>
      _CategoryRuleCollectionQueryUpdateImpl(this);
}

class _CategoryRuleCollectionQueryBuilderUpdateImpl
    implements _CategoryRuleCollectionQueryUpdate {
  const _CategoryRuleCollectionQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QOperations
  >
  query;
  final int? limit;

  @override
  int call({
    Object? merchant = ignore,
    Object? category = ignore,
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
        if (merchant != ignore) 1: merchant as String?,
        if (category != ignore) 2: category as String?,
        if (serverId != ignore) 3: serverId as String?,
        if (clientId != ignore) 4: clientId as String?,
        if (updatedAt != ignore) 5: updatedAt as DateTime?,
        if (serverUpdatedAt != ignore) 6: serverUpdatedAt as DateTime?,
        if (syncStatus != ignore) 7: syncStatus as String?,
        if (isDeleted != ignore) 8: isDeleted as bool?,
        if (version != ignore) 9: version as int?,
        if (dirty != ignore) 10: dirty as bool?,
      });
    } finally {
      q.close();
    }
  }
}

extension CategoryRuleCollectionQueryBuilderUpdate
    on
        QueryBuilder<
          CategoryRuleCollection,
          CategoryRuleCollection,
          QOperations
        > {
  _CategoryRuleCollectionQueryUpdate get updateFirst =>
      _CategoryRuleCollectionQueryBuilderUpdateImpl(this, limit: 1);

  _CategoryRuleCollectionQueryUpdate get updateAll =>
      _CategoryRuleCollectionQueryBuilderUpdateImpl(this);
}

extension CategoryRuleCollectionQueryFilter
    on
        QueryBuilder<
          CategoryRuleCollection,
          CategoryRuleCollection,
          QFilterCondition
        > {
  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  idEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  idGreaterThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  idGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  idLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 0, value: value));
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  idLessThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  idBetween(int lower, int upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 0, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  merchantEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  merchantGreaterThan(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  merchantGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  merchantLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  merchantLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  merchantBetween(String lower, String upper, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  merchantStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  merchantEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  merchantContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  merchantMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  merchantIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  merchantIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  categoryEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  categoryLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverIdIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 3, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverIdGreaterThan(String? value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverIdGreaterThanOrEqualTo(String? value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverIdLessThan(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 3, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverIdLessThanOrEqualTo(String? value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverIdBetween(String? lower, String? upper, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverIdStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverIdEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 3, value: ''),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 3, value: ''),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  clientIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 4, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  clientIdGreaterThan(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  clientIdGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  clientIdLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 4, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  clientIdLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  clientIdBetween(String lower, String upper, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  clientIdStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  clientIdEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  clientIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  clientIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  clientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 4, value: ''),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  clientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 4, value: ''),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  updatedAtGreaterThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  updatedAtGreaterThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  updatedAtLessThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 5, value: value));
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  updatedAtLessThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  updatedAtBetween(DateTime lower, DateTime upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 5, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverUpdatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverUpdatedAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverUpdatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverUpdatedAtGreaterThan(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverUpdatedAtGreaterThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverUpdatedAtLessThan(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 6, value: value));
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverUpdatedAtLessThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  serverUpdatedAtBetween(DateTime? lower, DateTime? upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 6, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  syncStatusEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 7, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  syncStatusGreaterThan(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  syncStatusGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  syncStatusLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 7, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  syncStatusLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  syncStatusBetween(String lower, String upper, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  syncStatusStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  syncStatusEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  syncStatusContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  syncStatusMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  syncStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 7, value: ''),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  syncStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 7, value: ''),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  isDeletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  versionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 9, value: value),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  versionGreaterThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 9, value: value),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  versionGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 9, value: value),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  versionLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 9, value: value));
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  versionLessThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 9, value: value),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  versionBetween(int lower, int upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 9, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<
    CategoryRuleCollection,
    CategoryRuleCollection,
    QAfterFilterCondition
  >
  dirtyEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 10, value: value),
      );
    });
  }
}

extension CategoryRuleCollectionQueryObject
    on
        QueryBuilder<
          CategoryRuleCollection,
          CategoryRuleCollection,
          QFilterCondition
        > {}

extension CategoryRuleCollectionQuerySortBy
    on QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QSortBy> {
  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortByMerchant({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortByMerchantDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortByCategoryDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortByServerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortByServerIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortByClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortByClientIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortByServerUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortByServerUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortBySyncStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortBySyncStatusDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  sortByDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }
}

extension CategoryRuleCollectionQuerySortThenBy
    on
        QueryBuilder<
          CategoryRuleCollection,
          CategoryRuleCollection,
          QSortThenBy
        > {
  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenByMerchant({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenByMerchantDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenByCategoryDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenByServerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenByServerIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenByClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenByClientIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenByServerUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenByServerUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenBySyncStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenBySyncStatusDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterSortBy>
  thenByDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }
}

extension CategoryRuleCollectionQueryWhereDistinct
    on QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QDistinct> {
  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterDistinct>
  distinctByMerchant({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterDistinct>
  distinctByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterDistinct>
  distinctByServerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterDistinct>
  distinctByClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterDistinct>
  distinctByServerUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterDistinct>
  distinctBySyncStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterDistinct>
  distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterDistinct>
  distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9);
    });
  }

  QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QAfterDistinct>
  distinctByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10);
    });
  }
}

extension CategoryRuleCollectionQueryProperty1
    on QueryBuilder<CategoryRuleCollection, CategoryRuleCollection, QProperty> {
  QueryBuilder<CategoryRuleCollection, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<CategoryRuleCollection, String, QAfterProperty>
  merchantProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<CategoryRuleCollection, String, QAfterProperty>
  categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<CategoryRuleCollection, String?, QAfterProperty>
  serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<CategoryRuleCollection, String, QAfterProperty>
  clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<CategoryRuleCollection, DateTime, QAfterProperty>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<CategoryRuleCollection, DateTime?, QAfterProperty>
  serverUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<CategoryRuleCollection, String, QAfterProperty>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<CategoryRuleCollection, bool, QAfterProperty>
  isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<CategoryRuleCollection, int, QAfterProperty> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<CategoryRuleCollection, bool, QAfterProperty> dirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }
}

extension CategoryRuleCollectionQueryProperty2<R>
    on QueryBuilder<CategoryRuleCollection, R, QAfterProperty> {
  QueryBuilder<CategoryRuleCollection, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R, String), QAfterProperty>
  merchantProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R, String), QAfterProperty>
  categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R, String?), QAfterProperty>
  serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R, String), QAfterProperty>
  clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R, DateTime), QAfterProperty>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R, DateTime?), QAfterProperty>
  serverUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R, String), QAfterProperty>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R, bool), QAfterProperty>
  isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R, int), QAfterProperty>
  versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R, bool), QAfterProperty>
  dirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }
}

extension CategoryRuleCollectionQueryProperty3<R1, R2>
    on QueryBuilder<CategoryRuleCollection, (R1, R2), QAfterProperty> {
  QueryBuilder<CategoryRuleCollection, (R1, R2, int), QOperations>
  idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R1, R2, String), QOperations>
  merchantProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R1, R2, String), QOperations>
  categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R1, R2, String?), QOperations>
  serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R1, R2, String), QOperations>
  clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R1, R2, DateTime), QOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R1, R2, DateTime?), QOperations>
  serverUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R1, R2, String), QOperations>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R1, R2, bool), QOperations>
  isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R1, R2, int), QOperations>
  versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<CategoryRuleCollection, (R1, R2, bool), QOperations>
  dirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }
}
