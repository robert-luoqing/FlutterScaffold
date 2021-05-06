import 'routes.dart';
import 'package:flutter/material.dart';
import 'common/controlls/loading.dart';
import 'common/core/httpClient.dart';
import 'config.dart';
import 'native/channel/commonChannel.dart';

void main() {
  // Set host
  HttpClient().host = Config.apiHost;
  runApp(
    SPLoading(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Init channel, 只能在build这里初始化，否则会报错
    CommonChannel.initChannel();
    return MaterialApp(
        title: 'Education',
        initialRoute: SPRoute.initialRoute,
        routes: SPRoute.routes,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ));
  }
}
