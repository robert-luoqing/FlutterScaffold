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

  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      // backgroundColor: Colors.blue,
      icon: Icon(Icons.home),
      label: "首页",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          constraints: BoxConstraints.expand(),
          child: Center(child: Text("Hello world, test" * 10))),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: currentIndex,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.yellow,
        type: BottomNavigationBarType.fixed,
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
