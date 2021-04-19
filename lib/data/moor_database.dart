import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 50)();
}

@UseMoor(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true)));

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
    Selectable selectable = customSelect(
        "SELECT * FROM tasks WHERE id = $_id ORDER BY id DESC;",
        readsFrom: {tasks});
    List<QueryRow> _queryList = (await selectable.get() as List<QueryRow>);
    if (_queryList.isEmpty) return null;
    Map<String, dynamic> _jsonData = _queryList.first.data;
    return Task(id: _jsonData["id"], name: _jsonData["name"]);
  }

  Future<int> getNextID() async {
    Selectable selectable =
        customSelect("SELECT MAX(id) FROM tasks;", readsFrom: {tasks});
    List<QueryRow> _queryList = (await selectable.get() as List<QueryRow>);
    if (_queryList.isEmpty) return 1;
    Map<String, dynamic> _jsonData = _queryList.first.data;
    return _jsonData["MAX(id)"] + 1;
  }

  Future insertTask(Task task) => into(tasks).insertOnConflictUpdate(task);

  Future updateTask(Task task) => update(tasks).replace(task);

  Future deleteTask(Task task) => delete(tasks).delete(task);
}
