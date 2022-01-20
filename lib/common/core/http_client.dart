import 'dart:convert' as convert;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'exception.dart';

/// 这个是调用前取一下头，比如加载token等
typedef SPHttpClientHeaderCallback = Future<Map<String, dynamic>> Function();

class SPHttpClient {
  static SPHttpClient? _cache;

  factory SPHttpClient() {
    _cache ??= SPHttpClient._internal();
    return _cache!;
  }

  SPHttpClient._internal();
  SPHttpClientHeaderCallback? onHeaderCallback;
  Map<String, dynamic> _defaultHeaders = <String, dynamic>{};
  String host = "";

  void addDefaultHeaders(String key, String value) {
    _defaultHeaders[key] = value;
  }

  void removeAllDefaultHeaders() {
    _defaultHeaders = <String, String>{};
  }

  String _constructUrl(String url) {
    if (host.endsWith("/")) {
      return "${host.substring(0, host.length - 1)}$url";
    } else {
      return "$host$url";
    }
  }

  Future<dynamic> getJSON(String url,
      {Map<String, dynamic>? queryParameters, CancelToken? cancelToken}) async {
    //CancelToken token = CancelToken();
    try {
      var dio = Dio();
      var headers = await _getHeaders();
      var response = await dio.get(_constructUrl(url),
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ),
          cancelToken: cancelToken);
      if (kDebugMode) {
        print("$url Header: $headers");
        print(url + ": " + response.data.toString());
      }
      return _convertToJSON(response.data);
    } on DioError catch (e, s) {
      if (kDebugMode) {
        print("$url getJSON Error: $e $s");
      }
      throw SPException(
          code: SPException.networkError, message: "Network Error");
    } catch (ex, sx) {
      if (kDebugMode) {
        print("$url getJSON2 Error: $ex $sx");
      }
      throw SPException(
          code: SPException.networkError, message: "Network Error");
    }
  }

  Future<dynamic> postJSON(String url,
      {Map<String, dynamic>? data, CancelToken? cancelToken}) async {
    try {
      var dio = Dio();
      var headers = await _getHeaders();
      var response = await dio.post(_constructUrl(url),
          data: data,
          options: Options(
            headers: headers,
          ),
          cancelToken: cancelToken);
      if (kDebugMode) {
        print(response.data.toString());
      }
      return _convertToJSON(response.data);
    } on DioError catch (e, s) {
      if (kDebugMode) {
        print("$url postJSON Error: $e $s");
      }
      throw SPException(
          code: SPException.networkError,
          message: "Network Error",
          stackTrace: s);
    } catch (ex, sx) {
      if (kDebugMode) {
        print("$url postJSON2 Error: $ex $sx");
      }
      throw SPException(
          code: SPException.networkError,
          message: "Network Error",
          stackTrace: sx);
    }
  }

  Future<dynamic> uploadFile(String url,
      {required File file, CancelToken? cancelToken}) async {
    try {
      var dio = Dio();
      String fileName = file.path.split('/').last;
      var headers = await _getHeaders(removeContentType: true);
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      var response = await dio.post(_constructUrl(url),
          data: formData,
          options: Options(
            headers: headers,
          ),
          cancelToken: cancelToken);
      if (kDebugMode) {
        print(response.data.toString());
      }
      return _convertToJSON(response.data);
    } on DioError catch (e, s) {
      if (kDebugMode) {
        print("$url uploadFile Error: $e $s");
      }
      throw SPException(
          code: SPException.networkError, message: "Network Error");
    } catch (ex, sx) {
      if (kDebugMode) {
        print("$url uploadFile Error: $ex $sx");
      }
      throw SPException(
          code: SPException.networkError, message: "Network Error");
    }
  }

  dynamic _convertToJSON(dynamic data) {
    if (data is String) {
      return convert.jsonDecode(data);
    } else {
      return data;
    }
  }

  Future<Map<String, dynamic>> _getHeaders(
      {bool removeContentType = false}) async {
    var headers = Map<String, dynamic>.from(_defaultHeaders);
    if (onHeaderCallback != null) {
      var cuheaders = await onHeaderCallback!();
      headers.addAll(cuheaders);
    }
    if (!removeContentType) {
      headers.putIfAbsent(Headers.contentTypeHeader, () => "application/json");
    }

    headers.putIfAbsent("responseType", () => ResponseType.json);
    return headers;
  }
}
