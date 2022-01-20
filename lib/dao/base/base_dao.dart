import 'dart:io';
import 'package:flutter/foundation.dart';

import '../../common/core/http_client.dart';
import 'package:dio/dio.dart';

class BaseDao {
  static VoidCallback? onTokenExpired;
  Future<dynamic> post(String url,
      {dynamic data, CancelToken? cancelToken}) async {
    dynamic postData;
    if (data is Map) {
      postData = data;
    } else {
      postData = data?.toJson();
    }
    if (kDebugMode) {
      print("$url, post: $postData");
    }
    var resp = await SPHttpClient()
        .postJSON(url, data: postData, cancelToken: cancelToken);

    if (resp["code"].toString() == "1") {
      return resp["data"];
    } else if (resp["code"].toString() == "-100") {
      if (onTokenExpired != null) {
        onTokenExpired!();
      }
      String msg = resp["msg"];
      throw msg;
    } else {
      String msg = resp["msg"];
      throw msg;
    }
  }

  Future<dynamic> get(String url, {CancelToken? cancelToken}) async {
    var resp = await SPHttpClient().getJSON(url, cancelToken: cancelToken);

    if (resp["code"] == 1) {
      return resp["data"];
    } else if (resp["code"].toString() == "-100") {
      if (onTokenExpired != null) {
        onTokenExpired!();
      }
      String msg = resp["msg"];
      throw msg;
    } else {
      String msg = resp["msg"];
      throw msg;
    }
  }

  Future<dynamic> upload(String url,
      {required File file, CancelToken? cancelToken}) async {
    var resp = await SPHttpClient()
        .uploadFile(url, file: file, cancelToken: cancelToken);

    if (resp["code"] == 1) {
      return resp["data"];
    } else {
      String msg = resp["msg"];
      throw msg;
    }
  }
}
