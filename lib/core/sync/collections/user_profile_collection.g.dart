// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_collection.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetUserProfileCollectionCollection on Isar {
  IsarCollection<int, UserProfileCollection> get userProfileCollections =>
      this.collection();
}

final UserProfileCollectionSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'UserProfileCollection',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(name: 'uid', type: IsarType.string),
      IsarPropertySchema(name: 'name', type: IsarType.string),
      IsarPropertySchema(name: 'email', type: IsarType.string),
      IsarPropertySchema(name: 'photoUrl', type: IsarType.string),
      IsarPropertySchema(name: 'seeded', type: IsarType.bool),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'uid',
        properties: ["uid"],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, UserProfileCollection>(
    serialize: serializeUserProfileCollection,
    deserialize: deserializeUserProfileCollection,
    deserializeProperty: deserializeUserProfileCollectionProp,
  ),
  getEmbeddedSchemas: () => [],
);

@isarProtected
int serializeUserProfileCollection(
  IsarWriter writer,
  UserProfileCollection object,
) {
  IsarCore.writeString(writer, 1, object.uid);
  IsarCore.writeString(writer, 2, object.name);
  IsarCore.writeString(writer, 3, object.email);
  IsarCore.writeString(writer, 4, object.photoUrl);
  IsarCore.writeBool(writer, 5, value: object.seeded);
  return object.id;
}

@isarProtected
UserProfileCollection deserializeUserProfileCollection(IsarReader reader) {
  final object = UserProfileCollection();
  object.id = IsarCore.readId(reader);
  object.uid = IsarCore.readString(reader, 1) ?? '';
  object.name = IsarCore.readString(reader, 2) ?? '';
  object.email = IsarCore.readString(reader, 3) ?? '';
  object.photoUrl = IsarCore.readString(reader, 4) ?? '';
  object.seeded = IsarCore.readBool(reader, 5);
  return object;
}

@isarProtected
dynamic deserializeUserProfileCollectionProp(IsarReader reader, int property) {
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
      return IsarCore.readBool(reader, 5);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _UserProfileCollectionUpdate {
  bool call({
    required int id,
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    bool? seeded,
  });
}

class _UserProfileCollectionUpdateImpl implements _UserProfileCollectionUpdate {
  const _UserProfileCollectionUpdateImpl(this.collection);

  final IsarCollection<int, UserProfileCollection> collection;

  @override
  bool call({
    required int id,
    Object? uid = ignore,
    Object? name = ignore,
    Object? email = ignore,
    Object? photoUrl = ignore,
    Object? seeded = ignore,
  }) {
    return collection.updateProperties(
          [id],
          {
            if (uid != ignore) 1: uid as String?,
            if (name != ignore) 2: name as String?,
            if (email != ignore) 3: email as String?,
            if (photoUrl != ignore) 4: photoUrl as String?,
            if (seeded != ignore) 5: seeded as bool?,
          },
        ) >
        0;
  }
}

sealed class _UserProfileCollectionUpdateAll {
  int call({
    required List<int> id,
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    bool? seeded,
  });
}

class _UserProfileCollectionUpdateAllImpl
    implements _UserProfileCollectionUpdateAll {
  const _UserProfileCollectionUpdateAllImpl(this.collection);

  final IsarCollection<int, UserProfileCollection> collection;

  @override
  int call({
    required List<int> id,
    Object? uid = ignore,
    Object? name = ignore,
    Object? email = ignore,
    Object? photoUrl = ignore,
    Object? seeded = ignore,
  }) {
    return collection.updateProperties(id, {
      if (uid != ignore) 1: uid as String?,
      if (name != ignore) 2: name as String?,
      if (email != ignore) 3: email as String?,
      if (photoUrl != ignore) 4: photoUrl as String?,
      if (seeded != ignore) 5: seeded as bool?,
    });
  }
}

extension UserProfileCollectionUpdate
    on IsarCollection<int, UserProfileCollection> {
  _UserProfileCollectionUpdate get update =>
      _UserProfileCollectionUpdateImpl(this);

  _UserProfileCollectionUpdateAll get updateAll =>
      _UserProfileCollectionUpdateAllImpl(this);
}

sealed class _UserProfileCollectionQueryUpdate {
  int call({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    bool? seeded,
  });
}

class _UserProfileCollectionQueryUpdateImpl
    implements _UserProfileCollectionQueryUpdate {
  const _UserProfileCollectionQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<UserProfileCollection> query;
  final int? limit;

  @override
  int call({
    Object? uid = ignore,
    Object? name = ignore,
    Object? email = ignore,
    Object? photoUrl = ignore,
    Object? seeded = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (uid != ignore) 1: uid as String?,
      if (name != ignore) 2: name as String?,
      if (email != ignore) 3: email as String?,
      if (photoUrl != ignore) 4: photoUrl as String?,
      if (seeded != ignore) 5: seeded as bool?,
    });
  }
}

