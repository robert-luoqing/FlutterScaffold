import 'package:FlutterScaffold/common/controlls/bottomNavigationBar.dart';
import 'package:FlutterScaffold/common/controlls/scaffold.dart';
import 'package:FlutterScaffold/common/providers/i18nProvider.dart';
import 'package:FlutterScaffold/pages/login/welcome.dart';
import 'package:flutter/material.dart';

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
    // identityHashCode(this);
    return SPScaffold(
      title: Text(widget.title),
      body: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            children: [
              WelcomePage(),
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
