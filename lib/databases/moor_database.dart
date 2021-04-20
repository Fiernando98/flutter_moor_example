import 'dart:io';

import 'package:flutter_moor_example/databases/tables/ratings_database.dart';
import 'package:flutter_moor_example/databases/tables/students_database.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'moor_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory dbFolder = await getApplicationDocumentsDirectory();
    final File file = File(path.join(dbFolder.path, 'db.sqlite_school'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Students, Ratings], daos: [StudentDao, RatingDao])
class SchoolDatabase extends _$SchoolDatabase {
  SchoolDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(beforeOpen: (details) async {
      await this.customStatement('PRAGMA foreign_keys = ON');
    });
  }
}

@UseDao(tables: [Students])
class StudentDao extends DatabaseAccessor<SchoolDatabase>
    with _$StudentDaoMixin {
  final SchoolDatabase db;

  StudentDao(this.db) : super(db);

  Stream<List<Student>> watchAllStudents() => select(students).watch();

  Future<Student> getStudent(final int id) =>
      (select(students)..where((student) => student.id.equals(id))).getSingle();

  Future<int> getNextID() async {
    try {
      Selectable selectable =
          customSelect("SELECT MAX(id) FROM students;", readsFrom: {students});
      List<QueryRow> _queryList = (await selectable.get() as List<QueryRow>);
      if (_queryList.isEmpty) return 1;
      Map<String, dynamic> _jsonData = _queryList.first.data;
      return (_jsonData["MAX(id)"] ?? 0) + 1;
    } on Exception {
      return 1;
    }
  }

  Future insertStudent(Student student) =>
      into(students).insertOnConflictUpdate(student);

  Future updateStudent(Student student) => update(students).replace(student);

  Future deleteStudent(Student student) => delete(students).delete(student);
}

@UseDao(tables: [Students, Ratings])
class RatingDao extends DatabaseAccessor<SchoolDatabase> with _$RatingDaoMixin {
  final SchoolDatabase db;

  RatingDao(this.db) : super(db);

  Stream<List<Rating>> watchStudentRatings(final int idStudent) =>
      (select(ratings)..where((rating) => rating.idStudent.equals(idStudent)))
          .watch();

  Future<Rating> getRating(final int id) =>
      (select(ratings)..where((rating) => rating.id.equals(id))).getSingle();

  Future<List<Rating>> getRatingsByStudent(final int idStudent) =>
      (select(ratings)..where((rating) => rating.idStudent.equals(idStudent)))
          .get();

  Future<int> getNextID() async {
    try {
      Selectable selectable =
          customSelect("SELECT MAX(id) FROM ratings;", readsFrom: {ratings});
      List<QueryRow> _queryList = (await selectable.get() as List<QueryRow>);
      if (_queryList.isEmpty) return 1;
      Map<String, dynamic> _jsonData = _queryList.first.data;
      return (_jsonData["MAX(id)"] ?? 0) + 1;
    } on Exception {
      return 1;
    }
  }

  Future insertRating(Rating rating) =>
      into(ratings).insertOnConflictUpdate(rating);

  Future updateRating(Rating rating) => update(ratings).replace(rating);

  Future deleteRating(Rating rating) => delete(ratings).delete(rating);
}
