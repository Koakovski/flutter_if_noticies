import 'package:if_noticies/db/interfaces/database_migration.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseMigrationHelper {
  late Map<int, DatabaseMigration> _migrations;

  DatabaseMigrationHelper(List<DatabaseMigration> migrations) {
    _migrations = {};

    for (var migration in migrations) {
      DatabaseMigrationHelper.validateVersion(migration.version);
      if (_migrations.containsKey(migration.version)) {
        throw Exception(
          'Migration ${migration.name} has the same version as migration ${_migrations[migration.version]!.name}',
        );
      }
      _migrations[migration.version] = migration;
    }
  }

  Future<void> _executeMigrations(
    Database db, {
    int? newVersion,
    int? oldVersion,
  }) async {
    if (newVersion != null) {
      validateVersion(newVersion);
    }
    if (oldVersion != null) {
      validateVersion(oldVersion);
    }

    int startVersion = oldVersion ?? 1;
    int endVersion = newVersion ?? _maxKey;

    for (int i = startVersion; i <= endVersion; i++) {
      DatabaseMigration? migration = _migrations[i];

      if (migration == null) continue;
      print("running version ${migration.version} '${migration.name}'");

      await migration.execute(db);
    }
  }

  Future<void> _rollbackMigrations(
    Database db, {
    int? newVersion,
    int? oldVersion,
  }) async {
    if (newVersion != null) {
      validateVersion(newVersion);
    }
    if (oldVersion != null) {
      validateVersion(oldVersion);
    }

    int startVersion = oldVersion ?? _maxKey;
    int endVersion = newVersion ?? 1;

    for (int i = startVersion; i >= endVersion; i--) {
      DatabaseMigration? migration = _migrations[i];

      if (migration == null) continue;
      print("running version ${migration.version} '${migration.name}'");

      await migration.rollback(db);
    }
  }

  Future<void> create(Database db, int version) async {
    print("creating version $version");
    await _executeMigrations(db, newVersion: version);
  }

  Future<void> upgrade(Database db, int oldVersion, int newVersion) async {
    print("updagrade from version $oldVersion to $newVersion");
    await _executeMigrations(
      db,
      newVersion: newVersion,
      oldVersion: oldVersion,
    );
  }

  Future<void> downgrade(Database db, int oldVersion, int newVersion) async {
    print("downgrade from version $oldVersion to $newVersion");
    await _rollbackMigrations(
      db,
      newVersion: newVersion,
      oldVersion: oldVersion,
    );
  }

  static validateVersion(int version) {
    if (version < 0) {
      throw Exception('Migration version should be greater than 0');
    }
  }

  int get _maxKey => _migrations.keys.reduce((a, b) => a > b ? a : b);
}
