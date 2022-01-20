import 'package:flutter/foundation.dart';
import 'package:lingo_dragon/models/user/login_info.dart';

class SPLoginInfoProvider with ChangeNotifier, DiagnosticableTreeMixin {
  LoginInfo? _currentLoginInfo;
  SPLoginInfoProvider();

  changeUserInfo(LoginInfo? userInfo) {
    _currentLoginInfo = userInfo;
    notifyListeners();
  }

  LoginInfo? get loginInfo => _currentLoginInfo;
}
