// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diploma.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDiplomaCollection on Isar {
  IsarCollection<Diploma> get diplomas => this.collection();
}

const DiplomaSchema = CollectionSchema(
  name: r'Diploma',
  id: 1212486388485935696,
  properties: {
    r'dateIssued': PropertySchema(
      id: 0,
      name: r'dateIssued',
      type: IsarType.dateTime,
    ),
    r'degreeTitle': PropertySchema(
      id: 1,
      name: r'degreeTitle',
      type: IsarType.string,
    ),
    r'institutionName': PropertySchema(
      id: 2,
      name: r'institutionName',
      type: IsarType.string,
    ),
    r'qrData': PropertySchema(
      id: 3,
      name: r'qrData',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 4,
      name: r'status',
      type: IsarType.string,
    ),
    r'studentName': PropertySchema(
      id: 5,
      name: r'studentName',
      type: IsarType.string,
    ),
    r'uid': PropertySchema(
      id: 6,
      name: r'uid',
      type: IsarType.string,
    )
  },
  estimateSize: _diplomaEstimateSize,
  serialize: _diplomaSerialize,
  deserialize: _diplomaDeserialize,
  deserializeProp: _diplomaDeserializeProp,
  idName: r'id',
  indexes: {
    r'uid': IndexSchema(
      id: 8193695471701937315,
      name: r'uid',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'uid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'status': IndexSchema(
      id: -107785170620420283,
      name: r'status',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'status',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _diplomaGetId,
  getLinks: _diplomaGetLinks,
  attach: _diplomaAttach,
  version: '3.1.0+1',
);

int _diplomaEstimateSize(
  Diploma object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.degreeTitle.length * 3;
  bytesCount += 3 + object.institutionName.length * 3;
  bytesCount += 3 + object.qrData.length * 3;
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.studentName.length * 3;
  bytesCount += 3 + object.uid.length * 3;
  return bytesCount;
}

void _diplomaSerialize(
  Diploma object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dateIssued);
  writer.writeString(offsets[1], object.degreeTitle);
  writer.writeString(offsets[2], object.institutionName);
  writer.writeString(offsets[3], object.qrData);
  writer.writeString(offsets[4], object.status);
  writer.writeString(offsets[5], object.studentName);
  writer.writeString(offsets[6], object.uid);
}

Diploma _diplomaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Diploma();
  object.dateIssued = reader.readDateTime(offsets[0]);
  object.degreeTitle = reader.readString(offsets[1]);
  object.id = id;
  object.institutionName = reader.readString(offsets[2]);
  object.qrData = reader.readString(offsets[3]);
  object.status = reader.readString(offsets[4]);
  object.studentName = reader.readString(offsets[5]);
  object.uid = reader.readString(offsets[6]);
  return object;
}

