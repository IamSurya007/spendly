// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investment_collection.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetInvestmentCollectionCollection on Isar {
  IsarCollection<int, InvestmentCollection> get investmentCollections =>
      this.collection();
}

final InvestmentCollectionSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'InvestmentCollection',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(name: 'type', type: IsarType.string),
      IsarPropertySchema(name: 'name', type: IsarType.string),
      IsarPropertySchema(name: 'monthlyAmount', type: IsarType.double),
      IsarPropertySchema(name: 'principal', type: IsarType.double),
      IsarPropertySchema(name: 'maturityAmount', type: IsarType.double),
      IsarPropertySchema(name: 'durationMonths', type: IsarType.long),
      IsarPropertySchema(name: 'startDate', type: IsarType.dateTime),
      IsarPropertySchema(name: 'maturityDate', type: IsarType.dateTime),
      IsarPropertySchema(name: 'institution', type: IsarType.string),
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
  converter: IsarObjectConverter<int, InvestmentCollection>(
    serialize: serializeInvestmentCollection,
    deserialize: deserializeInvestmentCollection,
    deserializeProperty: deserializeInvestmentCollectionProp,
  ),
  getEmbeddedSchemas: () => [],
);

@isarProtected
int serializeInvestmentCollection(
  IsarWriter writer,
  InvestmentCollection object,
) {
  IsarCore.writeString(writer, 1, object.type);
  IsarCore.writeString(writer, 2, object.name);
  IsarCore.writeDouble(writer, 3, object.monthlyAmount);
  IsarCore.writeDouble(writer, 4, object.principal);
  IsarCore.writeDouble(writer, 5, object.maturityAmount);
  IsarCore.writeLong(writer, 6, object.durationMonths);
  IsarCore.writeLong(
    writer,
    7,
    object.startDate.toUtc().microsecondsSinceEpoch,
  );
  IsarCore.writeLong(
    writer,
    8,
    object.maturityDate.toUtc().microsecondsSinceEpoch,
  );
  IsarCore.writeString(writer, 9, object.institution);
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
InvestmentCollection deserializeInvestmentCollection(IsarReader reader) {
  final object = InvestmentCollection();
  object.id = IsarCore.readId(reader);
  object.type = IsarCore.readString(reader, 1) ?? '';
  object.name = IsarCore.readString(reader, 2) ?? '';
  object.monthlyAmount = IsarCore.readDouble(reader, 3);
  object.principal = IsarCore.readDouble(reader, 4);
  object.maturityAmount = IsarCore.readDouble(reader, 5);
  object.durationMonths = IsarCore.readLong(reader, 6);
  {
    final value = IsarCore.readLong(reader, 7);
    if (value == -9223372036854775808) {
      object.startDate = DateTime.fromMillisecondsSinceEpoch(
        0,
        isUtc: true,
      ).toLocal();
    } else {
      object.startDate = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  {
    final value = IsarCore.readLong(reader, 8);
    if (value == -9223372036854775808) {
      object.maturityDate = DateTime.fromMillisecondsSinceEpoch(
        0,
        isUtc: true,
      ).toLocal();
    } else {
      object.maturityDate = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  object.institution = IsarCore.readString(reader, 9) ?? '';
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
dynamic deserializeInvestmentCollectionProp(IsarReader reader, int property) {
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
      return IsarCore.readDouble(reader, 4);
    case 5:
      return IsarCore.readDouble(reader, 5);
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

sealed class _InvestmentCollectionUpdate {
  bool call({
    required int id,
    String? type,
    String? name,
    double? monthlyAmount,
    double? principal,
    double? maturityAmount,
    int? durationMonths,
    DateTime? startDate,
    DateTime? maturityDate,
    String? institution,
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

class _InvestmentCollectionUpdateImpl implements _InvestmentCollectionUpdate {
  const _InvestmentCollectionUpdateImpl(this.collection);

  final IsarCollection<int, InvestmentCollection> collection;

  @override
  bool call({
    required int id,
    Object? type = ignore,
    Object? name = ignore,
    Object? monthlyAmount = ignore,
    Object? principal = ignore,
    Object? maturityAmount = ignore,
    Object? durationMonths = ignore,
    Object? startDate = ignore,
    Object? maturityDate = ignore,
    Object? institution = ignore,
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
            if (type != ignore) 1: type as String?,
            if (name != ignore) 2: name as String?,
            if (monthlyAmount != ignore) 3: monthlyAmount as double?,
            if (principal != ignore) 4: principal as double?,
            if (maturityAmount != ignore) 5: maturityAmount as double?,
            if (durationMonths != ignore) 6: durationMonths as int?,
            if (startDate != ignore) 7: startDate as DateTime?,
            if (maturityDate != ignore) 8: maturityDate as DateTime?,
            if (institution != ignore) 9: institution as String?,
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

sealed class _InvestmentCollectionUpdateAll {
  int call({
    required List<int> id,
    String? type,
    String? name,
    double? monthlyAmount,
    double? principal,
    double? maturityAmount,
    int? durationMonths,
    DateTime? startDate,
    DateTime? maturityDate,
    String? institution,
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

class _InvestmentCollectionUpdateAllImpl
    implements _InvestmentCollectionUpdateAll {
  const _InvestmentCollectionUpdateAllImpl(this.collection);

  final IsarCollection<int, InvestmentCollection> collection;

  @override
  int call({
    required List<int> id,
    Object? type = ignore,
    Object? name = ignore,
    Object? monthlyAmount = ignore,
    Object? principal = ignore,
    Object? maturityAmount = ignore,
    Object? durationMonths = ignore,
    Object? startDate = ignore,
    Object? maturityDate = ignore,
    Object? institution = ignore,
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
      if (type != ignore) 1: type as String?,
      if (name != ignore) 2: name as String?,
      if (monthlyAmount != ignore) 3: monthlyAmount as double?,
      if (principal != ignore) 4: principal as double?,
      if (maturityAmount != ignore) 5: maturityAmount as double?,
      if (durationMonths != ignore) 6: durationMonths as int?,
      if (startDate != ignore) 7: startDate as DateTime?,
      if (maturityDate != ignore) 8: maturityDate as DateTime?,
      if (institution != ignore) 9: institution as String?,
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

extension InvestmentCollectionUpdate
    on IsarCollection<int, InvestmentCollection> {
  _InvestmentCollectionUpdate get update =>
      _InvestmentCollectionUpdateImpl(this);

  _InvestmentCollectionUpdateAll get updateAll =>
      _InvestmentCollectionUpdateAllImpl(this);
}

sealed class _InvestmentCollectionQueryUpdate {
  int call({
    String? type,
    String? name,
    double? monthlyAmount,
    double? principal,
    double? maturityAmount,
    int? durationMonths,
    DateTime? startDate,
    DateTime? maturityDate,
    String? institution,
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

class _InvestmentCollectionQueryUpdateImpl
    implements _InvestmentCollectionQueryUpdate {
  const _InvestmentCollectionQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<InvestmentCollection> query;
  final int? limit;

  @override
  int call({
    Object? type = ignore,
    Object? name = ignore,
    Object? monthlyAmount = ignore,
    Object? principal = ignore,
    Object? maturityAmount = ignore,
    Object? durationMonths = ignore,
    Object? startDate = ignore,
    Object? maturityDate = ignore,
    Object? institution = ignore,
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
      if (type != ignore) 1: type as String?,
      if (name != ignore) 2: name as String?,
      if (monthlyAmount != ignore) 3: monthlyAmount as double?,
      if (principal != ignore) 4: principal as double?,
      if (maturityAmount != ignore) 5: maturityAmount as double?,
      if (durationMonths != ignore) 6: durationMonths as int?,
      if (startDate != ignore) 7: startDate as DateTime?,
      if (maturityDate != ignore) 8: maturityDate as DateTime?,
      if (institution != ignore) 9: institution as String?,
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

extension InvestmentCollectionQueryUpdate on IsarQuery<InvestmentCollection> {
  _InvestmentCollectionQueryUpdate get updateFirst =>
      _InvestmentCollectionQueryUpdateImpl(this, limit: 1);

  _InvestmentCollectionQueryUpdate get updateAll =>
      _InvestmentCollectionQueryUpdateImpl(this);
}

class _InvestmentCollectionQueryBuilderUpdateImpl
    implements _InvestmentCollectionQueryUpdate {
  const _InvestmentCollectionQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<InvestmentCollection, InvestmentCollection, QOperations>
  query;
  final int? limit;

  @override
  int call({
    Object? type = ignore,
    Object? name = ignore,
    Object? monthlyAmount = ignore,
    Object? principal = ignore,
    Object? maturityAmount = ignore,
    Object? durationMonths = ignore,
    Object? startDate = ignore,
    Object? maturityDate = ignore,
    Object? institution = ignore,
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
        if (type != ignore) 1: type as String?,
        if (name != ignore) 2: name as String?,
        if (monthlyAmount != ignore) 3: monthlyAmount as double?,
        if (principal != ignore) 4: principal as double?,
        if (maturityAmount != ignore) 5: maturityAmount as double?,
        if (durationMonths != ignore) 6: durationMonths as int?,
        if (startDate != ignore) 7: startDate as DateTime?,
        if (maturityDate != ignore) 8: maturityDate as DateTime?,
        if (institution != ignore) 9: institution as String?,
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

extension InvestmentCollectionQueryBuilderUpdate
    on QueryBuilder<InvestmentCollection, InvestmentCollection, QOperations> {
  _InvestmentCollectionQueryUpdate get updateFirst =>
      _InvestmentCollectionQueryBuilderUpdateImpl(this, limit: 1);

  _InvestmentCollectionQueryUpdate get updateAll =>
      _InvestmentCollectionQueryBuilderUpdateImpl(this);
}

extension InvestmentCollectionQueryFilter
    on
        QueryBuilder<
          InvestmentCollection,
          InvestmentCollection,
          QFilterCondition
        > {
  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
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
    InvestmentCollection,
    InvestmentCollection,
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
    InvestmentCollection,
    InvestmentCollection,
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
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  idLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 0, value: value));
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
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
    InvestmentCollection,
    InvestmentCollection,
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
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  typeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  typeGreaterThan(String value, {bool caseSensitive = true}) {
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
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  typeGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  typeLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  typeLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  typeBetween(String lower, String upper, {bool caseSensitive = true}) {
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
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  typeStartsWith(String value, {bool caseSensitive = true}) {
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
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  typeEndsWith(String value, {bool caseSensitive = true}) {
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
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  typeContains(String value, {bool caseSensitive = true}) {
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
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  typeMatches(String pattern, {bool caseSensitive = true}) {
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
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  nameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  nameGreaterThan(String value, {bool caseSensitive = true}) {
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
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  nameGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  nameLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  nameLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  nameBetween(String lower, String upper, {bool caseSensitive = true}) {
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
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  nameStartsWith(String value, {bool caseSensitive = true}) {
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
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  nameEndsWith(String value, {bool caseSensitive = true}) {
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
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  nameContains(String value, {bool caseSensitive = true}) {
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
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  nameMatches(String pattern, {bool caseSensitive = true}) {
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
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  monthlyAmountEqualTo(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 3, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  monthlyAmountGreaterThan(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 3, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  monthlyAmountGreaterThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 3, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  monthlyAmountLessThan(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 3, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  monthlyAmountLessThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 3, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  monthlyAmountBetween(
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  principalEqualTo(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 4, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  principalGreaterThan(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 4, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  principalGreaterThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 4, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  principalLessThan(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 4, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  principalLessThanOrEqualTo(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 4, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  principalBetween(
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  maturityAmountEqualTo(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 5, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  maturityAmountGreaterThan(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 5, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  maturityAmountGreaterThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 5, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  maturityAmountLessThan(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 5, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  maturityAmountLessThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 5, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  maturityAmountBetween(
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  durationMonthsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  durationMonthsGreaterThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  durationMonthsGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  durationMonthsLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 6, value: value));
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  durationMonthsLessThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  durationMonthsBetween(int lower, int upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 6, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  startDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 7, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  startDateGreaterThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 7, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  startDateGreaterThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 7, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  startDateLessThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 7, value: value));
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  startDateLessThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 7, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  startDateBetween(DateTime lower, DateTime upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 7, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  maturityDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  maturityDateGreaterThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  maturityDateGreaterThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  maturityDateLessThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 8, value: value));
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  maturityDateLessThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  maturityDateBetween(DateTime lower, DateTime upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 8, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  institutionEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 9, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  institutionGreaterThan(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  institutionGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  institutionLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 9, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  institutionLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  institutionBetween(String lower, String upper, {bool caseSensitive = true}) {
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  institutionStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  institutionEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  institutionContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  institutionMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  institutionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 9, value: ''),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  institutionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 9, value: ''),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  serverIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  serverIdIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  serverIdLessThan(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 10, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  serverIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 10, value: ''),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  serverIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 10, value: ''),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  clientIdLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 11, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  clientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 11, value: ''),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  clientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 11, value: ''),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  updatedAtGreaterThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  updatedAtGreaterThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  updatedAtLessThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  updatedAtLessThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  updatedAtBetween(DateTime lower, DateTime upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 12, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  serverUpdatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 13));
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  serverUpdatedAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 13));
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  serverUpdatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  serverUpdatedAtGreaterThan(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  serverUpdatedAtGreaterThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  serverUpdatedAtLessThan(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  serverUpdatedAtLessThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  serverUpdatedAtBetween(DateTime? lower, DateTime? upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 13, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  syncStatusLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 14, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  syncStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 14, value: ''),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  syncStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 14, value: ''),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  isDeletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 15, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  versionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  versionGreaterThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  versionGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  versionLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  versionLessThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  versionBetween(int lower, int upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 16, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<
    InvestmentCollection,
    InvestmentCollection,
    QAfterFilterCondition
  >
  dirtyEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 17, value: value),
      );
    });
  }
}

extension InvestmentCollectionQueryObject
    on
        QueryBuilder<
          InvestmentCollection,
          InvestmentCollection,
          QFilterCondition
        > {}

extension InvestmentCollectionQuerySortBy
    on QueryBuilder<InvestmentCollection, InvestmentCollection, QSortBy> {
  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByTypeDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByNameDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByMonthlyAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByMonthlyAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByPrincipal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByPrincipalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByMaturityAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByMaturityAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByDurationMonths() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByDurationMonthsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByMaturityDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByMaturityDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByInstitution({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByInstitutionDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByServerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByServerIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByClientIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByServerUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByServerUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortBySyncStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortBySyncStatusDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  sortByDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, sort: Sort.desc);
    });
  }
}

extension InvestmentCollectionQuerySortThenBy
    on QueryBuilder<InvestmentCollection, InvestmentCollection, QSortThenBy> {
  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByTypeDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByNameDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByMonthlyAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByMonthlyAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByPrincipal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByPrincipalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByMaturityAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByMaturityAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByDurationMonths() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByDurationMonthsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByMaturityDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByMaturityDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByInstitution({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByInstitutionDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByServerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByServerIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByClientIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByServerUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByServerUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenBySyncStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenBySyncStatusDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, sort: Sort.desc);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterSortBy>
  thenByDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, sort: Sort.desc);
    });
  }
}

extension InvestmentCollectionQueryWhereDistinct
    on QueryBuilder<InvestmentCollection, InvestmentCollection, QDistinct> {
  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterDistinct>
  distinctByType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterDistinct>
  distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterDistinct>
  distinctByMonthlyAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterDistinct>
  distinctByPrincipal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterDistinct>
  distinctByMaturityAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterDistinct>
  distinctByDurationMonths() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterDistinct>
  distinctByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterDistinct>
  distinctByMaturityDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterDistinct>
  distinctByInstitution({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterDistinct>
  distinctByServerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterDistinct>
  distinctByClientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(12);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterDistinct>
  distinctByServerUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(13);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterDistinct>
  distinctBySyncStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(14, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterDistinct>
  distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(15);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterDistinct>
  distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(16);
    });
  }

  QueryBuilder<InvestmentCollection, InvestmentCollection, QAfterDistinct>
  distinctByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(17);
    });
  }
}

extension InvestmentCollectionQueryProperty1
    on QueryBuilder<InvestmentCollection, InvestmentCollection, QProperty> {
  QueryBuilder<InvestmentCollection, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<InvestmentCollection, String, QAfterProperty> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<InvestmentCollection, String, QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<InvestmentCollection, double, QAfterProperty>
  monthlyAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<InvestmentCollection, double, QAfterProperty>
  principalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<InvestmentCollection, double, QAfterProperty>
  maturityAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<InvestmentCollection, int, QAfterProperty>
  durationMonthsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<InvestmentCollection, DateTime, QAfterProperty>
  startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<InvestmentCollection, DateTime, QAfterProperty>
  maturityDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<InvestmentCollection, String, QAfterProperty>
  institutionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<InvestmentCollection, String?, QAfterProperty>
  serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<InvestmentCollection, String, QAfterProperty>
  clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<InvestmentCollection, DateTime, QAfterProperty>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<InvestmentCollection, DateTime?, QAfterProperty>
  serverUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<InvestmentCollection, String, QAfterProperty>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<InvestmentCollection, bool, QAfterProperty> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<InvestmentCollection, int, QAfterProperty> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<InvestmentCollection, bool, QAfterProperty> dirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }
}

extension InvestmentCollectionQueryProperty2<R>
    on QueryBuilder<InvestmentCollection, R, QAfterProperty> {
  QueryBuilder<InvestmentCollection, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<InvestmentCollection, (R, String), QAfterProperty>
  typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<InvestmentCollection, (R, String), QAfterProperty>
  nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<InvestmentCollection, (R, double), QAfterProperty>
  monthlyAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<InvestmentCollection, (R, double), QAfterProperty>
  principalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<InvestmentCollection, (R, double), QAfterProperty>
  maturityAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<InvestmentCollection, (R, int), QAfterProperty>
  durationMonthsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<InvestmentCollection, (R, DateTime), QAfterProperty>
  startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<InvestmentCollection, (R, DateTime), QAfterProperty>
  maturityDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<InvestmentCollection, (R, String), QAfterProperty>
  institutionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<InvestmentCollection, (R, String?), QAfterProperty>
  serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<InvestmentCollection, (R, String), QAfterProperty>
  clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<InvestmentCollection, (R, DateTime), QAfterProperty>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<InvestmentCollection, (R, DateTime?), QAfterProperty>
  serverUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<InvestmentCollection, (R, String), QAfterProperty>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<InvestmentCollection, (R, bool), QAfterProperty>
  isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<InvestmentCollection, (R, int), QAfterProperty>
  versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<InvestmentCollection, (R, bool), QAfterProperty>
  dirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }
}

extension InvestmentCollectionQueryProperty3<R1, R2>
    on QueryBuilder<InvestmentCollection, (R1, R2), QAfterProperty> {
  QueryBuilder<InvestmentCollection, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<InvestmentCollection, (R1, R2, String), QOperations>
  typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<InvestmentCollection, (R1, R2, String), QOperations>
  nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<InvestmentCollection, (R1, R2, double), QOperations>
  monthlyAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<InvestmentCollection, (R1, R2, double), QOperations>
  principalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<InvestmentCollection, (R1, R2, double), QOperations>
  maturityAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<InvestmentCollection, (R1, R2, int), QOperations>
  durationMonthsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<InvestmentCollection, (R1, R2, DateTime), QOperations>
  startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<InvestmentCollection, (R1, R2, DateTime), QOperations>
  maturityDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<InvestmentCollection, (R1, R2, String), QOperations>
  institutionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<InvestmentCollection, (R1, R2, String?), QOperations>
  serverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<InvestmentCollection, (R1, R2, String), QOperations>
  clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<InvestmentCollection, (R1, R2, DateTime), QOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<InvestmentCollection, (R1, R2, DateTime?), QOperations>
  serverUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<InvestmentCollection, (R1, R2, String), QOperations>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<InvestmentCollection, (R1, R2, bool), QOperations>
  isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<InvestmentCollection, (R1, R2, int), QOperations>
  versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<InvestmentCollection, (R1, R2, bool), QOperations>
  dirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }
}
