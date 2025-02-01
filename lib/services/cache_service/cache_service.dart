import 'package:if_noticies/db/repositories/database_transaction_repository.dart';
import 'package:if_noticies/db/repositories/notice_repository.dart';
import 'package:if_noticies/entities/notice.dart';

class CacheService {
  final DatabaseTransactionRepository databaseTransactionRepository =
      DatabaseTransactionRepository();
  final NoticeRepository noticeRepository = NoticeRepository();

  Future<List<Notice>> recoverNoticies({List<String>? campus}) async {
    return await noticeRepository.findAll(
      campus: campus,
    );
  }

  Future<void> replaceNotices(List<Notice> notices) async {
    await databaseTransactionRepository.execute((tx) async {
      await noticeRepository.deleteAll(tx: tx);
      await noticeRepository.createMany(
        notices,
        tx: tx,
      );
    });
  }
}
