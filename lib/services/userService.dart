import 'dart:convert';

import '../../dao/userDao.dart';
import '../../models/user/loginReqDto.dart';
import '../../models/user/loginRespDto.dart';
import '../../models/user/userInfo.dart';
import '../../repos/globalCacheRepo.dart';
import '../../repos/userCacheRepo.dart';

import 'cacheService.dart';

class AccountService {
  static AccountService? _cache;
  factory AccountService() {
    if (_cache == null) {
      _cache = AccountService._internal();
    }
    return _cache!;
  }
  AccountService._internal();

  Future<LoginRespDto> login(LoginReqDto param) async {
    var loginResult = await UserDao().login(param);
    GlobalCacheRepo().setValue(
        GlobalCacheRepo.Key_LoginInfo, jsonEncode(loginResult.toJson()));

    return loginResult;
  }

  Future<void> forgotPassword(
      {required String mobile,
      required String yzm,
      required String newPassword}) async {
    await UserDao()
        .forgotPassword(mobile: mobile, yzm: yzm, newPassword: newPassword);
  }

  Future<void> changePassword(
      {required String password, required String newPassword}) async {
    await UserDao()
        .changePassword(password: password, newPassword: newPassword);
  }

  Stream<UserInfo?> getMyUserInfo(int myUserId) {
    return CacheService().getAndCacheObjectInUser(
        userId: myUserId,
        cacheKey: UserCacheRepo.Key_MyUserInfo,
        fromJsonFunc: (jsonObj) => UserInfo.fromJson(jsonObj),
        fetchFunc: () => UserDao().getUserInfo(myUserId));
  }

  Future<UserInfo?> getMyUserInfoFromServer(int myUserId) async {
    var userInfo = await UserDao().getUserInfo(myUserId);
    String jsonString = jsonEncode(userInfo.toJson());

    await UserCacheRepo()
        .setValue(myUserId, UserCacheRepo.Key_MyUserInfo, jsonString);
    return userInfo;
  }

  Future<UserInfo?> getMyUserInfoFromCache(int myUserId) async {
    var cacheString =
        await UserCacheRepo().getValue(myUserId, UserCacheRepo.Key_MyUserInfo);
    UserInfo? result;
    if (cacheString != null && cacheString.trim() != "") {
      var jsonObj = jsonDecode(cacheString);
      result = UserInfo.fromJson(jsonObj);
    }
    return result;
  }

  Future<void> sendSMS(String phone) async {
    await UserDao().sendSMS(phone);
  }

  Future<void> modifyMyInfo(
      {required String avatar,
      String? realname,
      int? gender,
      String? birthday,
      String? workStatus,
      String? education,
      String? profession}) async {
    await UserDao().modifyMyInfo(
        avatar: avatar,
        realname: realname,
        gender: gender,
        birthday: birthday,
        workStatus: workStatus,
        education: education,
        profession: profession);
  }

  Future<void> registerUser(
      {required String mobile,
      required String password,
      required String yzm,
      required String osName,
      required String userAgent}) async {
    await UserDao().registerUser(
        mobile: mobile,
        password: password,
        yzm: yzm,
        osName: osName,
        userAgent: userAgent);
  }

  Future<void> scanedQR(String uuid) async {
    await UserDao().scanLogin(type: "scan", uuid: uuid);
  }

  Future<void> scanedLogin(String uuid) async {
    await UserDao().scanLogin(type: "appconfirm", uuid: uuid);
  }
}
