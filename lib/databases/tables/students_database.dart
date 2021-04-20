import 'package:moor/moor.dart';

class Students extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get firstName => text().withLength(min: 1, max: 100)();

  TextColumn get lastName => text().withLength(min: 1, max: 100)();
}
