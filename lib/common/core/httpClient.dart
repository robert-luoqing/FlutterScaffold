import 'package:dio/dio.dart';

class HttpClient {
  static HttpClient? _cache;

  factory HttpClient() {
    if (_cache == null) {
      _cache = HttpClient._internal();
    }
    return _cache!;
  }

  HttpClient._internal();

  Map<String, dynamic> _defaultHeaders = <String, dynamic>{};
  String host = "";

  void addDefaultHeaders(String key, String value) {
    _defaultHeaders[key] = value;
  }

  void removeAllDefaultHeaders() {
    _defaultHeaders = <String, String>{};
  }

  Future<dynamic> getJSON(String url,
      {Map<String, dynamic>? queryParameters, CancelToken? cancelToken}) async {
    //CancelToken token = CancelToken();
    var dio = Dio();
    var response = await dio.get(url,
        queryParameters: queryParameters,
        options: Options(
          headers: _getHeaders(),
        ),
        cancelToken: cancelToken);
    print(response.data.toString());
    return response.data;
  }

  Future<dynamic> postJSON(String url,
      {Map<String, dynamic>? data, CancelToken? cancelToken}) async {
    //CancelToken token = CancelToken();
    var dio = Dio();
    var response = await dio.post(url,
        data: data,
        options: Options(
          headers: _getHeaders(),
        ),
        cancelToken: cancelToken);
    print(response.data.toString());
    return response.data;
  }

  Map<String, dynamic> _getHeaders() {
    var headers = Map<String, dynamic>.from(_defaultHeaders);
    headers.putIfAbsent(Headers.contentTypeHeader, () => "application/json");
    headers.putIfAbsent("responseType", () => ResponseType.json);
    return headers;
  }
}
