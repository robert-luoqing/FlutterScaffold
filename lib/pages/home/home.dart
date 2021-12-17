import 'package:FlutterScaffold/common/controlls/bottomNavigationBar.dart';
import 'package:FlutterScaffold/common/controlls/scaffold.dart';
import 'package:FlutterScaffold/common/providers/i18nProvider.dart';
import 'package:FlutterScaffold/common/providers/themeProvider.dart';
import 'package:FlutterScaffold/theme/baseTheme.dart';
import 'package:FlutterScaffold/theme/darkTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  final String title = "Home page";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  void _incrementCounter() async {
    Navigator.pushNamed(context, "/test");
  }

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  List<BottomNavigationBarItem> _getBottomNavItem() {
    return [
      BottomNavigationBarItem(
        // backgroundColor: Colors.blue,
        icon: Icon(Icons.home),
        label: SPI18N.of(context).appHome,
      ),
      BottomNavigationBarItem(
        // backgroundColor: Colors.green,
        icon: Icon(Icons.message),
        label: "消息",
      ),
      BottomNavigationBarItem(
        // backgroundColor: Colors.amber,
        icon: Icon(Icons.shopping_cart),
        label: "购物车",
      ),
      BottomNavigationBarItem(
        // backgroundColor: Colors.red,
        icon: Icon(Icons.person),
        label: "个人中心",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
      title: Text(widget.title),
      body: Container(
          constraints: BoxConstraints.expand(),
          color: SPTheme.of(context).primaryColor,
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    var localeProvider = context.read<SPI18NProvider>();
                    localeProvider
                        .changeLocale(localeProvider.supportedLocales[0]);
                  },
                  child: Text("Change Lang To EN")),
              ElevatedButton(
                  onPressed: () {
                    var localeProvider = context.read<SPI18NProvider>();
                    localeProvider
                        .changeLocale(localeProvider.supportedLocales[1]);
                  },
                  child: Text("Change Lang To CN")),
              ElevatedButton(
                  onPressed: () {
                    var themeProvider = context.read<SPThemeProvider>();
                    themeProvider.changeTheme(BaseTheme());
                  },
                  child: Text("Change Theme To Light")),
              ElevatedButton(
                  onPressed: () {
                    var themeProvider = context.read<SPThemeProvider>();
                    themeProvider.changeTheme(DarkTheme());
                  },
                  child: Text("Change Theme To Dark")),
              TextField(
                  // textAlign: TextAlign.end,

                  decoration: InputDecoration.collapsed(hintText: 'hello')),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  SPI18N.of(context).helloWorld,
                ),
              )),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: SPBottomNavigationBar(
        items: _getBottomNavItem(),
        currentIndex: currentIndex,
        onTap: (index) {
          _changePage(index);
        },
      ),
    );
  }

  /*切换页面*/
  void _changePage(int index) {
    /*如果点击的导航项不是当前项  切换 */
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }
}
