import 'package:if_noticies/db/database_service.dart';
import 'package:if_noticies/entities/notice.dart';
import 'package:sqflite/sqflite.dart';

class NoticeRepository {
  final Database _dbService = DatabaseService().db;

  Future<void> deleteAll({Transaction? tx}) async {
    DatabaseExecutor client = tx ?? _dbService;

    await client.rawQuery('DELETE FROM notices');
  }

  Future<List<Notice>> findAll({List<String>? campus, Transaction? tx}) async {
    DatabaseExecutor client = tx ?? _dbService;

    String whereClause = '';
    if (campus != null && campus.isNotEmpty) {
      String campusString = campus.map((_) => '?').join(', ');
      whereClause = 'WHERE campus IN ($campusString)';
    }

    final List<Map> persistenceAdvertisements = await client.rawQuery('''
      SELECT 
        *
      FROM 
        notices
      $whereClause
    ''', campus);

    return persistenceAdvertisements.map((map) => Notice.fromDb(map)).toList();
  }
}
