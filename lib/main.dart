import 'dart:io';
import 'package:FlutterScaffold/theme/baseTheme.dart';
import 'package:provider/provider.dart';
import 'common/controlls/app.dart';
import 'common/core/eventBus.dart';
import 'common/core/eventBusType.dart';
import 'common/core/httpClient.dart';
import 'common/providers/globalVariableProvider.dart';
import 'common/providers/i18nProvider.dart';
import 'common/providers/themeProvider.dart';
import 'config.dart';
import 'dao/baseDao.dart';
import 'routes.dart';
import 'package:flutter/material.dart';
import 'common/controlls/loading.dart';
import 'native/channel/commonChannel.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  // Set host and
  configureApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => SPGlobalVariableProvider()),
    ChangeNotifierProvider(create: (_) => SPI18NProvider()),
    ChangeNotifierProvider(create: (_) => SPThemeProvider()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool inited = false;

  _initBasicData() async {
    SPHttpClient().host = Config.apiHost;
    // 以下是获取token,并设置API Host
    SPHttpClient().onHeaderCallback = () async {
      // var userInfo = await getLoginInfo();
      // if (userInfo == null) {
      //   return {};
      // } else {
      //   return {"x-access-token": userInfo.token};
      // }
      return {};
    };

    // 这里是LoadToken到
    this.setState(() {
      inited = true;
    });

    BaseDao.onTokenExpired = this._tokenExpiredCallback;
  }

  _tokenExpiredCallback() {
    SPEventBus().emit(SPEventBusType.UserLoginOrLogout);
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // Init channel, 只能在build这里初始化，否则会报错（放在这里看一下）
    CommonChannel.initChannel();
    this._initBasicData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!inited) {
      return Container(
          color: Colors.white,
          child: Image.asset(
            "assets/images/splashImage.png",
            fit: BoxFit.fill,
          ));
    } else {
      return Consumer2<SPI18NProvider, SPThemeProvider>(
          builder: (context, i18nProv, themeProv, child) => SPTheme(
              theme: themeProv.currentTheme,
              child: SPApp(
                title: Config.appName,
                initialRoute: SPRoute.initialRoute,
                routes: SPRoute.routes,
                supportedLocales: i18nProv.supportedLocales,
                localizationsDelegates: [
                  i18nProv.delegate,
                ],
                locale: i18nProv.currentLocale,
                builder: (context, widget) {
                  return SPLoading(child: Container(child: widget));
                },
              )));
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
