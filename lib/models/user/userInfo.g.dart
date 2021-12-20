// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      id: json['id'] as int,
    )
      ..nickname = json['nickname'] as String?
      ..email = json['email'] as String?
      ..mobile = json['mobile'] as String?
      ..isavalible = json['isavalible'] as int?
      ..userName = json['userName'] as String?
      ..realname = json['realname'] as String?
      ..gender = json['gender'] as int?
      ..avatar = json['avatar'] as String?
      ..birthday = json['birthday'] as String?
      ..workStatus = json['work_status'] as String?
      ..education = json['education'] as String?
      ..profession = json['profession'] as String?;

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'email': instance.email,
      'mobile': instance.mobile,
      'isavalible': instance.isavalible,
      'userName': instance.userName,
      'realname': instance.realname,
      'gender': instance.gender,
      'avatar': instance.avatar,
      'birthday': instance.birthday,
      'work_status': instance.workStatus,
      'education': instance.education,
      'profession': instance.profession,
    };
