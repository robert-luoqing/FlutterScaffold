import '../../../common/utils/platformUtil.dart';

import 'core/sqflite/globalDb.dart';

/// GlobalCacheRepo保存与用户无关的Cache
class GlobalCacheRepo {
  static const Key_AppInfo = "Key_AppInfo";
  static const Key_HomeSubjects = "Key_HomeSubjects";
  static const Key_HomeNews = "Key_HomeNews";
  static const Key_RecommandCourses = "Key_RecommandCourses";
  static const Key_HotLives = "Key_HotLives";
  static const Key_LoginInfo = "Key_LoginInfo";
  static const Key_MyPageMenus = "Key_MyPageMenus";
  static const Key_CourseSubjects = "Key_CourseSubjects";
  static const Key_ShowOrHidePrice = "Key_ShowOrHidePrice";
  static const Key_WorkStatus = "Key_WorkStatus";
  static const Key_Education = "Key_Education";
  static const Key_RegistrationAgreement = "Key_RegistrationAgreement";
  static const Key_DataFromWebView = "Key_DataFromWebView_";
  static const Key_DefaultVideoQualityLevel = "Key_DefaultVideoQualityLevel";
  static const Key_DisableShowWelcomePage = "Key_DisableShowWelcomePage";
  static const Key_LastUserName = "Key_LastUserName";
  static const Key_LastPassword = "Key_LastPassword";
  static const Key_LastUserAppTime = "Key_LastUserAppTime";
  static const Key_CustomerServiceAddress = "Key_CustomerServiceAddress";
  static const Key_DisableShowHomePrivacy = "Key_DisableShowHomePrivacy";

  static GlobalCacheRepo? _cache;
  factory GlobalCacheRepo() {
    if (_cache == null) {
      _cache = GlobalCacheRepo._internal();
    }
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
      if (maps.length == 0) {
        return null;
      } else {
        return maps[0]["value"] as String;
      }
    }
  }
}
