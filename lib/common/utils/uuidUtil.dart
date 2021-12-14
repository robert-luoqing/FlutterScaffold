import 'package:uuid/uuid.dart';

class SPUUIDUtil {
  static String generateUUID() {
    var uuid = Uuid();
    return uuid.v4();
  }

  static String generateUUID2() {
    var uuid = Uuid();
    return uuid.v4().replaceAll("-", "");
  }
}
