import 'package:flutter/material.dart';
import 'nested_scroll_view.dart';

class ExpandHeaderTabView extends StatefulWidget {
  final double maxExtend;
  final double minExtend;

  /// [refreshControlBuilder] build refresh control
  final Widget Function(Widget child)? refreshControlBuilder;

  /// [headerControlBuilder] will return the header widget
  final Widget Function(double offset)? headerControlBuilder;

  final List<Widget> Function()? sliverBuilder;

  final NestedScrollViewPinnedHeaderSliverHeightBuilder?
      pinnedHeaderSliverHeightBuilder;

  final bool onlyOneScrollInBody;

  final Widget child;

  const ExpandHeaderTabView(
      {Key? key,
      required this.child,
      this.minExtend = 50,
      this.maxExtend = 50,
      this.refreshControlBuilder,
      this.headerControlBuilder,
      this.sliverBuilder,
      this.pinnedHeaderSliverHeightBuilder,
      this.onlyOneScrollInBody = false})
      : super(key: key);

  @override
  State<ExpandHeaderTabView> createState() => _ExpandHeaderTabViewState();
}

class _ExpandHeaderTabViewState extends State<ExpandHeaderTabView> {
  @override
  Widget build(BuildContext context) {
    return SPNestedScrollView(
        pinnedHeaderSliverHeightBuilder: widget.pinnedHeaderSliverHeightBuilder,
        onlyOneScrollInBody: widget.onlyOneScrollInBody,
        refreshControlBuilder: widget.refreshControlBuilder,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          if (widget.headerControlBuilder != null) {
            return <Widget>[
              SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: PersistentHeaderBuilder(
                      builder: (ctx, offset) => SizedBox(
                          height: widget.maxExtend,
                          child: widget.headerControlBuilder!(offset)),
                      min: widget.minExtend,
                      max: widget.maxExtend)),
            ];
          } else {
            if (widget.sliverBuilder != null) {
              return widget.sliverBuilder!();
            }
            return [];
          }
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
