import '../utils/platform_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SPBottomNavigationBar extends StatefulWidget {
  final List<BottomNavigationBarItem> items;
  final ValueChanged<int>? onTap;
  final int currentIndex;

  const SPBottomNavigationBar(
      {Key? key, required this.items, this.onTap, this.currentIndex = 0})
      : super(key: key);
  @override
  _SPBottomNavigationBarState createState() => _SPBottomNavigationBarState();
}

class _SPBottomNavigationBarState extends State<SPBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SPPlatform.isIOS()
        ? CupertinoTabBar(
            items: widget.items,
            activeColor: const Color(0xFFfa7532),
            currentIndex: widget.currentIndex,
            onTap: widget.onTap)
        : BottomNavigationBar(
            items: widget.items,
            currentIndex: widget.currentIndex,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFFfa7532),
            unselectedItemColor: const Color(0xFF969698),
            type: BottomNavigationBarType.fixed,
            onTap: widget.onTap);
  }
}
