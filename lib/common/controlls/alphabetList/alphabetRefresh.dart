import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'alphabetBindListModel.dart';

class AlphabetRefresh extends StatefulWidget {
  const AlphabetRefresh({required this.onRefresh, Key? key}) : super(key: key);
  final SPAlphabetListViewRefresh onRefresh;

  @override
  _AlphabetRefreshState createState() => _AlphabetRefreshState();
}

class _AlphabetRefreshState extends State<AlphabetRefresh>
    with SingleTickerProviderStateMixin {
  bool _isRefreshing = false;
  double _maxRefreshHeight = 50;
  double _refreshWaitControlHeight = 40;
  double _offset = 0;
  ScrollPosition? _position;
  late AnimationController _animation;

  @override
  void initState() {
    _animation = AnimationController(vsync: this);
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
    _animation.dispose();

    super.dispose();
  }

  void _doRefreshAction() async {
    try {
      await this.widget.onRefresh();
    } catch (e, s) {
      // Do nothing
    }
    _isRefreshing = false;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      this.setState(() {});
    });
  }

  void _handleOffsetChange() {
    if (_position != null) {
      var pixels = _position?.pixels ?? 0.0;
      var minExtent = _position?.minScrollExtent ?? 0.0;
      ScrollActivity? activity = _position?.activity;
      var offset = minExtent - pixels;
      // print(
      //     "------->pixels:${_position?.pixels},outOfRange: ${_position?.outOfRange}, minScrollExtent: ${_position?.minScrollExtent},maxScrollExtent: ${_position?.maxScrollExtent}, activity: ${activity}");
      if (offset < 0) {
        offset = 0;
      }

      if (_offset != offset) {
        _offset = offset;
        if (offset >= _maxRefreshHeight &&
            activity is BallisticScrollActivity &&
            _isRefreshing == false) {
          _isRefreshing = true;
          // Do refresh action
          _doRefreshAction();
        }
        setState(() {});
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

  @override
  Widget build(BuildContext context) {
    var widgetHeight = 0.0;
    if (_offset > 0) {
      var offsetPercent = _offset / this._maxRefreshHeight;
      widgetHeight = offsetPercent * _refreshWaitControlHeight;
      widgetHeight = widgetHeight > _refreshWaitControlHeight
          ? _refreshWaitControlHeight
          : widgetHeight;
      widgetHeight = widgetHeight < 1 ? 1 : widgetHeight;
      if (_isRefreshing) {
        widgetHeight = widgetHeight < _refreshWaitControlHeight
            ? _refreshWaitControlHeight
            : widgetHeight;
      }
    } else {
      if (_isRefreshing) {
        widgetHeight = _refreshWaitControlHeight;
      } else {
        widgetHeight = 0;
      }
    }
    Widget? child;
    if (_isRefreshing) {
      child = Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 15, height: 15, child: CupertinoActivityIndicator()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("Refreshing..."),
            )
          ],
        ),
      );
    } else {
      if (_offset > 0) {
        Widget? pullControl;
        if (_offset >= _maxRefreshHeight) {
          pullControl = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Icon(Icons.arrow_downward), Text("Release to refresh")],
          );
        } else {
          pullControl = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Icon(Icons.arrow_upward), Text("Pull to refresh")],
          );
        }
        child = Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ClipRect(
              // color: Colors.blue,
              child: pullControl,
            ),
          ),
        );
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
