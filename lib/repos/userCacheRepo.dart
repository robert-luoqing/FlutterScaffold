import '../../../common/utils/platformUtil.dart';

import 'core/sqflite/userDb.dart';

class UserCacheRepo {
  static const Key_MyUserInfo = 'Key_MyUserInfo';
  static const Key_MyCourseList = 'Key_MyCourseList_';
  static const Key_MyMessage = 'Key_MyMessage';
  static const Key_MyLiveList = 'Key_MyLiveList';
  static const Key_MyDownloadVideoList = 'Key_MyDownloadVideoList';
  static const Key_CanPlayedCourses = 'Key_CanPlayedCourses';
  static const Key_SyncedCourseAndVideo = 'Key_SyncedCourseAndVideo';

  static UserCacheRepo? _cache;
  factory UserCacheRepo() {
    if (_cache == null) {
      _cache = UserCacheRepo._internal();
    }
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
      if (maps.length == 0) {
        return null;
      } else {
        return maps[0]["value"] as String;
      }
    }
  }
}
