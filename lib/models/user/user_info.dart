import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  int id;
  String? nickname;
  String? email;
  String? mobile;
  int? isavalible;
  String? userName;
  String? realname;
  int? gender;
  String? avatar;
  String? birthday;
  @JsonKey(name: "work_status")
  String? workStatus;
  String? education;
  String? profession;

  UserInfo({
    required this.id,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
