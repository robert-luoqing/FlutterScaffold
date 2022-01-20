import 'package:lingo_dragon/common/controlls/bottom_navigationbar.dart';
import 'package:lingo_dragon/common/controlls/button.dart';
import 'package:lingo_dragon/common/controlls/dialog.dart';
import 'package:lingo_dragon/common/controlls/scaffold.dart';
import 'package:lingo_dragon/common/utils/error_util.dart';
import 'package:lingo_dragon/providers/i18n_provider.dart';
import 'package:flutter/material.dart';
import 'package:lingo_dragon/providers/login_info_provider.dart';
import 'package:provider/provider.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({Key? key}) : super(key: key);
  final String title = "Home page";

  @override
  _HomeComponentState createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  int currentIndex = 0;

  void _incrementCounter() async {
    Navigator.pushNamed(context, "/test");
  }

  Future<void> _logout() async {
    try {
      var loginInfoProvider = context.read<SPLoginInfoProvider>();
      loginInfoProvider.changeUserInfo(null);
    } catch (e, s) {
      SPErrorUtil.toastError(context, e, s);
    }
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
        icon: const Icon(Icons.home),
        label: SPI18N.of(context).appHome,
      ),
      const BottomNavigationBarItem(
        // backgroundColor: Colors.green,
        icon: Icon(Icons.message),
        label: "消息",
      ),
      const BottomNavigationBarItem(
        // backgroundColor: Colors.amber,
        icon: Icon(Icons.shopping_cart),
        label: "购物车",
      ),
      const BottomNavigationBarItem(
        // backgroundColor: Colors.red,
        icon: Icon(Icons.person),
        label: "个人中心",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var loginInfo = context.read<SPLoginInfoProvider>().loginInfo;
    return SPScaffold(
      title: Text(widget.title),
      body: Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          constraints: const BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("expiredTime: " + (loginInfo?.expiredTime ?? 0).toString()),
              Text("token: " + (loginInfo?.token ?? "")),
              Text("uid:  " + (loginInfo?.uid ?? 0).toString()),
              Text("userName: " + (loginInfo?.username ?? "")),
              SPButton(
                pattern: SPButtonPattern.animatedButton,
                text: SPI18N.of(context).me_account_logOut,
                onPressed: logout,
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
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

  Future<void> logout() async {
    var result = await SPDialog.confirm(
        context, SPI18N.of(context).me_accountAlert_logOut);
    if (result) {
      _logout();
    }
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
