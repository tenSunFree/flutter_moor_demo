import 'dart:async';
import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

@DataClassName('LoginEntity')
class LoginTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get email => text()();

  TextColumn get password => text()();
}

@UseMoor(tables: [LoginTable])
class Database extends _$Database {
  Database()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(onCreate: (Migrator m) => m.createAll());

  Stream<LoginEntity> watchLoginEntityStream(LoginEntity entity) =>
      select(loginTable)
          .watch()
          .map((rows) => rows.map((row) => row).toList().last);

  Future insertLoginEntity(LoginTableCompanion companion) =>
      into(loginTable).insert(companion);
}
