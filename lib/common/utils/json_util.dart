import 'dart:convert' as convert;

class JsonUtil {
  static JsonUtil? _cache;
  factory JsonUtil() {
    _cache ??= JsonUtil._internal();
    return _cache!;
  }

  JsonUtil._internal();

  List<T>? toList<T>(
      {String? jsonString,
      required T Function(Map<String, dynamic> json) fromJsonFunc}) {
    if (jsonString != null) {
      var jsonObj = convert.jsonDecode(jsonString);
      var result = jsonObj.map<T>((item) => fromJsonFunc(item)).toList();
      return result;
    }
    return null;
  }

  String? toJsonStringFromList(List<dynamic>? list) {
    if (list != null) {
      var jsonString = convert.jsonEncode(list.map((e) => e.toJson()).toList());
      return jsonString;
    } else {
      return null;
    }
  }
}
