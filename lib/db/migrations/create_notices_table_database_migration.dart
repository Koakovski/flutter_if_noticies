// ignore_for_file: annotate_overrides
import 'package:if_noticies/db/interfaces/database_migration.dart';
import 'package:sqflite/sqflite.dart';

class CreateNoticesTableDatabaseMigration implements DatabaseMigration {
  String get name => 'Create notices table';
  int get version => 1;

  Future<void> execute(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS notices (
        id_site INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        subtitle TEXT,
        url TEXT,
        publication_date INTEGER,
        publication_date_string TEXT,
        campus TEXT
      );
    ''');
  }

  Future<void> rollback(Database db) async {
    await db.execute('DROP TABLE IF EXISTS notices');
  }
}
