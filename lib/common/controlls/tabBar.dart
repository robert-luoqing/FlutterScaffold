import '../../../common/controlls/underlineTabIndicator.dart';
import '../../../common/utils/textStyleUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      labelStyle: SPTextStyle.text16_333_BoldStyle,
      labelColor: Color(0xFF333333),
      unselectedLabelStyle: SPTextStyle.text16_9A9_BoldStyle,
      unselectedLabelColor: Color(0xFF9A9A9A),
      labelPadding: this.labelPadding,
      controller: this.controller,
      isScrollable: this.isScrollable,
      indicator: SPUnderlineTabIndicator(
          borderSide: BorderSide(width: 3, color: Color(0xFFF58D3A))),
      // indicator: UnderlineTabIndicator(
      //     borderSide: BorderSide(width: 3.0, color: Color(0xFFF58D3A)),
      //     insets: EdgeInsets.symmetric(
      //         horizontal: this.indicatorHorizontalInsets ?? 50.0)),
      tabs: tabs,
    );
  }
}
