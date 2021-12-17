import 'package:json_annotation/json_annotation.dart';

part 'loginRespDto.g.dart';

// https://docs.apipost.cn/preview/710c4b2cf9efddae/a954cd014d7e99f0?target_id=c29d15d1-d8cf-45a2-9786-07321dcc73e0#c29d15d1-d8cf-45a2-9786-07321dcc73e0
@JsonSerializable()
class LoginRespDto {
  int id;
  String token;
  String? email;
  String? mobile;
  String? userName;

  LoginRespDto(
      {required this.id,
      required this.token,
      this.email,
      this.mobile,
      this.userName});

  factory LoginRespDto.fromJson(Map<String, dynamic> json) =>
      _$LoginRespDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRespDtoToJson(this);
}