P _diplomaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _diplomaGetId(Diploma object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _diplomaGetLinks(Diploma object) {
  return [];
}

void _diplomaAttach(IsarCollection<dynamic> col, Id id, Diploma object) {
  object.id = id;
}

extension DiplomaByIndex on IsarCollection<Diploma> {
  Future<Diploma?> getByUid(String uid) {
    return getByIndex(r'uid', [uid]);
  }

  Diploma? getByUidSync(String uid) {
    return getByIndexSync(r'uid', [uid]);
  }

  Future<bool> deleteByUid(String uid) {
    return deleteByIndex(r'uid', [uid]);
  }

  bool deleteByUidSync(String uid) {
    return deleteByIndexSync(r'uid', [uid]);
  }

  Future<List<Diploma?>> getAllByUid(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uid', values);
  }

  List<Diploma?> getAllByUidSync(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uid', values);
  }

  Future<int> deleteAllByUid(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uid', values);
  }

  int deleteAllByUidSync(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uid', values);
  }

  Future<Id> putByUid(Diploma object) {
    return putByIndex(r'uid', object);
  }

  Id putByUidSync(Diploma object, {bool saveLinks = true}) {
    return putByIndexSync(r'uid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUid(List<Diploma> objects) {
    return putAllByIndex(r'uid', objects);
  }

  List<Id> putAllByUidSync(List<Diploma> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'uid', objects, saveLinks: saveLinks);
  }
}

extension DiplomaQueryWhereSort on QueryBuilder<Diploma, Diploma, QWhere> {
  QueryBuilder<Diploma, Diploma, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DiplomaQueryWhere on QueryBuilder<Diploma, Diploma, QWhereClause> {
  QueryBuilder<Diploma, Diploma, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterWhereClause> uidEqualTo(String uid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uid',
        value: [uid],
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterWhereClause> uidNotEqualTo(String uid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uid',
              lower: [],
              upper: [uid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uid',
              lower: [uid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uid',
              lower: [uid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uid',
              lower: [],
              upper: [uid],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterWhereClause> statusEqualTo(
      String status) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'status',
        value: [status],
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterWhereClause> statusNotEqualTo(
      String status) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [],
              upper: [status],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [status],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [status],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [],
              upper: [status],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DiplomaQueryFilter
    on QueryBuilder<Diploma, Diploma, QFilterCondition> {
  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> dateIssuedEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateIssued',
        value: value,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> dateIssuedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateIssued',
        value: value,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> dateIssuedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateIssued',
        value: value,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> dateIssuedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateIssued',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> degreeTitleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'degreeTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> degreeTitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'degreeTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> degreeTitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'degreeTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> degreeTitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'degreeTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> degreeTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'degreeTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> degreeTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'degreeTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> degreeTitleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'degreeTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> degreeTitleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'degreeTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> degreeTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'degreeTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition>
      degreeTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'degreeTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> institutionNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'institutionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition>
      institutionNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'institutionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> institutionNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'institutionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> institutionNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'institutionName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition>
      institutionNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'institutionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> institutionNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'institutionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> institutionNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'institutionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> institutionNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'institutionName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition>
      institutionNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'institutionName',
        value: '',
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition>
      institutionNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'institutionName',
        value: '',
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> qrDataEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qrData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> qrDataGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'qrData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> qrDataLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'qrData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> qrDataBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'qrData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> qrDataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'qrData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> qrDataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'qrData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> qrDataContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'qrData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> qrDataMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'qrData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> qrDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qrData',
        value: '',
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> qrDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'qrData',
        value: '',
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> statusContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> studentNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'studentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> studentNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'studentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> studentNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'studentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> studentNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'studentName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> studentNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'studentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> studentNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'studentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> studentNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'studentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> studentNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'studentName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> studentNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'studentName',
        value: '',
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition>
      studentNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'studentName',
        value: '',
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> uidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> uidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> uidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> uidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> uidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> uidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> uidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> uidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterFilterCondition> uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uid',
        value: '',
      ));
    });
  }
}

extension DiplomaQueryObject
    on QueryBuilder<Diploma, Diploma, QFilterCondition> {}

extension DiplomaQueryLinks
    on QueryBuilder<Diploma, Diploma, QFilterCondition> {}

extension DiplomaQuerySortBy on QueryBuilder<Diploma, Diploma, QSortBy> {
  QueryBuilder<Diploma, Diploma, QAfterSortBy> sortByDateIssued() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateIssued', Sort.asc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> sortByDateIssuedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateIssued', Sort.desc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> sortByDegreeTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'degreeTitle', Sort.asc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> sortByDegreeTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'degreeTitle', Sort.desc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> sortByInstitutionName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institutionName', Sort.asc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> sortByInstitutionNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institutionName', Sort.desc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> sortByQrData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrData', Sort.asc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> sortByQrDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrData', Sort.desc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> sortByStudentName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studentName', Sort.asc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> sortByStudentNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studentName', Sort.desc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }
}

extension DiplomaQuerySortThenBy
    on QueryBuilder<Diploma, Diploma, QSortThenBy> {
  QueryBuilder<Diploma, Diploma, QAfterSortBy> thenByDateIssued() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateIssued', Sort.asc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> thenByDateIssuedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateIssued', Sort.desc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> thenByDegreeTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'degreeTitle', Sort.asc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> thenByDegreeTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'degreeTitle', Sort.desc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> thenByInstitutionName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institutionName', Sort.asc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> thenByInstitutionNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institutionName', Sort.desc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> thenByQrData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrData', Sort.asc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> thenByQrDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrData', Sort.desc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> thenByStudentName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studentName', Sort.asc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> thenByStudentNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studentName', Sort.desc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<Diploma, Diploma, QAfterSortBy> thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }
}

extension DiplomaQueryWhereDistinct
    on QueryBuilder<Diploma, Diploma, QDistinct> {
  QueryBuilder<Diploma, Diploma, QDistinct> distinctByDateIssued() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateIssued');
    });
  }

  QueryBuilder<Diploma, Diploma, QDistinct> distinctByDegreeTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'degreeTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Diploma, Diploma, QDistinct> distinctByInstitutionName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'institutionName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Diploma, Diploma, QDistinct> distinctByQrData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qrData', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Diploma, Diploma, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Diploma, Diploma, QDistinct> distinctByStudentName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'studentName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Diploma, Diploma, QDistinct> distinctByUid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid', caseSensitive: caseSensitive);
    });
  }
}

extension DiplomaQueryProperty
    on QueryBuilder<Diploma, Diploma, QQueryProperty> {
  QueryBuilder<Diploma, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Diploma, DateTime, QQueryOperations> dateIssuedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateIssued');
    });
  }

  QueryBuilder<Diploma, String, QQueryOperations> degreeTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'degreeTitle');
    });
  }

  QueryBuilder<Diploma, String, QQueryOperations> institutionNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'institutionName');
    });
  }

  QueryBuilder<Diploma, String, QQueryOperations> qrDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qrData');
    });
  }

  QueryBuilder<Diploma, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<Diploma, String, QQueryOperations> studentNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'studentName');
    });
  }

  QueryBuilder<Diploma, String, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }
}
