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

  Future<List<Notice>> findAll({
    List<String>? campus,
    int? lastId,
    int? limit,
  }) async {
    List<dynamic> queryParams = [];
    List<String> conditions = [];

    if (campus != null && campus.isNotEmpty) {
      String placeholders = List.filled(campus.length, '?').join(', ');
      conditions.add('campus IN ($placeholders)');
      queryParams.addAll(campus);
    }

    if (lastId != null) {
      conditions.add('id_site > ?');
      queryParams.add(lastId);
    }

    String whereClause =
        conditions.isNotEmpty ? 'WHERE ${conditions.join(' AND ')}' : '';

    String limitClause = limit != null ? 'LIMIT ?' : '';
    if (limit != null) queryParams.add(limit);

    final List<Map<String, dynamic>> persistenceNotices =
        await _dbService.rawQuery('''
    SELECT * FROM notices
    $whereClause
    ORDER BY publication_date ASC
    $limitClause
  ''', queryParams);

    return persistenceNotices.map((map) => Notice.fromDb(map)).toList();
  }
}
