import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef SPListViewFunction = Future Function();

class SPListView extends StatefulWidget {
  final SPListViewFunction? onRefresh;
  final SPListViewFunction? onLoad;
  final Widget child;
  final bool enablePullDown;
  final bool enablePullUp;

  SPListView(
      {required this.child,
      this.onRefresh,
      this.onLoad,
      this.enablePullDown = false,
      this.enablePullUp = false});

  @override
  _SPListViewState createState() => _SPListViewState();
}

class _SPListViewState extends State<SPListView> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    if (this.widget.onRefresh != null) {
      await this.widget.onRefresh!();
    }

    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    if (this.widget.onLoad != null) {
      await this.widget.onLoad!();
    }

    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: this.widget.enablePullDown,
      enablePullUp: this.widget.enablePullUp,
      header: WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("pull up load");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("release to load more");
          } else {
            body = Text("No more Data");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: this.widget.child,
    );
  }
}
