import 'package:if_noticies/db/database_service.dart';
import 'package:if_noticies/entities/notice.dart';
import 'package:sqflite/sqflite.dart';

class NoticeRepository {
  final Database _dbService = DatabaseService().db;

  Future<void> deleteAll({Transaction? tx}) async {
    DatabaseExecutor client = tx ?? _dbService;

    await client.rawQuery('DELETE FROM notices');
  }

  Future<void> createMany(
    List<Notice> notices, {
    Transaction? tx,
  }) async {
    DatabaseExecutor client = tx ?? _dbService;

    Batch batch = client.batch();

    for (var notice in notices) {
      batch.insert(
        'notices',
        {
          'id_site': notice.idSite,
          'title': notice.title,
          'subtitle': notice.subtitle,
          'url': notice.url,
          'publication_date': notice.publicationDate.millisecondsSinceEpoch,
          'publication_date_string': notice.publicationDateString,
          'campus': notice.campus,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<Notice>> findAll({List<String>? campus}) async {
    String whereClause = '';
    if (campus != null && campus.isNotEmpty) {
      String campusString = campus.map((_) => '?').join(', ');
      whereClause = 'WHERE campus IN ($campusString)';
    }

    final List<Map> persistenceAdvertisements = await _dbService.rawQuery('''
      SELECT 
        *
      FROM 
        notices
      $whereClause
    ''', campus);

    return persistenceAdvertisements.map((map) => Notice.fromDb(map)).toList();
  }
}
