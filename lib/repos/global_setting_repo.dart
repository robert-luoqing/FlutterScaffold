import '../common/utils/platform_util.dart';

import 'core/sqflite/global_db.dart';

class GlobalSettingRepo {
  static GlobalSettingRepo? _cache;
  factory GlobalSettingRepo() {
    _cache ??= GlobalSettingRepo._internal();
    return _cache!;
  }
  GlobalSettingRepo._internal();

  Future<void> setValue(String key, String val) async {
    if (!SPPlatform.isNotMobile()) {
      await GlobalDb()
          .insert("Setting", <String, Object>{"key": key, "value": val});
    }
  }

  Future<String?> getValue(String key) async {
    if (SPPlatform.isNotMobile()) {
      return null;
    } else {
      final List<Map<String, dynamic>> maps = await GlobalDb().query("Setting",
          columns: ["value"], where: "key = ?", whereArgs: [key]);
      if (maps.isEmpty) {
        return null;
      } else {
        return maps[0]["value"] as String;
      }
    }
  }
}
