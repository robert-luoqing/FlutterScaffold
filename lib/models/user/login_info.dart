import 'package:json_annotation/json_annotation.dart';

part 'login_info.g.dart';

@JsonSerializable()
class LoginInfo {
  int uid;
  String token;
  int expiredTime;
  int needRefreshTokenTime;
  String? email;
  String? mobile;
  String? username;
  String? avatar;

  LoginInfo({
    required this.uid,
    this.email,
    this.mobile,
    this.username,
    this.avatar,
    required this.token,
    required this.expiredTime,
    required this.needRefreshTokenTime,
  });

  factory LoginInfo.fromJson(Map<String, dynamic> json) =>
      _$LoginInfoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginInfoToJson(this);
}
