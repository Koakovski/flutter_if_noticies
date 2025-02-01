import 'package:if_noticies/common/campus.dart';
import 'package:if_noticies/entities/notice.dart';
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
    /* 
      TODO
      * usar cache apenas se n tiver internet
      * melhorar replaceNoticesOnCache para ser chamado se n houver noticis em cache
      ou tiver muito tempo q a ultima busca foi feita.
    */

    // await _replaceNoticesOnCache();
    List<Notice> notices = await _cacheService.recoverNoticies(campus: campus);
    /* List<Notice> notices = await _iFNoticeApiService.findAll(
      campus: campus,
      lastId: lastId,
      limit: limit ?? 20,
    );
    */
    return notices;
  }

  Future<void> _replaceNoticesOnCache() async {
    /* 
      fetch 20 notices of each campus
    */
    List<List<Notice>> noticesMatrix =
        await Future.wait(campus.map((c) => _iFNoticeApiService.findAll(
              campus: [c],
              limit: 20,
            )));

    List<Notice> newNotices = noticesMatrix.expand((list) => list).toList();
    await _cacheService.replaceNotices(newNotices);
  }
}
