import '../../../common/utils/platformUtil.dart';

import 'core/sqflite/globalDb.dart';

class GlobalSettingRepo {
  static GlobalSettingRepo? _cache;
  factory GlobalSettingRepo() {
    if (_cache == null) {
      _cache = GlobalSettingRepo._internal();
    }
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
      if (maps.length == 0) {
        return null;
      } else {
        return maps[0]["value"] as String;
      }
    }
  }
}
