import 'package:json_annotation/json_annotation.dart';

part 'login_resp_dto.g.dart';

@JsonSerializable()
class LoginRespDto {
  int uid;
  String? email;
  String? mobile;
  String? username;
  String? avatar;
  String token;
  int expiredTime;

  LoginRespDto({
    required this.uid,
    this.email,
    this.mobile,
    this.username,
    this.avatar,
    required this.token,
    required this.expiredTime,
  });

  factory LoginRespDto.fromJson(Map<String, dynamic> json) =>
      _$LoginRespDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRespDtoToJson(this);
}
