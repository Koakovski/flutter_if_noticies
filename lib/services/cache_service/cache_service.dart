import 'package:if_noticies/db/repositories/database_transaction_repository.dart';
import 'package:if_noticies/db/repositories/notice_repository.dart';
import 'package:if_noticies/entities/notice.dart';

class CacheService {
  final DatabaseTransactionRepository _databaseTransactionRepository =
      DatabaseTransactionRepository();
  final NoticeRepository _noticeRepository = NoticeRepository();

  Future<List<Notice>> recoverNoticies({
    List<String>? campus,
    int? lastId,
    int? limit,
  }) async {
    return await _noticeRepository.findAll(
      campus: campus,
      lastId: lastId,
      limit: limit,
    );
  }

  Future<void> replaceNotices(List<Notice> notices) async {
    await _databaseTransactionRepository.execute((tx) async {
      await _noticeRepository.deleteAll(tx: tx);
      await _noticeRepository.createMany(
        notices,
        tx: tx,
      );
    });
  }
}
