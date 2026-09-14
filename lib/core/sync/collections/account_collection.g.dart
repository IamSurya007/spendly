// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_collection.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetAccountCollectionCollection on Isar {
  IsarCollection<int, AccountCollection> get accountCollections =>
      this.collection();
}

final AccountCollectionSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'AccountCollection',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(name: 'name', type: IsarType.string),
      IsarPropertySchema(name: 'type', type: IsarType.string),
      IsarPropertySchema(name: 'institution', type: IsarType.string),
      IsarPropertySchema(name: 'currentBalance', type: IsarType.double),
      IsarPropertySchema(name: 'creditLimit', type: IsarType.double),
      IsarPropertySchema(name: 'colorValue', type: IsarType.long),
      IsarPropertySchema(name: 'iconName', type: IsarType.string),
      IsarPropertySchema(name: 'isArchived', type: IsarType.bool),
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
  converter: IsarObjectConverter<int, AccountCollection>(
    serialize: serializeAccountCollection,
    deserialize: deserializeAccountCollection,
    deserializeProperty: deserializeAccountCollectionProp,
  ),
  getEmbeddedSchemas: () => [],
);

@isarProtected
int serializeAccountCollection(IsarWriter writer, AccountCollection object) {
  IsarCore.writeString(writer, 1, object.name);
  IsarCore.writeString(writer, 2, object.type);
  IsarCore.writeString(writer, 3, object.institution);
  IsarCore.writeDouble(writer, 4, object.currentBalance);
  IsarCore.writeDouble(writer, 5, object.creditLimit);
  IsarCore.writeLong(writer, 6, object.colorValue);
  IsarCore.writeString(writer, 7, object.iconName);
  IsarCore.writeBool(writer, 8, value: object.isArchived);
  IsarCore.writeLong(
    writer,
    9,
    object.createdAt.toUtc().microsecondsSinceEpoch,
  );
  {
    final value = object.serverId;
    if (value == null) {
      IsarCore.writeNull(writer, 10);
    } else {
      IsarCore.writeString(writer, 10, value);
    }
  }
  IsarCore.writeString(writer, 11, object.clientId);
  IsarCore.writeLong(
    writer,
    12,
    object.updatedAt.toUtc().microsecondsSinceEpoch,
  );
  IsarCore.writeLong(
    writer,
    13,
    object.serverUpdatedAt?.toUtc().microsecondsSinceEpoch ??
        -9223372036854775808,
  );
  IsarCore.writeString(writer, 14, object.syncStatus);
  IsarCore.writeBool(writer, 15, value: object.isDeleted);
  IsarCore.writeLong(writer, 16, object.version);
  IsarCore.writeBool(writer, 17, value: object.dirty);
  return object.id;
}

