import 'dart:convert';

class Base64Util {
  Base64Util._();
  static String encode(String str) {
    return base64.encode(utf8.encode(str));
  }

  static String decode(String base64Str) {
    return utf8.decode(base64.decode(base64Str));
  }
}
