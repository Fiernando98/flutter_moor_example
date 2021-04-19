import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'moor_database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 50)();
/*
  @override
  List<String> get customConstraints => [
        'FOREIGN KEY(user_a) REFERENCES users(id)',
        'FOREIGN KEY(user_b) REFERENCES users(id)'
      ];*/
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory dbFolder = await getApplicationDocumentsDirectory();
    final File file = File(path.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(beforeOpen: (details) async {
      await this.customStatement('PRAGMA foreign_keys = ON');
    });
  }

  Future<List<Task>> getAllTasks() => select(tasks).get();

  Stream<List<Task>> watchAllTasks() => select(tasks).watch();

  Future<Task?> getTask(final int _id) async {
    try {
      Selectable selectable = customSelect(
          "SELECT * FROM tasks WHERE id = $_id ORDER BY id DESC;",
          readsFrom: {tasks});
      List<QueryRow> _queryList = (await selectable.get() as List<QueryRow>);
      if (_queryList.isEmpty) return null;
      Map<String, dynamic> _jsonData = _queryList.first.data;
      return Task(id: _jsonData["id"], name: _jsonData["name"]);
    } on Exception {}
  }

  Future<int> getNextID() async {
    try {
      Selectable selectable =
          customSelect("SELECT MAX(id) FROM tasks;", readsFrom: {tasks});
      List<QueryRow> _queryList = (await selectable.get() as List<QueryRow>);
      if (_queryList.isEmpty) return 1;
      Map<String, dynamic> _jsonData = _queryList.first.data;
      return (_jsonData["MAX(id)"] ?? 0) + 1;
    } on Exception {
      return 1;
    }
  }

  Future insertTask(Task task) => into(tasks).insertOnConflictUpdate(task);

  Future updateTask(Task task) => update(tasks).replace(task);

  Future deleteTask(Task task) => delete(tasks).delete(task);
}
