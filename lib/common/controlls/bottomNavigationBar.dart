import '../../../common/utils/platformUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SPBottomNavigationBar extends StatefulWidget {
  final List<BottomNavigationBarItem> items;
  final ValueChanged<int>? onTap;
  final int currentIndex;

  SPBottomNavigationBar(
      {required this.items, this.onTap, this.currentIndex = 0});
  @override
  _SPBottomNavigationBarState createState() => _SPBottomNavigationBarState();
}

class _SPBottomNavigationBarState extends State<SPBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SPPlatform.isIOS()
        ? CupertinoTabBar(
            items: this.widget.items,
            activeColor: Color(0xFFfa7532),
            currentIndex: this.widget.currentIndex,
            onTap: this.widget.onTap)
        : BottomNavigationBar(
            items: this.widget.items,
            currentIndex: this.widget.currentIndex,
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xFFfa7532),
            unselectedItemColor: Color(0xFF969698),
            type: BottomNavigationBarType.fixed,
            onTap: this.widget.onTap);
  }
}
