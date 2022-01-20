import 'package:flutter_localizations/flutter_localizations.dart';

import '../utils/platform_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SPApp extends StatefulWidget {
  final TransitionBuilder? builder;
  final String title;
  final String? initialRoute;
  final Map<String, WidgetBuilder>? routes;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final Iterable<Locale> supportedLocales;

  const SPApp(
      {Key? key,
      Map<String, WidgetBuilder> this.routes = const <String, WidgetBuilder>{},
      this.initialRoute,
      this.title = '',
      this.builder,
      this.localizationsDelegates = const [],
      this.supportedLocales = const <Locale>[Locale('en', 'US')],
      this.locale})
      : super(key: key);
  @override
  _SPAppState createState() => _SPAppState();
}

class _SPAppState extends State<SPApp> {
  @override
  Widget build(BuildContext context) {
    return SPPlatform.isIOS()
        ? CupertinoApp(
            builder: widget.builder,
            title: widget.title,
            initialRoute: widget.initialRoute,
            routes: widget.routes!,
            localizationsDelegates: [
              ...widget.localizationsDelegates,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: widget.supportedLocales,
            locale: widget.locale,
            theme: const CupertinoThemeData(
                primaryColor: Color(0xFF757575),
                textTheme: CupertinoTextThemeData(
                  primaryColor: Color(0xFF757575),
                )),
          )
        : MaterialApp(
            builder: widget.builder,
            title: widget.title,
            initialRoute: widget.initialRoute,
            routes: widget.routes!,
            localizationsDelegates: [
              ...widget.localizationsDelegates,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: widget.supportedLocales,
            locale: widget.locale,
            theme: ThemeData(
              // fontFamily: "Segoe UI Mono",
              primarySwatch: Colors.blue,
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.grey[600]),
              ),
            ));
  }
}
