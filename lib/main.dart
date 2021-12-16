import 'dart:io';
import 'package:provider/provider.dart';
import 'common/controlls/app.dart';
import 'common/core/eventBus.dart';
import 'common/core/eventBusType.dart';
import 'common/providers/globalVariableProvider.dart';
import 'dao/baseDao.dart';
import 'localization/spI18N.dart';
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
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool inited = false;
  String appName = "Flutter Scaffold";
  Locale locale = SPI18N().currentLocale;

  _initBasicData() async {
    this.setState(() {
      inited = true;
    });

    BaseDao.onTokenExpired = this._tokenExpiredCallback;
  }

  _tokenExpiredCallback() {
    SPEventBus().emit(SPEventBusType.UserLoginOrLogout);
  }

  _localeChanged(arg) {
    this.setState(() {
      this.locale = SPI18N().currentLocale;
    });
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // Init channel, 只能在build这里初始化，否则会报错（放在这里看一下）
    CommonChannel.initChannel();
    this._initBasicData();
    SPEventBus().on(SPEventBusType.LocaleChanged, _localeChanged);
    super.initState();
  }

  @override
  void dispose() {
    SPEventBus().off(SPEventBusType.LocaleChanged, _localeChanged);
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
      return SPApp(
        title: this.appName,
        initialRoute: SPRoute.initialRoute,
        routes: SPRoute.routes,
        supportedLocales: SPI18N().supportedLocales,
        localizationsDelegates: [
          SPI18N().delegate,
        ],
        locale: locale,
        builder: (context, widget) {
          return SPLoading(child: Container(child: widget));
        },
      );
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
