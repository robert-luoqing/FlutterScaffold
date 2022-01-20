import 'dart:convert';

import 'package:lingo_dragon/common/core/graph_ql_client.dart';
import 'package:lingo_dragon/common/utils/date_util.dart';
import 'package:lingo_dragon/models/user/login_info.dart';

import '../dao/user_dao.dart';
import '../repos/global_cache_repo.dart';

class UserService {
  static UserService? _cache;
  factory UserService() {
    _cache ??= UserService._internal();
    return _cache!;
  }
  UserService._internal();

  Future<void> sendSMS(String phone) async {
    await UserDao().sendSMS(phone);
  }

  Future<LoginInfo?> getLoginInfoFromCache() async {
    var cacheString =
        await GlobalCacheRepo().getValue(GlobalCacheRepo.keyLoginInfo);
    LoginInfo? result;
    if (cacheString != null && cacheString.trim() != "") {
      var jsonObj = jsonDecode(cacheString);
      result = LoginInfo.fromJson(jsonObj);
    }
    return result;
  }

  Future<void> saveLoginInfo(LoginInfo loginUserInfo) async {
    //存本地数据库
    String jsonString = jsonEncode(loginUserInfo.toJson());
    await GlobalCacheRepo().setValue(GlobalCacheRepo.keyLoginInfo, jsonString);
    GrahpQLClient().addDefaultHeaders("X-Token", loginUserInfo.token);
  }

  /// 如果不需要更新，则返回null, 否则返回更新后的LoginInfo, 其他情况throw error.
  Future<LoginInfo?> determinRefreshToken(LoginInfo? loginUserInfo) async {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (loginUserInfo != null && loginUserInfo.needRefreshTokenTime < now) {
      var tokenMessage = await UserDao().refreshToken(loginUserInfo.token);
      var newLoginInfo = loginUserInfo;
      newLoginInfo.token = tokenMessage.token;
      newLoginInfo.expiredTime = tokenMessage.expiredTime;

      newLoginInfo.needRefreshTokenTime = SPDateUtil()
          .getTimeByConditionBetweenTwoTime(
              now, tokenMessage.expiredTime, true);
      await saveLoginInfo(newLoginInfo);
      return newLoginInfo;
    }

    return null;
  }

  Future<LoginInfo?> verifyToken() async {
    var loginInfo = await getLoginInfoFromCache();
    int now = DateTime.now().millisecondsSinceEpoch;
    if (loginInfo == null || (loginInfo.expiredTime < now)) {
      await GlobalCacheRepo().setValue(GlobalCacheRepo.keyLoginInfo, '');
      return null;
    }

    return loginInfo;
  }

  Future<void> logout() async {
    await GlobalCacheRepo().setValue(GlobalCacheRepo.keyLoginInfo, '');
    GrahpQLClient().removeAllDefaultHeaders();
  }
}
