import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lingo_dragon/common/widgets/button.dart';
import 'package:lingo_dragon/common/widgets/loading.dart';
import 'package:lingo_dragon/common/core/exception.dart';
import 'package:lingo_dragon/common/utils/error_util.dart';
import 'package:lingo_dragon/common/utils/platform_util.dart';
import 'package:lingo_dragon/common/utils/version_util.dart';
import 'package:lingo_dragon/models/user/login_device_info.dart';
import 'package:lingo_dragon/pages/login/email_login_page.dart';
import 'package:lingo_dragon/pages/login/phone_login_page.dart';
import 'package:lingo_dragon/common/widgets/scaffold.dart';
import 'package:lingo_dragon/providers/i18n_provider.dart';
import 'package:lingo_dragon/providers/login_info_provider.dart';
import 'package:lingo_dragon/services/social_auth_service.dart';
import 'package:lingo_dragon/theme/text_style.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginDashboard extends StatefulWidget {
  const LoginDashboard({Key? key, required this.onEnterHome}) : super(key: key);

  final void Function() onEnterHome;

  @override
  _LoginDashboardState createState() => _LoginDashboardState();
}

class _LoginDashboardState extends State<LoginDashboard> {
  final psdController = TextEditingController();
  final againPsdController = TextEditingController();
  bool appleLoginVisible = true;

  @override
  void initState() {
    checkAppleLoginVisible();
    super.initState();
  }

  @override
  void dispose() {
    psdController.dispose();
    againPsdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
      title: const Text("Login"),
      noStatusBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          renderHeader(),
          renderLoginModule(),
          renderTip(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onEnterHome,
        tooltip: 'Enter Home',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget renderHeader() {
    return (Container(
        child: Text(
          SPI18N.of(context).helloWorld,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        margin: const EdgeInsets.only(top: 100, bottom: 100)));
  }

  Widget renderLoginModule() {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 30, right: 30, bottom: 24),
            child: SPButton(
                icon: Container(
                    child: Image.asset(
                      "assets/icons/googleIcon.png",
                      width: 23,
                      height: 23,
                    ),
                    margin: const EdgeInsets.only(right: 15)),
                pattern: SPButtonPattern.googleLoginButton,
                size: SPButtonSize.large,
                onPressed: _loginGoogleOnTap,
                disabled: false,
                text: SPI18N.of(context).login_button_google)),
        (appleLoginVisible
            ? Container(
                margin: const EdgeInsets.only(left: 30, right: 30, bottom: 24),
                child: SPButton(
                    icon: Container(
                        child: SvgPicture.asset("assets/icons/appleIcon.svg"),
                        margin: const EdgeInsets.only(right: 15)),
                    pattern: SPButtonPattern.appleLoginButton,
                    size: SPButtonSize.large,
                    onPressed: _loginByApple,
                    disabled: false,
                    text: SPI18N.of(context).login_button_apple))
            : Container(
                height: 40,
              )),
        renderSeparateLines(),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: GestureDetector(
                  child: SvgPicture.asset('assets/icons/icon_login_phone.svg'),
                  onTap: _phoneOnTap,
                ),
                margin: const EdgeInsets.only(right: 25),
              ),
              GestureDetector(
                child: SvgPicture.asset('assets/icons/icon_login_email.svg'),
                onTap: _emailOnTap,
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Widget renderTip() {
    return (Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 26, bottom: 37),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: SPTextStyle.text12c979FA8MediumStylefh167,
          children: <TextSpan>[
            TextSpan(text: SPI18N.of(context).login_text_termsText1),
            TextSpan(
                text: SPI18N.of(context).login_button_terms,
                style: SPTextStyle.text12c1A1C25MediumStylefh167,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    openUrl('TermsURL');
                  }),
            TextSpan(text: SPI18N.of(context).login_text_termsText2),
            TextSpan(
                text: SPI18N.of(context).login_button_policy,
                style: SPTextStyle.text12c1A1C25MediumStylefh167,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    openUrl('Privacy PolicyURL');
                  }),
          ],
        ),
      ),
    ));
  }

  Widget renderSeparateLines() {
    return (Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 16),
      child: Row(
        children: [
          SvgPicture.asset('assets/icons/dotted_line.svg'),
          const Expanded(
            child: Text(
              'Or continue with ',
              textAlign: TextAlign.center,
              style: SPTextStyle.text12c979FA8MediumStylefh167,
            ),
            flex: 1,
          ),
          SvgPicture.asset('assets/icons/dotted_line.svg'),
        ],
      ),
    ));
  }

  void openUrl(String url) {
    launch(url);
    // 打开相关链接网页
  }

  void _phoneOnTap() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const PhoneLoginPage();
        },
        fullscreenDialog: true));
  }

  void _emailOnTap() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const EmailLoginPage();
        },
        fullscreenDialog: true));
  }

  Future<LoginDeviceInfo> _getDeviceInfo() async {
    var deviceInfo = await SPPlatform.getDeviceInfo();
    LoginDeviceInfo loginDeviceInfo = LoginDeviceInfo();
    if (deviceInfo != null) {
      loginDeviceInfo.deviceId = deviceInfo.deviceId;
      loginDeviceInfo.macAddress = deviceInfo.macAddress;
      loginDeviceInfo.platform = deviceInfo.platform;
      loginDeviceInfo.version = deviceInfo.version;
      loginDeviceInfo.os = deviceInfo.os;
      loginDeviceInfo.model = deviceInfo.model;
      loginDeviceInfo.brand = deviceInfo.brand;
      loginDeviceInfo.maxVersion = deviceInfo.maxVersion;
    }
    return loginDeviceInfo;
  }

  Future<void> _loginGoogleOnTap() async {
    try {
      SPLoading.show();
      var deviceInfo = await _getDeviceInfo();
      var userInfo = await SocialAuthService().signInWithGoogle(deviceInfo);

      var userInfoProvider = context.read<SPLoginInfoProvider>();
      userInfoProvider.changeUserInfo(userInfo);
      widget.onEnterHome();
    } catch (e, s) {
      // 当前把所有非SPException错误都Ignore掉
      if (e.runtimeType == SPException) {
        SPErrorUtil.toastError(context, e, s);
      }
    } finally {
      SPLoading.hide();
    }
  }

  Future<void> _loginByApple() async {
    try {
      SPLoading.show();
      var deviceInfo = await _getDeviceInfo();
      var userInfo = await SocialAuthService().signInWithApple(deviceInfo);

      var userInfoProvider = context.read<SPLoginInfoProvider>();
      userInfoProvider.changeUserInfo(userInfo);
      widget.onEnterHome();
    } catch (e, s) {
      // 当前把所有非SPException错误都Ignore掉
      if (e.runtimeType == SPException) {
        SPErrorUtil.toastError(context, e, s);
      }
    } finally {
      SPLoading.hide();
    }
  }

  Future<void> checkAppleLoginVisible() async {
    try {
      if (SPPlatform.isAndroid()) {
        setState(() {
          appleLoginVisible = false;
        });
      } else {
        var deviceInfo = await SPPlatform.getDeviceInfo();
        var iosInVisible = SPPlatform.isIOS() &&
            deviceInfo != null &&
            deviceInfo.deviceVsersion != null &&
            VersionUtil.haveNewVersion("13.0.0", deviceInfo.deviceVsersion!);
        if (iosInVisible) {
          setState(() {
            appleLoginVisible = false;
          });
        }
      }
    } catch (e, s) {
      SPErrorUtil.toastError(context, e, s);
    }
  }
}
