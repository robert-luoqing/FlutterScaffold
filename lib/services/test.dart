import 'package:dio/dio.dart';
import '../common/core/httpClient.dart';

import 'core/fetchPolicy.dart';

Stream<List<String>?> getRooms(String roomName) {
  return FetchPolicy().fetch(localFetch: () async {
    List<String> result = [];
    return result;
  }, onlineFetch: (setCancelToken) async {
    CancelToken token = CancelToken();
    // 用于用户cancel后进行取消
    setCancelToken(token);
    var result = await SPHttpClient().getJSON("/rooms", cancelToken: token);
    // Save to db
    return result;
  });
}
