import 'package:json_annotation/json_annotation.dart';

part 'userInfo.g.dart';

@JsonSerializable()
class UserInfo {
  static const UserInfoGender_Male = 0;
  static const UserInfoGender_Female = 1;
  static const Map<int, String> MapGender = {0: "男", 1: "女"};
  static String convertGenderToString(int? gender) {
    if (gender != null) {
      if (MapGender.containsKey(gender)) {
        return MapGender[gender] ?? "";
      }
    }
    return "";
  }

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
