import 'package:flutter/material.dart';

import 'nested_scroll_view.dart';

class ExpandHeaderTabView extends StatefulWidget {
  final double maxExtend;
  final double minExtend;

  /// [refreshControlBuilder] build refresh control
  final Widget Function(Widget child)? refreshControlBuilder;

  /// [headerControlBuilder] will return the header widget
  final Widget Function(double offset)? headerControlBuilder;

  final Widget child;

  const ExpandHeaderTabView(
      {Key? key,
      required this.child,
      required this.minExtend,
      required this.maxExtend,
      this.refreshControlBuilder,
      this.headerControlBuilder})
      : super(key: key);

  @override
  State<ExpandHeaderTabView> createState() => _ExpandHeaderTabViewState();
}

class _ExpandHeaderTabViewState extends State<ExpandHeaderTabView> {
  @override
  Widget build(BuildContext context) {
    return SPNestedScrollView(
        refreshControlBuilder: widget.refreshControlBuilder,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: PersistentHeaderBuilder(
                    builder: (ctx, offset) => SizedBox(
                        height: widget.maxExtend,
                        child: widget.headerControlBuilder == null
                            ? Container()
                            : widget.headerControlBuilder!(offset)),
                    min: widget.minExtend,
                    max: widget.maxExtend)),
          ];
        },
        body: widget.child);
  }
}

class PersistentHeaderBuilder extends SliverPersistentHeaderDelegate {
  final double max;
  final double min;
  final Widget Function(BuildContext context, double offset) builder;

  PersistentHeaderBuilder(
      {this.max = 120, this.min = 80, required this.builder});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(context, shrinkOffset);
  }

  @override
  double get maxExtent => max;

  @override
  double get minExtent => min;

  @override
  bool shouldRebuild(covariant PersistentHeaderBuilder oldDelegate) =>
      max != oldDelegate.max ||
      min != oldDelegate.min ||
      builder != oldDelegate.builder;
}
