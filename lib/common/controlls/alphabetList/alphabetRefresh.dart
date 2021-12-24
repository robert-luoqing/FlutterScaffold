import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'alphabetBindListModel.dart';

abstract class AlphabetRefresh extends StatefulWidget {
  const AlphabetRefresh(
      {required this.isRefreshing,
      required this.onRefresh,
      this.maxReleaseHeight = 50,
      this.bounceToHeightAfterRelease = 40,
      Key? key})
      : super(key: key);
  final SPAlphabetListViewRefresh onRefresh;
  final bool isRefreshing;

  /// [maxReleaseHeight] is mean the bounce height has reach release
  /// If the offset<maxReleaseHeight, the onRefresh will not fire after
  /// release you finger
  final double maxReleaseHeight;

  /// [bounceToHeightAfterRelease] is after you release your finger
  /// control will show "Refresh...", The value is the height of the control
  /// We need smooth rebounce the height make sure the good expierience
  final double bounceToHeightAfterRelease;
}

abstract class AlphabetRefreshState extends State<AlphabetRefresh> {
  double _offset = 0;
  ScrollPosition? _position;

  @override
  void initState() {
    // _animation = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _updatePositionListener();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(AlphabetRefresh oldWidget) {
    _updatePositionListener();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _position?.removeListener(_handleOffsetChange);
    _position = null;
    // _animation.dispose();
    super.dispose();
  }

  void _doRefreshAction() async {
    await this.widget.onRefresh();

    if (this.mounted) {
      setState(() {});
    }
  }

  void _handleOffsetChange() {
    if (_position != null) {
      var pixels = _position?.pixels ?? 0.0;
      var minExtent = _position?.minScrollExtent ?? 0.0;
      ScrollActivity? activity = _position?.activity;
      var offset = minExtent - pixels;
      if (offset < 0) {
        offset = 0;
      }

      if (_offset != offset) {
        _offset = offset;
        if (offset >= this.widget.maxReleaseHeight &&
            activity is BallisticScrollActivity &&
            this.widget.isRefreshing == false) {
          // Do refresh action
          _doRefreshAction();
        }
        if (this.mounted) {
          setState(() {});
        }
      }
    }
  }

  void _updatePositionListener() {
    final ScrollPosition newPosition = Scrollable.of(context)!.position;
    if (newPosition != _position) {
      _position?.removeListener(_handleOffsetChange);
      _position = newPosition;
      _position?.addListener(_handleOffsetChange);
    }
  }

  Widget renderBeforeRelease(double _offset);
  Widget renderAfterRelease();

  // Widget renderBeforeRelease(double _offset) {
  //   Widget? pullControl;
  //   if (_offset >= this.widget.maxReleaseHeight) {
  //     pullControl = Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [Icon(Icons.arrow_downward), Text("Release to refresh")],
  //     );
  //   } else {
  //     pullControl = Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [Icon(Icons.arrow_upward), Text("Pull to refresh")],
  //     );
  //   }
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 12.0),
  //     child: Align(
  //       alignment: Alignment.bottomCenter,
  //       child: ClipRect(
  //         // color: Colors.blue,
  //         child: pullControl,
  //       ),
  //     ),
  //   );
  // }

  // Widget renderAfterRelease() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(width: 15, height: 15, child: CupertinoActivityIndicator()),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 10),
  //           child: Text("Refreshing..."),
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var widgetHeight = 0.0;
    if (_offset > 0) {
      var offsetPercent = _offset / this.widget.maxReleaseHeight;
      widgetHeight = offsetPercent * this.widget.bounceToHeightAfterRelease;
      widgetHeight = widgetHeight > this.widget.bounceToHeightAfterRelease
          ? this.widget.bounceToHeightAfterRelease
          : widgetHeight;
      widgetHeight = widgetHeight < 1 ? 1 : widgetHeight;
      if (this.widget.isRefreshing) {
        widgetHeight = widgetHeight < this.widget.bounceToHeightAfterRelease
            ? this.widget.bounceToHeightAfterRelease
            : widgetHeight;
      }
    } else {
      if (this.widget.isRefreshing) {
        widgetHeight = this.widget.bounceToHeightAfterRelease;
      } else {
        widgetHeight = 0;
      }
    }
    Widget? child;
    if (this.widget.isRefreshing) {
      child = renderAfterRelease();
    } else {
      if (_offset > 0) {
        child = renderBeforeRelease(_offset);
      }
    }
    return SizedBox(
      height: widgetHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
              top: -_offset,
              left: 0,
              right: 0,
              height: _offset + widgetHeight,
              child: Container(
                child: child,
              ))
        ],
      ),
    );
  }
}
