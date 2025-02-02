import 'package:if_noticies/common/campus.dart';
import 'package:if_noticies/entities/notice.dart';
import 'package:if_noticies/helpers.ts/has_internet_access.dart';
import 'package:if_noticies/services/cache_service/cache_service.dart';
import 'package:if_noticies/services/if_notice_api_service/service.dart';

class NoticeFetcherService {
  final IFNoticeApiService _iFNoticeApiService = IFNoticeApiService();
  final CacheService _cacheService = CacheService();

  Future<List<Notice>> findAll({
    List<String>? campus,
    int? lastId,
    int? limit,
  }) async {
    bool hasConnection = await hasInternetAccess();

    if (hasConnection == true) {
      return await _iFNoticeApiService.findAll(
        campus: campus,
        lastId: lastId,
        limit: limit ?? 20,
      );
    }

    return await _cacheService.recoverNoticies(
      campus: campus,
      lastId: lastId,
      limit: limit,
    );
  }

  Future<void> replaceNoticesOnCache() async {
    bool hasConnection = await hasInternetAccess();
    if (hasConnection == false) return;

    List<List<Notice>> noticesMatrix =
        await Future.wait(campus.map((c) => _iFNoticeApiService.findAll(
              campus: [c],
              limit: 50,
            )));

    List<Notice> newNotices = noticesMatrix.expand((list) => list).toList();
    await _cacheService.replaceNotices(newNotices);
  }
}
