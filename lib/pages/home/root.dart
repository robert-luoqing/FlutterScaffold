import 'package:flutter/material.dart';
import 'package:lingo_dragon/common/utils/error_util.dart';
import 'package:lingo_dragon/components/home/home.dart';
import 'package:lingo_dragon/components/login/login_dashboard.dart';
import 'package:lingo_dragon/models/user/login_info.dart';
import 'package:lingo_dragon/providers/login_info_provider.dart';
import 'package:lingo_dragon/services/user_service.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

enum RootContentType { login, home }

class _RootPageState extends State<RootPage> {
  RootContentType contentType = RootContentType.login;
  bool inited = false;
  _onEnterHome() {
    setState(() {
      contentType = RootContentType.home;
    });
  }

  Future<void> _refreshToken(LoginInfo? loginInfo) async {
    try {
      var newLoginInfo = await UserService().determinRefreshToken(loginInfo);
      if (newLoginInfo != null) {
        var userInfoProvider = context.read<SPLoginInfoProvider>();
        userInfoProvider.changeUserInfo(newLoginInfo);
      }
    } catch (e, s) {
      SPErrorUtil.toastError(context, e, s);
    }
  }

  Future<void> _verifyToken() async {
    try {
      var loginInfo = await UserService().verifyToken();
      var userInfoProvider = context.read<SPLoginInfoProvider>();
      userInfoProvider.changeUserInfo(loginInfo);

      setState(() {
        contentType =
            loginInfo == null ? RootContentType.login : RootContentType.home;
      });

      /// 注意, refreshToken无须用await
      _refreshToken(loginInfo);
    } catch (e, s) {
      SPErrorUtil.toastError(context, e, s);
    } finally {
      setState(() {
        inited = true;
      });
    }

    context.read<SPLoginInfoProvider>().addListener(_handleLoginInfoChanged);
  }

  void _handleLoginInfoChanged() {
    var loginInfo = context.read<SPLoginInfoProvider>().loginInfo;
    if (loginInfo == null) {
      UserService().logout();
      setState(() {
        contentType = RootContentType.login;
      });
    }
  }

  @override
  void initState() {
    _verifyToken();
    super.initState();
  }

  @override
  void dispose() {
    context.read<SPLoginInfoProvider>().removeListener(_handleLoginInfoChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!inited) {
      return Container(
          color: Colors.white,
          child: Image.asset(
            "assets/icons/splashImage.png",
            fit: BoxFit.fill,
          ));
    } else {
      return contentType == RootContentType.login
          ? LoginDashboard(onEnterHome: _onEnterHome)
          : const HomeComponent();
    }
  }
}
