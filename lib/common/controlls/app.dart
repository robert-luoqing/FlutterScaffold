import '../../../common/utils/platformUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SPApp extends StatefulWidget {
  final TransitionBuilder? builder;
  final String title;
  final String? initialRoute;
  final Map<String, WidgetBuilder>? routes;
  const SPApp({
    Key? key,
    Map<String, WidgetBuilder> this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.title = '',
    this.builder,
  });
  @override
  _SPAppState createState() => _SPAppState();
}

class _SPAppState extends State<SPApp> {
  @override
  Widget build(BuildContext context) {
    return SPPlatform.isIOS()
        ? CupertinoApp(
            builder: this.widget.builder,
            title: this.widget.title,
            initialRoute: this.widget.initialRoute,
            routes: this.widget.routes!,
            theme: CupertinoThemeData(
                primaryColor: Color(0xFF757575),
                textTheme: CupertinoTextThemeData(
                  primaryColor: Color(0xFF757575),
                )),
            localizationsDelegates: [
                DefaultMaterialLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
              ])
        : MaterialApp(
            builder: this.widget.builder,
            title: this.widget.title,
            initialRoute: this.widget.initialRoute,
            routes: this.widget.routes!,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.grey[600]),
              ),
            ));
  }
}
