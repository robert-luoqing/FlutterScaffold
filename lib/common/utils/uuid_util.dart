import 'package:uuid/uuid.dart';

class SPUUIDUtil {
  static String generateUUID() {
    // ignore: prefer_const_constructors
    var uuid = Uuid();
    return uuid.v4();
  }

  static String generateUUID2() {
    // ignore: prefer_const_constructors
    var uuid = Uuid();
    return uuid.v4().replaceAll("-", "");
  }
}
