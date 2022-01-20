import 'dart:convert';

import '../common/utils/json_util.dart';
import '../repos/global_cache_repo.dart';
import '../repos/user_cache_repo.dart';
import 'core/fetch_policy.dart';

class CacheService {
  static CacheService? _cache;
  factory CacheService() {
    _cache ??= CacheService._internal();
    return _cache!;
  }
  CacheService._internal();

  Stream<List<T>?> getAndCacheList<T>(
      {required String cacheKey,
      required T Function(Map<String, dynamic> json) fromJsonFunc,
      required Future<List<T>> Function() fetchFunc}) {
    String? cacheString;
    return FetchPolicy().fetchWithNoCancel(localFetch: () async {
      cacheString = await GlobalCacheRepo().getValue(cacheKey);
      if (cacheString != null && cacheString!.trim() != "") {
        var cacheObjs = JsonUtil()
            .toList<T>(fromJsonFunc: fromJsonFunc, jsonString: cacheString);
        return cacheObjs;
      } else {
        return null;
      }
    }, onlineFetch: () async {
      var result = await fetchFunc();
      var jsonString = JsonUtil().toJsonStringFromList(result);
      if (cacheString != jsonString) {
        await GlobalCacheRepo().setValue(cacheKey, jsonString ?? "");
        return OnlineFetchResult(data: result, isEqual: false);
      } else {
        return OnlineFetchResult(isEqual: true);
      }
    });
  }

  Stream<List<T>?> getAndCacheStringOrNumListInGlobal<T>(
      {required String cacheKey,
      required Future<List<T>?> Function() fetchFunc}) {
    String? cacheString;
    return FetchPolicy().fetchWithNoCancel(localFetch: () async {
      cacheString = await GlobalCacheRepo().getValue(cacheKey);
      if (cacheString != null && cacheString!.trim() != "") {
        List<dynamic> cacheObjs = jsonDecode(cacheString!);
        return cacheObjs.map<T>((e) => e as T).toList();
      } else {
        return null;
      }
    }, onlineFetch: () async {
      var result = await fetchFunc();
      var jsonString = "";
      if (result != null) {
        jsonString = jsonEncode(result);
      }
      if (cacheString != jsonString) {
        await GlobalCacheRepo().setValue(cacheKey, jsonString);
        return OnlineFetchResult(data: result, isEqual: false);
      } else {
        return OnlineFetchResult(isEqual: true);
      }
    });
  }

  Stream<T?> getAndCacheObjectInGlobal<T>(
      {required String cacheKey,
      required T Function(Map<String, dynamic> json) fromJsonFunc,
      required Future<T?> Function() fetchFunc}) {
    String? cacheString;
    return FetchPolicy().fetchWithNoCancel(localFetch: () async {
      cacheString = await GlobalCacheRepo().getValue(cacheKey);
      if (cacheString != null && cacheString!.trim() != "") {
        var cacheObj = fromJsonFunc(jsonDecode(cacheString!));
        return cacheObj;
      } else {
        return null;
      }
    }, onlineFetch: () async {
      var result = await fetchFunc();
      String? jsonString;
      if (result == null) {
        await GlobalCacheRepo().setValue(cacheKey, "");
      } else {
        jsonString = jsonEncode((result as dynamic).toJson());
      }

      if (cacheString != jsonString) {
        await GlobalCacheRepo().setValue(cacheKey, jsonString ?? "");
        return OnlineFetchResult(data: result, isEqual: false);
      } else {
        return OnlineFetchResult(isEqual: true);
      }
    });
  }

  Stream<String?> getAndCacheStringInGlobal(
      {required String cacheKey,
      required Future<String?> Function() fetchFunc}) {
    String? cacheString;
    return FetchPolicy().fetchWithNoCancel(localFetch: () async {
      cacheString = await GlobalCacheRepo().getValue(cacheKey);
      return cacheString;
    }, onlineFetch: () async {
      String? result = await fetchFunc();
      await GlobalCacheRepo().setValue(cacheKey, result ?? "");
      if (cacheString != result) {
        return OnlineFetchResult(data: result, isEqual: false);
      } else {
        return OnlineFetchResult(isEqual: true);
      }
    });
  }

  Stream<List<T>?> getAndCacheListInUser<T>(
      {required int userId,
      required String cacheKey,
      required T Function(Map<String, dynamic> json) fromJsonFunc,
      required Future<List<T>> Function() fetchFunc}) {
    String? cacheString;
    return FetchPolicy().fetchWithNoCancel(localFetch: () async {
      cacheString = await UserCacheRepo().getValue(userId, cacheKey);
      if (cacheString != null && cacheString!.trim() != "") {
        var cacheObjs = JsonUtil()
            .toList<T>(fromJsonFunc: fromJsonFunc, jsonString: cacheString);
        return cacheObjs;
      } else {
        return null;
      }
    }, onlineFetch: () async {
      var result = await fetchFunc();
      var jsonString = JsonUtil().toJsonStringFromList(result);

      if (cacheString != jsonString) {
        await UserCacheRepo().setValue(userId, cacheKey, jsonString ?? "");
        return OnlineFetchResult(data: result, isEqual: false);
      } else {
        return OnlineFetchResult(isEqual: true);
      }
    });
  }

  Stream<T?> getAndCacheObjectInUser<T>(
      {required int userId,
      required String cacheKey,
      required T Function(Map<String, dynamic> json) fromJsonFunc,
      required Future<T?> Function() fetchFunc}) {
    String? cacheString;
    return FetchPolicy().fetchWithNoCancel(localFetch: () async {
      cacheString = await UserCacheRepo().getValue(userId, cacheKey);
      if (cacheString != null && cacheString!.trim() != "") {
        var cacheObj = fromJsonFunc(jsonDecode(cacheString!));
        return cacheObj;
      } else {
        return null;
      }
    }, onlineFetch: () async {
      var result = await fetchFunc();
      String? jsonString;
      if (result == null) {
        await UserCacheRepo().setValue(userId, cacheKey, "");
      } else {
        jsonString = jsonEncode((result as dynamic).toJson());
      }

      if (cacheString != jsonString) {
        await UserCacheRepo().setValue(userId, cacheKey, jsonString ?? "");
        return OnlineFetchResult(data: result, isEqual: false);
      } else {
        return OnlineFetchResult(isEqual: true);
      }
    });
  }
}
