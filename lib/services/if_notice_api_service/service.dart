import 'dart:convert';

import 'package:if_noticies/entities/notice.dart';
import 'package:http/http.dart' as http;
import 'package:if_noticies/services/if_notice_api_service/constants.dart';

class IFNoticeApiService {
  static Uri _urlBuilder([Map<String, dynamic>? queryParameters]) {
    return Uri.http(
      IFNoticeApiUrls.baseUrl,
      '/noticias/',
      queryParameters,
    );
  }

  Future<List<Notice>> findAll({
    List<String> campus = const [],
    int? lastId,
    int? limit = 20,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {'campus': campus};
      if (lastId != null) {
        queryParameters['lastId'] = lastId.toString();
      }

      if (limit != null) {
        queryParameters['limit'] = limit.toString();
      }

      Uri url = IFNoticeApiService._urlBuilder(queryParameters);

      var response = await http.get(url);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        List posts = jsonDecode(response.body);

        return posts.map((post) => Notice.fromJson(post)).toList();
      } else {
        throw Exception('Request to noticies failed');
      }
    } catch (e) {
      throw Exception('Internal Server Error');
    }
  }
}
