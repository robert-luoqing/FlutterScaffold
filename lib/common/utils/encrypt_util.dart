import 'dart:convert' as convert;

import 'dart:convert';

import 'package:crypto/crypto.dart';

class EncryptUtil {
  EncryptUtil._();
  static String encodeBase64(String str) {
    return convert.base64.encode(convert.utf8.encode(str));
  }

  static String decodeBase64(String base64Str) {
    return convert.utf8.decode(convert.base64.decode(base64Str));
  }

  static String encodeComponent(String str) {
    return Uri.encodeComponent(str);
  }

  static String decodeComponent(String str) {
    return Uri.decodeComponent(str);
  }

  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
