// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Student extends DataClass implements Insertable<Student> {
  final int id;
  final String firstName;
  final String lastName;

  Student({required this.id, required this.firstName, required this.lastName});

  factory Student.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Student(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      firstName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name'])!,
      lastName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name'])!,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
    );
  }

  factory Student.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Student(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
    };
  }

  Student copyWith({int? id, String? firstName, String? lastName}) => Student(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );

  @override
  String toString() {
    return (StringBuffer('Student(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(firstName.hashCode, lastName.hashCode)));

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Student &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName);
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;

  const StudentsCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
  });

  StudentsCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
  })  : firstName = Value(firstName),
        lastName = Value(lastName);

  static Insertable<Student> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
    });
  }

  StudentsCompanion copyWith(
      {Value<int>? id, Value<String>? firstName, Value<String>? lastName}) {
    return StudentsCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName')
          ..write(')'))
        .toString();
  }
}

class $StudentsTable extends Students with TableInfo<$StudentsTable, Student> {
  final GeneratedDatabase _db;
  final String? _alias;

  $StudentsTable(this._db, [this._alias]);

  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();

  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  @override
  late final GeneratedTextColumn firstName = _constructFirstName();

  GeneratedTextColumn _constructFirstName() {
    return GeneratedTextColumn('first_name', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  @override
  late final GeneratedTextColumn lastName = _constructLastName();

  GeneratedTextColumn _constructLastName() {
    return GeneratedTextColumn('last_name', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  @override
  List<GeneratedColumn> get $columns => [id, firstName, lastName];

  @override
  $StudentsTable get asDslTable => this;

  @override
  String get $tableName => _alias ?? 'students';
  @override
  final String actualTableName = 'students';

  @override
  VerificationContext validateIntegrity(Insertable<Student> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  Student map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Student.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(_db, alias);
  }
}

class Rating extends DataClass implements Insertable<Rating> {
  final int id;
  final int? idStudent;
  final double rating;
  final DateTime? dateTimeCreated;

  Rating(
      {required this.id,
      this.idStudent,
      required this.rating,
      this.dateTimeCreated});

  factory Rating.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Rating(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      idStudent:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_student']),
      rating:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}rating'])!,
      dateTimeCreated: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_time_created']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || idStudent != null) {
      map['id_student'] = Variable<int?>(idStudent);
    }
    map['rating'] = Variable<double>(rating);
    if (!nullToAbsent || dateTimeCreated != null) {
      map['date_time_created'] = Variable<DateTime?>(dateTimeCreated);
    }
    return map;
  }

  RatingsCompanion toCompanion(bool nullToAbsent) {
    return RatingsCompanion(
      id: Value(id),
      idStudent: idStudent == null && nullToAbsent
          ? const Value.absent()
          : Value(idStudent),
      rating: Value(rating),
      dateTimeCreated: dateTimeCreated == null && nullToAbsent
          ? const Value.absent()
          : Value(dateTimeCreated),
    );
  }

  factory Rating.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Rating(
      id: serializer.fromJson<int>(json['id']),
      idStudent: serializer.fromJson<int?>(json['idStudent']),
      rating: serializer.fromJson<double>(json['rating']),
      dateTimeCreated: serializer.fromJson<DateTime?>(json['dateTimeCreated']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idStudent': serializer.toJson<int?>(idStudent),
      'rating': serializer.toJson<double>(rating),
      'dateTimeCreated': serializer.toJson<DateTime?>(dateTimeCreated),
    };
  }

  Rating copyWith(
          {int? id,
          int? idStudent,
          double? rating,
          DateTime? dateTimeCreated}) =>
      Rating(
        id: id ?? this.id,
        idStudent: idStudent ?? this.idStudent,
        rating: rating ?? this.rating,
        dateTimeCreated: dateTimeCreated ?? this.dateTimeCreated,
      );

  @override
  String toString() {
    return (StringBuffer('Rating(')
          ..write('id: $id, ')
          ..write('idStudent: $idStudent, ')
          ..write('rating: $rating, ')
          ..write('dateTimeCreated: $dateTimeCreated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(idStudent.hashCode,
          $mrjc(rating.hashCode, dateTimeCreated.hashCode))));

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Rating &&
          other.id == this.id &&
          other.idStudent == this.idStudent &&
          other.rating == this.rating &&
          other.dateTimeCreated == this.dateTimeCreated);
}

class RatingsCompanion extends UpdateCompanion<Rating> {
  final Value<int> id;
  final Value<int?> idStudent;
  final Value<double> rating;
  final Value<DateTime?> dateTimeCreated;

