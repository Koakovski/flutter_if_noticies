import 'package:sqflite/sqflite.dart';

abstract class DatabaseMigration {
  String get name;
  int get version;

  Future<void> execute(Database db);

  Future<void> rollback(Database db);
}