extension UserProfileCollectionQueryUpdate on IsarQuery<UserProfileCollection> {
  _UserProfileCollectionQueryUpdate get updateFirst =>
      _UserProfileCollectionQueryUpdateImpl(this, limit: 1);

  _UserProfileCollectionQueryUpdate get updateAll =>
      _UserProfileCollectionQueryUpdateImpl(this);
}

class _UserProfileCollectionQueryBuilderUpdateImpl
    implements _UserProfileCollectionQueryUpdate {
  const _UserProfileCollectionQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<UserProfileCollection, UserProfileCollection, QOperations>
  query;
  final int? limit;

  @override
  int call({
    Object? uid = ignore,
    Object? name = ignore,
    Object? email = ignore,
    Object? photoUrl = ignore,
    Object? seeded = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (uid != ignore) 1: uid as String?,
        if (name != ignore) 2: name as String?,
        if (email != ignore) 3: email as String?,
        if (photoUrl != ignore) 4: photoUrl as String?,
        if (seeded != ignore) 5: seeded as bool?,
      });
    } finally {
      q.close();
    }
  }
}

extension UserProfileCollectionQueryBuilderUpdate
    on QueryBuilder<UserProfileCollection, UserProfileCollection, QOperations> {
  _UserProfileCollectionQueryUpdate get updateFirst =>
      _UserProfileCollectionQueryBuilderUpdateImpl(this, limit: 1);

  _UserProfileCollectionQueryUpdate get updateAll =>
      _UserProfileCollectionQueryBuilderUpdateImpl(this);
}

extension UserProfileCollectionQueryFilter
    on
        QueryBuilder<
          UserProfileCollection,
          UserProfileCollection,
          QFilterCondition
        > {
  QueryBuilder<
    UserProfileCollection,
    UserProfileCollection,
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
    UserProfileCollection,
    UserProfileCollection,
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
    UserProfileCollection,
    UserProfileCollection,
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  idLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 0, value: value));
    });
  }

  QueryBuilder<
    UserProfileCollection,
    UserProfileCollection,
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
    UserProfileCollection,
    UserProfileCollection,
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  uidEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  uidGreaterThan(String value, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  uidGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  uidLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  uidLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  uidBetween(String lower, String upper, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  uidStartsWith(String value, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  uidEndsWith(String value, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  uidContains(String value, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  uidMatches(String pattern, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<
    UserProfileCollection,
    UserProfileCollection,
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
    UserProfileCollection,
    UserProfileCollection,
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
    UserProfileCollection,
    UserProfileCollection,
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
    UserProfileCollection,
    UserProfileCollection,
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
    UserProfileCollection,
    UserProfileCollection,
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
    UserProfileCollection,
    UserProfileCollection,
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
    UserProfileCollection,
    UserProfileCollection,
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
    UserProfileCollection,
    UserProfileCollection,
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
    UserProfileCollection,
    UserProfileCollection,
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
    UserProfileCollection,
    UserProfileCollection,
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
    UserProfileCollection,
    UserProfileCollection,
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
    UserProfileCollection,
    UserProfileCollection,
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  emailEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 3, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  emailGreaterThan(String value, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  emailGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  emailLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 3, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  emailLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  emailBetween(String lower, String upper, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  emailStartsWith(String value, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  emailEndsWith(String value, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  emailContains(String value, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  emailMatches(String pattern, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 3, value: ''),
      );
    });
  }

  QueryBuilder<
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 3, value: ''),
      );
    });
  }

  QueryBuilder<
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  photoUrlEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 4, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  photoUrlGreaterThan(String value, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  photoUrlGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  photoUrlLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 4, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  photoUrlLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  photoUrlBetween(String lower, String upper, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  photoUrlStartsWith(String value, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  photoUrlEndsWith(String value, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  photoUrlContains(String value, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  photoUrlMatches(String pattern, {bool caseSensitive = true}) {
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
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  photoUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 4, value: ''),
      );
    });
  }

  QueryBuilder<
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  photoUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 4, value: ''),
      );
    });
  }

  QueryBuilder<
    UserProfileCollection,
    UserProfileCollection,
    QAfterFilterCondition
  >
  seededEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 5, value: value),
      );
    });
  }
}

