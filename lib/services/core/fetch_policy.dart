import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../common/utils/net_util.dart';

///
/// 该类用于获取数据的规则
///
typedef FetchMethod<T> = Future<T?> Function();
typedef FetchSetCancelTokenMethod = void Function(CancelToken cancelToken);
typedef OnlineFetchMethod<T> = Future<T> Function(
    FetchSetCancelTokenMethod setCancelToken);
typedef OnlineFetchMethod2<T> = Future<OnlineFetchResult<T>> Function();

class OnlineFetchResult<T> {
  T? data;
  bool isEqual;
  OnlineFetchResult({this.data, this.isEqual = false});
}

class FetchPolicy {
  static FetchPolicy? _cache;
  factory FetchPolicy() {
    _cache ??= FetchPolicy._internal();
    return _cache!;
  }

  FetchPolicy._internal();

  ///
  /// 调用方式
  /// Stream<List<String>> getRooms(String roomName) {
  ///   return FetchPolicy().fetch(localFetch: () async {
  ///     List<String> result = [];
  ///     return result;
  ///   }, onlineFetch: (setCancelToken) async {
  ///     CancelToken token = CancelToken();
  ///     // 用于用户cancel后进行取消
  ///     setCancelToken(token);
  ///     var result = await HttpClient().getJSON("/rooms", null, cancelToken: token);
  ///     // Save to db
  ///     return result;
  ///   });
  /// }
  Stream<T?> fetch<T>(
      {FetchMethod<T>? localFetch, OnlineFetchMethod<T>? onlineFetch}) {
    StreamController<T?> controller = StreamController<T?>();
    CancelToken? currentCancelToken;
    controller.onCancel = () {
      if (currentCancelToken != null &&
          currentCancelToken!.isCancelled == false) {
        currentCancelToken!.cancel();
      }
      controller.close();
    };

    controller.onListen = () async {
      var sink = controller.sink;
      try {
        if (localFetch != null) {
          var localResult = await localFetch();
          sink.add(localResult);
        }
        var isOnline = await NetUtil().isOnline();
        if (onlineFetch != null && isOnline) {
          var netResult = await onlineFetch((CancelToken cancelToken) {
            currentCancelToken = cancelToken;
          });
          sink.add(netResult);
        }
      } catch (e, s) {
        sink.addError(e, s);
        sink.close();
        controller.close();
      } finally {
        sink.close();
        controller.close();
      }
    };

    return controller.stream;
  }

  Stream<T?> fetchWithNoCancel<T>(
      {FetchMethod<T>? localFetch, OnlineFetchMethod2<T>? onlineFetch}) async* {
    try {
      if (localFetch != null) {
        var localResult = await localFetch();
        yield localResult;
      }
      var isOnline = await NetUtil().isOnline();
      if (onlineFetch != null && isOnline) {
        var netResult = await onlineFetch();
        // 如果cache和Net是一样的数据，则不再出送
        if (!netResult.isEqual) {
          yield netResult.data;
        }
      }
    } catch (e, s) {
      if (kDebugMode) {
        print("fetchWithNoCancel $e, $s");
      }
      rethrow;
    }
  }
}
