import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'testModel.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class TestModel {
  TestModel(this.name, this.email);

  String name;
  String email;

  factory TestModel.fromJson(Map<String, dynamic> json) =>
      _$TestModelFromJson(json);
  Map<String, dynamic> toJson() => _$TestModelToJson(this);
}
