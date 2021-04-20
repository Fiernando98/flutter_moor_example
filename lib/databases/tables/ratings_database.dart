import 'package:moor/moor.dart';

class Ratings extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get idStudent => integer()
      .nullable()
      .customConstraint('NULLABLE REFERENCES students(id)')();

  RealColumn get rating => real()();

  DateTimeColumn get dateTimeCreated => dateTime().nullable()();
}
