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

  const SPListView(
      {Key? key,
      required this.child,
      this.onRefresh,
      this.onLoad,
      this.enablePullDown = false,
      this.enablePullUp = false})
      : super(key: key);

  @override
  _SPListViewState createState() => _SPListViewState();
}

class _SPListViewState extends State<SPListView> {
  final _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    if (widget.onRefresh != null) {
      await widget.onRefresh!();
    }

    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    if (widget.onLoad != null) {
      await widget.onLoad!();
    }

    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: widget.enablePullDown,
      enablePullUp: widget.enablePullUp,
      header: WaterDropHeader(
        complete: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.done,
              color: Colors.grey,
            ),
            Container(
              width: 15.0,
            ),
            const Text(
              "Refershed",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const Text("pull up load");
          } else if (mode == LoadStatus.loading) {
            body = const CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = const Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = const Text("release to load more");
          } else {
            body = const Text("No more Data");
          }
          return SizedBox(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: widget.child,
    );
  }
}
