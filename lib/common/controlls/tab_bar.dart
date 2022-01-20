import 'underline_tab_indicator.dart';
import '../../theme/text_style.dart';
import 'package:flutter/material.dart';

enum SPTabBarPattern {
  normal,
}

class SPTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final double? indicatorHorizontalInsets;
  final SPTabBarPattern pattern;
  final EdgeInsetsGeometry? labelPadding;
  final TabController? controller;
  final bool isScrollable;
  const SPTabBar(
      {required this.tabs,
      required this.pattern,
      this.indicatorHorizontalInsets,
      this.labelPadding,
      this.controller,
      this.isScrollable = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelStyle: SPTextStyle.text16c333BoldStyle,
      labelColor: const Color(0xFF333333),
      unselectedLabelStyle: SPTextStyle.text16c9A9BoldStyle,
      unselectedLabelColor: const Color(0xFF9A9A9A),
      labelPadding: labelPadding,
      controller: controller,
      isScrollable: isScrollable,
      indicator: const SPUnderlineTabIndicator(
          borderSide: BorderSide(width: 3, color: Color(0xFFF58D3A))),
      // indicator: UnderlineTabIndicator(
      //     borderSide: BorderSide(width: 3.0, color: Color(0xFFF58D3A)),
      //     insets: EdgeInsets.symmetric(
      //         horizontal: this.indicatorHorizontalInsets ?? 50.0)),
      tabs: tabs,
    );
  }
}
