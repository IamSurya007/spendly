// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_state.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetSyncStateCollection on Isar {
  IsarCollection<int, SyncState> get syncStates => this.collection();
}

final SyncStateSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'SyncState',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(name: 'entityType', type: IsarType.string),
      IsarPropertySchema(name: 'lastPulledCursor', type: IsarType.string),
      IsarPropertySchema(name: 'lastPulledAt', type: IsarType.dateTime),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'entityType',
        properties: ["entityType"],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, SyncState>(
    serialize: serializeSyncState,
    deserialize: deserializeSyncState,
    deserializeProperty: deserializeSyncStateProp,
  ),
  getEmbeddedSchemas: () => [],
);

@isarProtected
int serializeSyncState(IsarWriter writer, SyncState object) {
  IsarCore.writeString(writer, 1, object.entityType);
  {
    final value = object.lastPulledCursor;
    if (value == null) {
      IsarCore.writeNull(writer, 2);
    } else {
      IsarCore.writeString(writer, 2, value);
    }
  }
  IsarCore.writeLong(
    writer,
    3,
    object.lastPulledAt?.toUtc().microsecondsSinceEpoch ?? -9223372036854775808,
  );
  return object.id;
}

@isarProtected
SyncState deserializeSyncState(IsarReader reader) {
  final object = SyncState();
  object.id = IsarCore.readId(reader);
  object.entityType = IsarCore.readString(reader, 1) ?? '';
  object.lastPulledCursor = IsarCore.readString(reader, 2);
  {
    final value = IsarCore.readLong(reader, 3);
    if (value == -9223372036854775808) {
      object.lastPulledAt = null;
    } else {
      object.lastPulledAt = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  return object;
}

@isarProtected
dynamic deserializeSyncStateProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2);
    case 3:
      {
        final value = IsarCore.readLong(reader, 3);
        if (value == -9223372036854775808) {
          return null;
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

sealed class _SyncStateUpdate {
  bool call({
    required int id,
    String? entityType,
    String? lastPulledCursor,
    DateTime? lastPulledAt,
  });
}

class _SyncStateUpdateImpl implements _SyncStateUpdate {
  const _SyncStateUpdateImpl(this.collection);

  final IsarCollection<int, SyncState> collection;

  @override
  bool call({
    required int id,
    Object? entityType = ignore,
    Object? lastPulledCursor = ignore,
    Object? lastPulledAt = ignore,
  }) {
    return collection.updateProperties(
          [id],
          {
            if (entityType != ignore) 1: entityType as String?,
            if (lastPulledCursor != ignore) 2: lastPulledCursor as String?,
            if (lastPulledAt != ignore) 3: lastPulledAt as DateTime?,
          },
        ) >
        0;
  }
}

sealed class _SyncStateUpdateAll {
  int call({
    required List<int> id,
    String? entityType,
    String? lastPulledCursor,
    DateTime? lastPulledAt,
  });
}

class _SyncStateUpdateAllImpl implements _SyncStateUpdateAll {
  const _SyncStateUpdateAllImpl(this.collection);

  final IsarCollection<int, SyncState> collection;

  @override
  int call({
    required List<int> id,
    Object? entityType = ignore,
    Object? lastPulledCursor = ignore,
    Object? lastPulledAt = ignore,
  }) {
    return collection.updateProperties(id, {
      if (entityType != ignore) 1: entityType as String?,
      if (lastPulledCursor != ignore) 2: lastPulledCursor as String?,
      if (lastPulledAt != ignore) 3: lastPulledAt as DateTime?,
    });
  }
}

extension SyncStateUpdate on IsarCollection<int, SyncState> {
  _SyncStateUpdate get update => _SyncStateUpdateImpl(this);

  _SyncStateUpdateAll get updateAll => _SyncStateUpdateAllImpl(this);
}

sealed class _SyncStateQueryUpdate {
  int call({
    String? entityType,
    String? lastPulledCursor,
    DateTime? lastPulledAt,
  });
}

class _SyncStateQueryUpdateImpl implements _SyncStateQueryUpdate {
  const _SyncStateQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<SyncState> query;
  final int? limit;

  @override
  int call({
    Object? entityType = ignore,
    Object? lastPulledCursor = ignore,
    Object? lastPulledAt = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (entityType != ignore) 1: entityType as String?,
      if (lastPulledCursor != ignore) 2: lastPulledCursor as String?,
      if (lastPulledAt != ignore) 3: lastPulledAt as DateTime?,
    });
  }
}

extension SyncStateQueryUpdate on IsarQuery<SyncState> {
  _SyncStateQueryUpdate get updateFirst =>
      _SyncStateQueryUpdateImpl(this, limit: 1);

  _SyncStateQueryUpdate get updateAll => _SyncStateQueryUpdateImpl(this);
}

class _SyncStateQueryBuilderUpdateImpl implements _SyncStateQueryUpdate {
  const _SyncStateQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<SyncState, SyncState, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? entityType = ignore,
    Object? lastPulledCursor = ignore,
    Object? lastPulledAt = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (entityType != ignore) 1: entityType as String?,
        if (lastPulledCursor != ignore) 2: lastPulledCursor as String?,
        if (lastPulledAt != ignore) 3: lastPulledAt as DateTime?,
      });
    } finally {
      q.close();
    }
  }
}