extension UserProfileCollectionQueryObject
    on
        QueryBuilder<
          UserProfileCollection,
          UserProfileCollection,
          QFilterCondition
        > {}

extension UserProfileCollectionQuerySortBy
    on QueryBuilder<UserProfileCollection, UserProfileCollection, QSortBy> {
  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  sortByUid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  sortByUidDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  sortByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  sortByNameDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  sortByEmail({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  sortByEmailDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  sortByPhotoUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  sortByPhotoUrlDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  sortBySeeded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  sortBySeededDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }
}

extension UserProfileCollectionQuerySortThenBy
    on QueryBuilder<UserProfileCollection, UserProfileCollection, QSortThenBy> {
  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  thenByUid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  thenByUidDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  thenByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  thenByNameDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  thenByEmail({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  thenByEmailDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  thenByPhotoUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  thenByPhotoUrlDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  thenBySeeded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterSortBy>
  thenBySeededDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }
}

extension UserProfileCollectionQueryWhereDistinct
    on QueryBuilder<UserProfileCollection, UserProfileCollection, QDistinct> {
  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterDistinct>
  distinctByUid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterDistinct>
  distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterDistinct>
  distinctByEmail({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterDistinct>
  distinctByPhotoUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileCollection, UserProfileCollection, QAfterDistinct>
  distinctBySeeded() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }
}

extension UserProfileCollectionQueryProperty1
    on QueryBuilder<UserProfileCollection, UserProfileCollection, QProperty> {
  QueryBuilder<UserProfileCollection, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<UserProfileCollection, String, QAfterProperty> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<UserProfileCollection, String, QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<UserProfileCollection, String, QAfterProperty> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<UserProfileCollection, String, QAfterProperty>
  photoUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<UserProfileCollection, bool, QAfterProperty> seededProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}

extension UserProfileCollectionQueryProperty2<R>
    on QueryBuilder<UserProfileCollection, R, QAfterProperty> {
  QueryBuilder<UserProfileCollection, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<UserProfileCollection, (R, String), QAfterProperty>
  uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<UserProfileCollection, (R, String), QAfterProperty>
  nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<UserProfileCollection, (R, String), QAfterProperty>
  emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<UserProfileCollection, (R, String), QAfterProperty>
  photoUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<UserProfileCollection, (R, bool), QAfterProperty>
  seededProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}

extension UserProfileCollectionQueryProperty3<R1, R2>
    on QueryBuilder<UserProfileCollection, (R1, R2), QAfterProperty> {
  QueryBuilder<UserProfileCollection, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<UserProfileCollection, (R1, R2, String), QOperations>
  uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<UserProfileCollection, (R1, R2, String), QOperations>
  nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<UserProfileCollection, (R1, R2, String), QOperations>
  emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<UserProfileCollection, (R1, R2, String), QOperations>
  photoUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<UserProfileCollection, (R1, R2, bool), QOperations>
  seededProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}