@isarProtected
AccountCollection deserializeAccountCollection(IsarReader reader) {
  final object = AccountCollection();
  object.id = IsarCore.readId(reader);
  object.name = IsarCore.readString(reader, 1) ?? '';
  object.type = IsarCore.readString(reader, 2) ?? '';
  object.institution = IsarCore.readString(reader, 3) ?? '';
  object.currentBalance = IsarCore.readDouble(reader, 4);
  object.creditLimit = IsarCore.readDouble(reader, 5);
  object.colorValue = IsarCore.readLong(reader, 6);
  object.iconName = IsarCore.readString(reader, 7) ?? '';
  object.isArchived = IsarCore.readBool(reader, 8);
  {
    final value = IsarCore.readLong(reader, 9);
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
  object.serverId = IsarCore.readString(reader, 10);
  object.clientId = IsarCore.readString(reader, 11) ?? '';
  {
    final value = IsarCore.readLong(reader, 12);
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
    final value = IsarCore.readLong(reader, 13);
    if (value == -9223372036854775808) {
      object.serverUpdatedAt = null;
    } else {
      object.serverUpdatedAt = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  object.syncStatus = IsarCore.readString(reader, 14) ?? '';
  object.isDeleted = IsarCore.readBool(reader, 15);
  object.version = IsarCore.readLong(reader, 16);
  object.dirty = IsarCore.readBool(reader, 17);
  return object;
}

@isarProtected
dynamic deserializeAccountCollectionProp(IsarReader reader, int property) {
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
      return IsarCore.readDouble(reader, 4);
    case 5:
      return IsarCore.readDouble(reader, 5);
    case 6:
      return IsarCore.readLong(reader, 6);
    case 7:
      return IsarCore.readString(reader, 7) ?? '';
    case 8:
      return IsarCore.readBool(reader, 8);
    case 9:
      {
        final value = IsarCore.readLong(reader, 9);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 10:
      return IsarCore.readString(reader, 10);
    case 11:
      return IsarCore.readString(reader, 11) ?? '';
    case 12:
      {
        final value = IsarCore.readLong(reader, 12);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 13:
      {
        final value = IsarCore.readLong(reader, 13);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 14:
      return IsarCore.readString(reader, 14) ?? '';
    case 15:
      return IsarCore.readBool(reader, 15);
    case 16:
      return IsarCore.readLong(reader, 16);
    case 17:
      return IsarCore.readBool(reader, 17);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _AccountCollectionUpdate {
  bool call({
    required int id,
    String? name,
    String? type,
    String? institution,
    double? currentBalance,
    double? creditLimit,
    int? colorValue,
    String? iconName,
    bool? isArchived,
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

class _AccountCollectionUpdateImpl implements _AccountCollectionUpdate {
  const _AccountCollectionUpdateImpl(this.collection);

  final IsarCollection<int, AccountCollection> collection;

  @override
  bool call({
    required int id,
    Object? name = ignore,
    Object? type = ignore,
    Object? institution = ignore,
    Object? currentBalance = ignore,
    Object? creditLimit = ignore,
    Object? colorValue = ignore,
    Object? iconName = ignore,
    Object? isArchived = ignore,
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
            if (name != ignore) 1: name as String?,
            if (type != ignore) 2: type as String?,
            if (institution != ignore) 3: institution as String?,
            if (currentBalance != ignore) 4: currentBalance as double?,
            if (creditLimit != ignore) 5: creditLimit as double?,
            if (colorValue != ignore) 6: colorValue as int?,
            if (iconName != ignore) 7: iconName as String?,
            if (isArchived != ignore) 8: isArchived as bool?,
            if (createdAt != ignore) 9: createdAt as DateTime?,
            if (serverId != ignore) 10: serverId as String?,
            if (clientId != ignore) 11: clientId as String?,
            if (updatedAt != ignore) 12: updatedAt as DateTime?,
            if (serverUpdatedAt != ignore) 13: serverUpdatedAt as DateTime?,
            if (syncStatus != ignore) 14: syncStatus as String?,
            if (isDeleted != ignore) 15: isDeleted as bool?,
            if (version != ignore) 16: version as int?,
            if (dirty != ignore) 17: dirty as bool?,
          },
        ) >
        0;
  }
}

sealed class _AccountCollectionUpdateAll {
  int call({
    required List<int> id,
    String? name,
    String? type,
    String? institution,
    double? currentBalance,
    double? creditLimit,
    int? colorValue,
    String? iconName,
    bool? isArchived,
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

class _AccountCollectionUpdateAllImpl implements _AccountCollectionUpdateAll {
  const _AccountCollectionUpdateAllImpl(this.collection);

  final IsarCollection<int, AccountCollection> collection;

  @override
  int call({
    required List<int> id,
    Object? name = ignore,
    Object? type = ignore,
    Object? institution = ignore,
    Object? currentBalance = ignore,
    Object? creditLimit = ignore,
    Object? colorValue = ignore,
    Object? iconName = ignore,
    Object? isArchived = ignore,
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
      if (name != ignore) 1: name as String?,
      if (type != ignore) 2: type as String?,
      if (institution != ignore) 3: institution as String?,
      if (currentBalance != ignore) 4: currentBalance as double?,
      if (creditLimit != ignore) 5: creditLimit as double?,
      if (colorValue != ignore) 6: colorValue as int?,
      if (iconName != ignore) 7: iconName as String?,
      if (isArchived != ignore) 8: isArchived as bool?,
      if (createdAt != ignore) 9: createdAt as DateTime?,
      if (serverId != ignore) 10: serverId as String?,
      if (clientId != ignore) 11: clientId as String?,
      if (updatedAt != ignore) 12: updatedAt as DateTime?,
      if (serverUpdatedAt != ignore) 13: serverUpdatedAt as DateTime?,
      if (syncStatus != ignore) 14: syncStatus as String?,
      if (isDeleted != ignore) 15: isDeleted as bool?,
      if (version != ignore) 16: version as int?,
      if (dirty != ignore) 17: dirty as bool?,
    });
  }
}

extension AccountCollectionUpdate on IsarCollection<int, AccountCollection> {
  _AccountCollectionUpdate get update => _AccountCollectionUpdateImpl(this);

  _AccountCollectionUpdateAll get updateAll =>
      _AccountCollectionUpdateAllImpl(this);
}

sealed class _AccountCollectionQueryUpdate {
  int call({
    String? name,
    String? type,
    String? institution,
    double? currentBalance,
    double? creditLimit,
    int? colorValue,
    String? iconName,
    bool? isArchived,
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

class _AccountCollectionQueryUpdateImpl
    implements _AccountCollectionQueryUpdate {
  const _AccountCollectionQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<AccountCollection> query;
  final int? limit;

  @override
  int call({
    Object? name = ignore,
    Object? type = ignore,
    Object? institution = ignore,
    Object? currentBalance = ignore,
    Object? creditLimit = ignore,
    Object? colorValue = ignore,
    Object? iconName = ignore,
    Object? isArchived = ignore,
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
      if (name != ignore) 1: name as String?,
      if (type != ignore) 2: type as String?,
      if (institution != ignore) 3: institution as String?,
      if (currentBalance != ignore) 4: currentBalance as double?,
      if (creditLimit != ignore) 5: creditLimit as double?,
      if (colorValue != ignore) 6: colorValue as int?,
      if (iconName != ignore) 7: iconName as String?,
      if (isArchived != ignore) 8: isArchived as bool?,
      if (createdAt != ignore) 9: createdAt as DateTime?,
      if (serverId != ignore) 10: serverId as String?,
      if (clientId != ignore) 11: clientId as String?,
      if (updatedAt != ignore) 12: updatedAt as DateTime?,
      if (serverUpdatedAt != ignore) 13: serverUpdatedAt as DateTime?,
      if (syncStatus != ignore) 14: syncStatus as String?,
      if (isDeleted != ignore) 15: isDeleted as bool?,
      if (version != ignore) 16: version as int?,
      if (dirty != ignore) 17: dirty as bool?,
    });
  }
}

extension AccountCollectionQueryUpdate on IsarQuery<AccountCollection> {
  _AccountCollectionQueryUpdate get updateFirst =>
      _AccountCollectionQueryUpdateImpl(this, limit: 1);

  _AccountCollectionQueryUpdate get updateAll =>
      _AccountCollectionQueryUpdateImpl(this);
}

class _AccountCollectionQueryBuilderUpdateImpl
    implements _AccountCollectionQueryUpdate {
  const _AccountCollectionQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<AccountCollection, AccountCollection, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? name = ignore,
    Object? type = ignore,
    Object? institution = ignore,
    Object? currentBalance = ignore,
    Object? creditLimit = ignore,
    Object? colorValue = ignore,
    Object? iconName = ignore,
    Object? isArchived = ignore,
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
        if (name != ignore) 1: name as String?,
        if (type != ignore) 2: type as String?,
        if (institution != ignore) 3: institution as String?,
        if (currentBalance != ignore) 4: currentBalance as double?,
        if (creditLimit != ignore) 5: creditLimit as double?,
        if (colorValue != ignore) 6: colorValue as int?,
        if (iconName != ignore) 7: iconName as String?,
        if (isArchived != ignore) 8: isArchived as bool?,
        if (createdAt != ignore) 9: createdAt as DateTime?,
        if (serverId != ignore) 10: serverId as String?,
        if (clientId != ignore) 11: clientId as String?,
        if (updatedAt != ignore) 12: updatedAt as DateTime?,
        if (serverUpdatedAt != ignore) 13: serverUpdatedAt as DateTime?,
        if (syncStatus != ignore) 14: syncStatus as String?,
        if (isDeleted != ignore) 15: isDeleted as bool?,
        if (version != ignore) 16: version as int?,
        if (dirty != ignore) 17: dirty as bool?,
      });
    } finally {
      q.close();
    }
  }
}

extension AccountCollectionQueryBuilderUpdate
    on QueryBuilder<AccountCollection, AccountCollection, QOperations> {
  _AccountCollectionQueryUpdate get updateFirst =>
      _AccountCollectionQueryBuilderUpdateImpl(this, limit: 1);

  _AccountCollectionQueryUpdate get updateAll =>
      _AccountCollectionQueryBuilderUpdateImpl(this);
}

extension AccountCollectionQueryFilter
    on QueryBuilder<AccountCollection, AccountCollection, QFilterCondition> {
  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  idEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  idGreaterThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  idGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  idLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 0, value: value));
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  idLessThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  idBetween(int lower, int upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 0, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  nameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  nameGreaterThan(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  nameGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  nameLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  nameLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  nameBetween(String lower, String upper, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  nameStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  nameEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  nameContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  nameMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  typeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  typeGreaterThan(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  typeGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  typeLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  typeLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  typeBetween(String lower, String upper, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  typeStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  typeEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  typeContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  typeMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  institutionEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 3, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  institutionGreaterThan(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  institutionGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  institutionLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 3, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  institutionLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  institutionBetween(String lower, String upper, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  institutionStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  institutionEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  institutionContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  institutionMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  institutionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 3, value: ''),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  institutionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 3, value: ''),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  currentBalanceEqualTo(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 4, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  currentBalanceGreaterThan(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 4, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  currentBalanceGreaterThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 4, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  currentBalanceLessThan(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 4, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  currentBalanceLessThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 4, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  currentBalanceBetween(
    double lower,
    double upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  creditLimitEqualTo(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 5, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  creditLimitGreaterThan(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 5, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  creditLimitGreaterThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 5, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  creditLimitLessThan(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 5, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  creditLimitLessThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 5, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  creditLimitBetween(
    double lower,
    double upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 5,
          lower: lower,
          upper: upper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  colorValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  colorValueGreaterThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  colorValueGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  colorValueLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 6, value: value));
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  colorValueLessThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  colorValueBetween(int lower, int upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 6, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  iconNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 7, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  iconNameGreaterThan(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  iconNameGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  iconNameLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 7, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  iconNameLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  iconNameBetween(String lower, String upper, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  iconNameStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  iconNameEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  iconNameContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  iconNameMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  iconNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 7, value: ''),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  iconNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 7, value: ''),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  isArchivedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 9, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 9, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  createdAtGreaterThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 9, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  createdAtLessThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 9, value: value));
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  createdAtLessThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 9, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  createdAtBetween(DateTime lower, DateTime upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 9, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverIdIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverIdEqualTo(String? value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverIdGreaterThan(String? value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverIdGreaterThanOrEqualTo(String? value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverIdLessThan(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 10, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverIdLessThanOrEqualTo(String? value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverIdBetween(String? lower, String? upper, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverIdStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverIdEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 10, value: ''),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 10, value: ''),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  clientIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  clientIdGreaterThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  clientIdGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  clientIdLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 11, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  clientIdLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  clientIdBetween(String lower, String upper, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 11,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  clientIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  clientIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  clientIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  clientIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 11,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  clientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 11, value: ''),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  clientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 11, value: ''),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  updatedAtGreaterThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  updatedAtGreaterThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  updatedAtLessThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  updatedAtLessThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  updatedAtBetween(DateTime lower, DateTime upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 12, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverUpdatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 13));
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverUpdatedAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 13));
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverUpdatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverUpdatedAtGreaterThan(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverUpdatedAtGreaterThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverUpdatedAtLessThan(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverUpdatedAtLessThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  serverUpdatedAtBetween(DateTime? lower, DateTime? upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 13, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  syncStatusEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  syncStatusGreaterThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  syncStatusGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  syncStatusLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 14, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  syncStatusLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  syncStatusBetween(String lower, String upper, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 14,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  syncStatusStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  syncStatusEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  syncStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  syncStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 14,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  syncStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 14, value: ''),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  syncStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 14, value: ''),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  isDeletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 15, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  versionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  versionGreaterThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  versionGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  versionLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  versionLessThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  versionBetween(int lower, int upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 16, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterFilterCondition>
  dirtyEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 17, value: value),
      );
    });
  }
}

extension AccountCollectionQueryObject
    on QueryBuilder<AccountCollection, AccountCollection, QFilterCondition> {}

extension AccountCollectionQuerySortBy
    on QueryBuilder<AccountCollection, AccountCollection, QSortBy> {
  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy> sortByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByNameDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy> sortByType({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByTypeDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByInstitution({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByInstitutionDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByCurrentBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByCurrentBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByCreditLimit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByCreditLimitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByIconName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByIconNameDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByIsArchivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByServerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByServerIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByClientIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByServerUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByServerUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortBySyncStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortBySyncStatusDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  sortByDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, sort: Sort.desc);
    });
  }
}

extension AccountCollectionQuerySortThenBy
    on QueryBuilder<AccountCollection, AccountCollection, QSortThenBy> {
  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy> thenByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByNameDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy> thenByType({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByTypeDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByInstitution({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByInstitutionDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByCurrentBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByCurrentBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByCreditLimit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByCreditLimitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByIconName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByIconNameDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByIsArchivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByServerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByServerIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByClientIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByServerUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByServerUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenBySyncStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenBySyncStatusDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, sort: Sort.desc);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterSortBy>
  thenByDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, sort: Sort.desc);
    });
  }
}

extension AccountCollectionQueryWhereDistinct
    on QueryBuilder<AccountCollection, AccountCollection, QDistinct> {
  QueryBuilder<AccountCollection, AccountCollection, QAfterDistinct>
  distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterDistinct>
  distinctByType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterDistinct>
  distinctByInstitution({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterDistinct>
  distinctByCurrentBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterDistinct>
  distinctByCreditLimit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterDistinct>
  distinctByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterDistinct>
  distinctByIconName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterDistinct>
  distinctByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterDistinct>
  distinctByServerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterDistinct>
  distinctByClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(12);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterDistinct>
  distinctByServerUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(13);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterDistinct>
  distinctBySyncStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(14, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterDistinct>
  distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(15);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterDistinct>
  distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(16);
    });
  }

  QueryBuilder<AccountCollection, AccountCollection, QAfterDistinct>
  distinctByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(17);
    });
  }
}

extension AccountCollectionQueryProperty1
    on QueryBuilder<AccountCollection, AccountCollection, QProperty> {
  QueryBuilder<AccountCollection, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<AccountCollection, String, QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<AccountCollection, String, QAfterProperty> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<AccountCollection, String, QAfterProperty>
  institutionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<AccountCollection, double, QAfterProperty>
  currentBalanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<AccountCollection, double, QAfterProperty>
  creditLimitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<AccountCollection, int, QAfterProperty> colorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<AccountCollection, String, QAfterProperty> iconNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<AccountCollection, bool, QAfterProperty> isArchivedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<AccountCollection, DateTime, QAfterProperty>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<AccountCollection, String?, QAfterProperty> serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<AccountCollection, String, QAfterProperty> clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<AccountCollection, DateTime, QAfterProperty>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<AccountCollection, DateTime?, QAfterProperty>
  serverUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<AccountCollection, String, QAfterProperty> syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<AccountCollection, bool, QAfterProperty> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<AccountCollection, int, QAfterProperty> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<AccountCollection, bool, QAfterProperty> dirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }
}

extension AccountCollectionQueryProperty2<R>
    on QueryBuilder<AccountCollection, R, QAfterProperty> {
  QueryBuilder<AccountCollection, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<AccountCollection, (R, String), QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<AccountCollection, (R, String), QAfterProperty> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<AccountCollection, (R, String), QAfterProperty>
  institutionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<AccountCollection, (R, double), QAfterProperty>
  currentBalanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<AccountCollection, (R, double), QAfterProperty>
  creditLimitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<AccountCollection, (R, int), QAfterProperty>
  colorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<AccountCollection, (R, String), QAfterProperty>
  iconNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<AccountCollection, (R, bool), QAfterProperty>
  isArchivedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<AccountCollection, (R, DateTime), QAfterProperty>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<AccountCollection, (R, String?), QAfterProperty>
  serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<AccountCollection, (R, String), QAfterProperty>
  clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<AccountCollection, (R, DateTime), QAfterProperty>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<AccountCollection, (R, DateTime?), QAfterProperty>
  serverUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<AccountCollection, (R, String), QAfterProperty>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<AccountCollection, (R, bool), QAfterProperty>
  isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<AccountCollection, (R, int), QAfterProperty> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<AccountCollection, (R, bool), QAfterProperty> dirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }
}

extension AccountCollectionQueryProperty3<R1, R2>
    on QueryBuilder<AccountCollection, (R1, R2), QAfterProperty> {
  QueryBuilder<AccountCollection, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<AccountCollection, (R1, R2, String), QOperations>
  nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<AccountCollection, (R1, R2, String), QOperations>
  typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<AccountCollection, (R1, R2, String), QOperations>
  institutionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<AccountCollection, (R1, R2, double), QOperations>
  currentBalanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<AccountCollection, (R1, R2, double), QOperations>
  creditLimitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<AccountCollection, (R1, R2, int), QOperations>
  colorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<AccountCollection, (R1, R2, String), QOperations>
  iconNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<AccountCollection, (R1, R2, bool), QOperations>
  isArchivedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<AccountCollection, (R1, R2, DateTime), QOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<AccountCollection, (R1, R2, String?), QOperations>
  serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<AccountCollection, (R1, R2, String), QOperations>
  clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<AccountCollection, (R1, R2, DateTime), QOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<AccountCollection, (R1, R2, DateTime?), QOperations>
  serverUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<AccountCollection, (R1, R2, String), QOperations>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<AccountCollection, (R1, R2, bool), QOperations>
  isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<AccountCollection, (R1, R2, int), QOperations>
  versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<AccountCollection, (R1, R2, bool), QOperations> dirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }
}
