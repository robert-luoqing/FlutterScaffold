class ValidateUtil {
  // 验证电话号码格式
  static bool isTel(String text) {
    String regexTelNumber = "^[1-9]\\d{5,14}\$";
    return RegExp(regexTelNumber).hasMatch(text);
  }

  // 验证邮箱格式
  static bool isEmail(String text) {
    String regex =
        "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
    return RegExp(regex).hasMatch(text);
  }
}
