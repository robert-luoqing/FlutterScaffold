import 'dart:io';
import 'package:lingo_dragon/providers/login_info_provider.dart';
import 'package:provider/provider.dart';
import 'common/widgets/app.dart';
import 'common/core/http_client.dart';
import 'providers/global_variable_provider.dart';
import 'providers/i18n_provider.dart';
import 'providers/theme_provider.dart';
import 'config.dart';
import 'dao/base/base_dao.dart';
import 'common/core/graph_ql_client.dart';
import 'routes.dart';
import 'package:flutter/material.dart';
import 'common/widgets/loading.dart';
import 'native/channel/common_channel.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  // Set host and
  configureApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => SPGlobalVariableProvider()),
    ChangeNotifierProvider(create: (_) => SPI18NProvider()),
    ChangeNotifierProvider(create: (_) => SPThemeProvider()),
    ChangeNotifierProvider(create: (_) => SPLoginInfoProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _initBasicData() async {
    SPHttpClient().host = Config.apiHost;
    GrahpQLClient().host = Config.grahpQLHost;

    BaseDao.onTokenExpired = _tokenExpiredCallback;
  }

  _tokenExpiredCallback() {}

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // Init channel, 只能在build这里初始化，否则会报错（放在这里看一下）
    CommonChannel.initChannel();
    _initBasicData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