extension SyncStateQueryBuilderUpdate
    on QueryBuilder<SyncState, SyncState, QOperations> {
  _SyncStateQueryUpdate get updateFirst =>
      _SyncStateQueryBuilderUpdateImpl(this, limit: 1);

  _SyncStateQueryUpdate get updateAll => _SyncStateQueryBuilderUpdateImpl(this);
}

extension SyncStateQueryFilter
    on QueryBuilder<SyncState, SyncState, QFilterCondition> {
  QueryBuilder<SyncState, SyncState, QAfterFilterCondition> idEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition> idGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  idGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition> idLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 0, value: value));
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition> idLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition> idBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 0, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition> entityTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
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

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
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

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition> entityTypeLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
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

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition> entityTypeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
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

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition> entityTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition> entityTypeContains(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition> entityTypeMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  entityTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  entityTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledCursorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledCursorIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledCursorEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledCursorGreaterThan(String? value, {bool caseSensitive = true}) {
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

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledCursorGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledCursorLessThan(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledCursorLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledCursorBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledCursorStartsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledCursorEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledCursorContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledCursorMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledCursorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledCursorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition> lastPulledAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 3, value: value),
      );
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledAtGreaterThan(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 3, value: value),
      );
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledAtGreaterThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 3, value: value),
      );
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledAtLessThan(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 3, value: value));
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition>
  lastPulledAtLessThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 3, value: value),
      );
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterFilterCondition> lastPulledAtBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 3, lower: lower, upper: upper),
      );
    });
  }
}

extension SyncStateQueryObject
    on QueryBuilder<SyncState, SyncState, QFilterCondition> {}

extension SyncStateQuerySortBy on QueryBuilder<SyncState, SyncState, QSortBy> {
  QueryBuilder<SyncState, SyncState, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterSortBy> sortByEntityType({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterSortBy> sortByEntityTypeDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterSortBy> sortByLastPulledCursor({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterSortBy> sortByLastPulledCursorDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterSortBy> sortByLastPulledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterSortBy> sortByLastPulledAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }
}

extension SyncStateQuerySortThenBy
    on QueryBuilder<SyncState, SyncState, QSortThenBy> {
  QueryBuilder<SyncState, SyncState, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterSortBy> thenByEntityType({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterSortBy> thenByEntityTypeDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterSortBy> thenByLastPulledCursor({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterSortBy> thenByLastPulledCursorDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterSortBy> thenByLastPulledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterSortBy> thenByLastPulledAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }
}

extension SyncStateQueryWhereDistinct
    on QueryBuilder<SyncState, SyncState, QDistinct> {
  QueryBuilder<SyncState, SyncState, QAfterDistinct> distinctByEntityType({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterDistinct>
  distinctByLastPulledCursor({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SyncState, SyncState, QAfterDistinct> distinctByLastPulledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }
}

extension SyncStateQueryProperty1
    on QueryBuilder<SyncState, SyncState, QProperty> {
  QueryBuilder<SyncState, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<SyncState, String, QAfterProperty> entityTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SyncState, String?, QAfterProperty> lastPulledCursorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<SyncState, DateTime?, QAfterProperty> lastPulledAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension SyncStateQueryProperty2<R>
    on QueryBuilder<SyncState, R, QAfterProperty> {
  QueryBuilder<SyncState, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<SyncState, (R, String), QAfterProperty> entityTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SyncState, (R, String?), QAfterProperty>
  lastPulledCursorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<SyncState, (R, DateTime?), QAfterProperty>
  lastPulledAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension SyncStateQueryProperty3<R1, R2>
    on QueryBuilder<SyncState, (R1, R2), QAfterProperty> {
  QueryBuilder<SyncState, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<SyncState, (R1, R2, String), QOperations> entityTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SyncState, (R1, R2, String?), QOperations>
  lastPulledCursorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<SyncState, (R1, R2, DateTime?), QOperations>
  lastPulledAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}
