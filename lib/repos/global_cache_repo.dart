import '../common/utils/platform_util.dart';

import 'core/sqflite/global_db.dart';

/// GlobalCacheRepo保存与用户无关的Cache
class GlobalCacheRepo {
  static const keyAppInfo = "Key_AppInfo";
  static const keyLoginUserInfo = "Key_LoginUserInfo";
  static const keyLoginInfo = "Key_LoginInfo";

  static GlobalCacheRepo? _cache;
  factory GlobalCacheRepo() {
    _cache ??= GlobalCacheRepo._internal();
    return _cache!;
  }
  GlobalCacheRepo._internal();

  Future<void> setValue(String key, String val) async {
    if (!SPPlatform.isNotMobile()) {
      await GlobalDb().rawInsert(
          "INSERT OR REPLACE INTO Cache (key, value) VALUES (?,?)", [key, val]);
    }
  }

  Future<String?> getValue(String key) async {
    if (SPPlatform.isNotMobile()) {
      return null;
    } else {
      final List<Map<String, dynamic>> maps = await GlobalDb().query("Cache",
          columns: ["value"], where: "key = ?", whereArgs: [key]);
      if (maps.isEmpty) {
        return null;
      } else {
        return maps[0]["value"] as String;
      }
    }
  }
}
