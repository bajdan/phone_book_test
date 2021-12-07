import 'package:drift/drift.dart';

class ContactsTable extends Table {
  DateTimeColumn get createdAt => dateTime()();

  TextColumn get name => text()();

  TextColumn get avatar => text()();

  IntColumn get id => integer()();

  Set<Column> get primaryKey => {id};
}
