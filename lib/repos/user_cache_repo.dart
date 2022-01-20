import '../common/utils/platform_util.dart';

import 'core/sqflite/user_db.dart';

class UserCacheRepo {
  static const keyMyUserInfo = 'Key_MyUserInfo';

  static UserCacheRepo? _cache;
  factory UserCacheRepo() {
    _cache ??= UserCacheRepo._internal();
    return _cache!;
  }
  UserCacheRepo._internal();

  Future<void> setValue(int userId, String key, String val) async {
    if (!SPPlatform.isNotMobile()) {
      await UserDb(userId).rawInsert(
          "INSERT OR REPLACE INTO Cache (key, value) VALUES (?,?)", [key, val]);
    }
  }

  Future<String?> getValue(int userId, String key) async {
    if (SPPlatform.isNotMobile()) {
      return null;
    } else {
      final List<Map<String, dynamic>> maps = await UserDb(userId).query(
          "Cache",
          columns: ["value"],
          where: "key = ?",
          whereArgs: [key]);
      if (maps.isEmpty) {
        return null;
      } else {
        return maps[0]["value"] as String;
      }
    }
  }
}