  const RatingsCompanion({
    this.id = const Value.absent(),
    this.idStudent = const Value.absent(),
    this.rating = const Value.absent(),
    this.dateTimeCreated = const Value.absent(),
  });

  RatingsCompanion.insert({
    this.id = const Value.absent(),
    this.idStudent = const Value.absent(),
    required double rating,
    this.dateTimeCreated = const Value.absent(),
  }) : rating = Value(rating);

  static Insertable<Rating> custom({
    Expression<int>? id,
    Expression<int?>? idStudent,
    Expression<double>? rating,
    Expression<DateTime?>? dateTimeCreated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idStudent != null) 'id_student': idStudent,
      if (rating != null) 'rating': rating,
      if (dateTimeCreated != null) 'date_time_created': dateTimeCreated,
    });
  }

  RatingsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? idStudent,
      Value<double>? rating,
      Value<DateTime?>? dateTimeCreated}) {
    return RatingsCompanion(
      id: id ?? this.id,
      idStudent: idStudent ?? this.idStudent,
      rating: rating ?? this.rating,
      dateTimeCreated: dateTimeCreated ?? this.dateTimeCreated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idStudent.present) {
      map['id_student'] = Variable<int?>(idStudent.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (dateTimeCreated.present) {
      map['date_time_created'] = Variable<DateTime?>(dateTimeCreated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RatingsCompanion(')
          ..write('id: $id, ')
          ..write('idStudent: $idStudent, ')
          ..write('rating: $rating, ')
          ..write('dateTimeCreated: $dateTimeCreated')
          ..write(')'))
        .toString();
  }
}

class $RatingsTable extends Ratings with TableInfo<$RatingsTable, Rating> {
  final GeneratedDatabase _db;
  final String? _alias;

  $RatingsTable(this._db, [this._alias]);

  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();

  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _idStudentMeta = const VerificationMeta('idStudent');
  @override
  late final GeneratedIntColumn idStudent = _constructIdStudent();

  GeneratedIntColumn _constructIdStudent() {
    return GeneratedIntColumn('id_student', $tableName, true,
        $customConstraints: 'NULLABLE REFERENCES students(id)');
  }

  final VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedRealColumn rating = _constructRating();

  GeneratedRealColumn _constructRating() {
    return GeneratedRealColumn(
      'rating',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateTimeCreatedMeta =
      const VerificationMeta('dateTimeCreated');
  @override
  late final GeneratedDateTimeColumn dateTimeCreated =
      _constructDateTimeCreated();

  GeneratedDateTimeColumn _constructDateTimeCreated() {
    return GeneratedDateTimeColumn(
      'date_time_created',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, idStudent, rating, dateTimeCreated];

  @override
  $RatingsTable get asDslTable => this;

  @override
  String get $tableName => _alias ?? 'ratings';
  @override
  final String actualTableName = 'ratings';

  @override
  VerificationContext validateIntegrity(Insertable<Rating> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_student')) {
      context.handle(_idStudentMeta,
          idStudent.isAcceptableOrUnknown(data['id_student']!, _idStudentMeta));
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('date_time_created')) {
      context.handle(
          _dateTimeCreatedMeta,
          dateTimeCreated.isAcceptableOrUnknown(
              data['date_time_created']!, _dateTimeCreatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  Rating map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Rating.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $RatingsTable createAlias(String alias) {
    return $RatingsTable(_db, alias);
  }
}

abstract class _$SchoolDatabase extends GeneratedDatabase {
  _$SchoolDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $StudentsTable students = $StudentsTable(this);
  late final $RatingsTable ratings = $RatingsTable(this);
  late final StudentDao studentDao = StudentDao(this as SchoolDatabase);
  late final RatingDao ratingDao = RatingDao(this as SchoolDatabase);

  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [students, ratings];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$StudentDaoMixin on DatabaseAccessor<SchoolDatabase> {
  $StudentsTable get students => attachedDatabase.students;
}
mixin _$RatingDaoMixin on DatabaseAccessor<SchoolDatabase> {
  $StudentsTable get students => attachedDatabase.students;

  $RatingsTable get ratings => attachedDatabase.ratings;
}
