import '../../models/account/loginReqDto.dart';
import '../../models/account/loginRespDto.dart';
import '../../models/account/userInfo.dart';
import 'baseDao.dart';

class UserDao extends BaseDao {
  static UserDao? _cache;
  factory UserDao() {
    if (_cache == null) {
      _cache = UserDao._internal();
    }
    return _cache!;
  }
  UserDao._internal();

  Future<LoginRespDto> login(LoginReqDto param) async {
    var resp = await this.post("/api/v1.member/login", data: param);
    return LoginRespDto.fromJson(resp);
  }

  Future<void> sendSMS(String phone) async {
    await this.get("/api/v1.community/sendVerificationCode?phone=" + phone);
  }

  Future<UserInfo> getUserInfo(int userId) async {
    var userJsonObj =
        await this.get("/api/v1.member/info?id=" + userId.toString());
    return UserInfo.fromJson(userJsonObj);
  }

  Future<void> changePassword(
      {required String password, required String newPassword}) async {
    await this.post("/api/v1.member/password", data: {
      "password": password,
      "new_password": newPassword,
      "new_password2": newPassword
    });
  }

  Future<void> forgotPassword(
      {required String mobile,
      required String yzm,
      required String newPassword}) async {
    await this.post("/api/v1.member/forgotPassword", data: {
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
    await this.post("/api/v1.member/modifyInfo", data: {
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
    await this.post("/api/v1.member/register", data: {
      "mobile": mobile,
      "yzm": yzm,
      "password": password,
      "osname": osName,
      "user_agent": userAgent
    });
  }

  /// type: [ 已经扫码:scan || 确认登录 : appconfirm ]
  Future<void> scanLogin({required String type, required String uuid}) async {
    await this
        .post("/api/v1.member/checkQecode", data: {"type": type, "uuid": uuid});
  }
}
