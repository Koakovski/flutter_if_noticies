import 'package:if_noticies/db/database_seed.dart';
import 'package:if_noticies/db/helpers/database_migration_helper.dart';
import 'package:if_noticies/db/migrations/create_notices_table_database_migration.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Database? _db;

  static final DatabaseService _instance = DatabaseService.internal();

  factory DatabaseService() => _instance;

  DatabaseService.internal();

  Database get db {
    if (_db == null) {
      throw Exception("Database must be initialize before use it");
    }
    return _db!;
  }

  Future<void> initDb({bool reset = false, bool seed = false}) async {
    if (_db != null) return;

    final databasePath = await getDatabasesPath();
    final path = "$databasePath/database.db";

    if (reset) {
      print("_______ RESETTING DATABASE _______");
      await deleteDatabase(path);
    }

    DatabaseMigrationHelper databaseMigrationHelper = DatabaseMigrationHelper([
      CreateNoticesTableDatabaseMigration(),
    ]);

    print("_______ OPENING DATABASE _______");
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: databaseMigrationHelper.create,
      onDowngrade: databaseMigrationHelper.downgrade,
      onUpgrade: databaseMigrationHelper.upgrade,
    );
    print("_______ DATABASE OPENED _______");

    if (seed == true) {
      await DatabaseSeed.execute();
    }
  }
}
