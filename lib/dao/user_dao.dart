import 'package:lingo_dragon/common/core/graph_ql_client.dart';
import 'package:lingo_dragon/models/user/refresh_token_resp_dto.dart';

import '../models/user/login_req_dto.dart';
import '../models/user/login_resp_dto.dart';
import '../models/user/user_info.dart';
import 'base/base_dao.dart';

class UserDao extends BaseDao {
  static UserDao? _cache;
  factory UserDao() {
    _cache ??= UserDao._internal();
    return _cache!;
  }
  UserDao._internal();

  // Future<LoginRespDto> login(LoginReqDto param) async {
  //   var resp = await this.post("/api/v1.member/login", data: param);
  //   return LoginRespDto.fromJson(resp);
  // }

  Future<LoginRespDto> login(LoginReqDto param) async {
    const String loginMobile = r'''
    mutation login($loginInfo: LoginReq!) {
      login(loginInfo: $loginInfo) {
        uid,
        token,
        email,
        mobile,
        username,
        avatar,
        expiredTime,
      }
    }''';

    var paramJson = param.toJson();
    paramJson = {"loginInfo": paramJson};

    var data = await GrahpQLClient()
        .mutate(mutationQL: loginMobile, variables: paramJson);

    return LoginRespDto.fromJson(data);
  }

  Future<RefreshTokenResp> refreshToken(String oldToken) async {
    const String refreshToken = r'''
    mutation refreshToken($oldToken: String!) {
      refreshToken(oldToken: $oldToken) {
        token,
        expiredTime,
      }
    }''';

    var paramJson = {"oldToken": oldToken};

    var data = await GrahpQLClient()
        .mutate(mutationQL: refreshToken, variables: paramJson);

    return RefreshTokenResp.fromJson(data);
  }

  Future<void> sendSMS(String phone) async {
    await get("/api/v1.community/sendVerificationCode?phone=" + phone);
  }

  Future<UserInfo> getUserInfo(int userId) async {
    var userJsonObj = await get("/api/v1.member/info?id=" + userId.toString());
    return UserInfo.fromJson(userJsonObj);
  }

  Future<void> changePassword(
      {required String password, required String newPassword}) async {
    await post("/api/v1.member/password", data: {
      "password": password,
      "new_password": newPassword,
      "new_password2": newPassword
    });
  }

  Future<void> forgotPassword(
      {required String mobile,
      required String yzm,
      required String newPassword}) async {
    await post("/api/v1.member/forgotPassword", data: {
      "mobile": mobile,
      "yzm": yzm,
      "new_password": newPassword,
      "new_password2": newPassword
    });
  }

  Future<void> modifyMyInfo(
      {required String avatar,
      String? realname,
      int? gender,
      String? birthday,
      String? workStatus,
      String? education,
      String? profession}) async {
    await post("/api/v1.member/modifyInfo", data: {
      "avatar": avatar,
      "realname": realname,
      "gender": gender,
      "birthday": birthday,
      "work_status": workStatus,
      "education": education,
      "profession": profession
    });
  }

  Future<void> registerUser(
      {required String mobile,
      required String password,
      required String yzm,
      required String osName,
      required String userAgent}) async {
    await post("/api/v1.member/register", data: {
      "mobile": mobile,
      "yzm": yzm,
      "password": password,
      "osname": osName,
      "user_agent": userAgent
    });
  }

  /// type: [ 已经扫码:scan || 确认登录 : appconfirm ]
  Future<void> scanLogin({required String type, required String uuid}) async {
    await post("/api/v1.member/checkQecode",
        data: {"type": type, "uuid": uuid});
  }
}
