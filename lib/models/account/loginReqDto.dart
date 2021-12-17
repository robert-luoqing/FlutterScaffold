import 'package:json_annotation/json_annotation.dart';

part 'loginReqDto.g.dart';

// https://docs.apipost.cn/preview/710c4b2cf9efddae/a954cd014d7e99f0?target_id=c29d15d1-d8cf-45a2-9786-07321dcc73e0#c29d15d1-d8cf-45a2-9786-07321dcc73e0
@JsonSerializable()
class LoginReqDto {
  int type;
  String? account;
  String? password;
  String? mobile;
  String? yzm;
  @JsonKey(name: "osname")
  String osName;
  @JsonKey(name: "user_agent")
  String userAgent;
  LoginReqDto(
      {required this.type,
      required this.osName,
      required this.userAgent,
      this.account,
      this.password,
      this.mobile,
      this.yzm});

  factory LoginReqDto.fromJson(Map<String, dynamic> json) =>
      _$LoginReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginReqDtoToJson(this);
}
