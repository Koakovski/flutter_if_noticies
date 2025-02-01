import 'package:if_noticies/db/database_service.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseTransactionRepository {
  final Database _dbService = DatabaseService().db;

  Future<T> execute<T>(Future<T> Function(Transaction tx) func) async {
    return await _dbService.transaction((tx) async {
      return await func(tx);
    });
  }
}
