// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestModel _$TestModelFromJson(Map<String, dynamic> json) {
  return TestModel(
    json['name'] as String,
    json['email'] as String,
  );
}

Map<String, dynamic> _$TestModelToJson(TestModel instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
    };
