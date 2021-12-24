import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'alphabetBindListModel.dart';
import 'alphabetRefresh.dart';

class AlphabetBouncingScrollRefresh extends AlphabetRefresh {
  const AlphabetBouncingScrollRefresh(
      {required bool isRefreshing,
      required SPAlphabetListViewRefresh onRefresh,
      double maxReleaseHeight = 50,
      double bounceToHeightAfterRelease = 40,
      this.releaseToRefreshText = "Release to refresh",
      this.pullToRefreshText = "Pull to refresh",
      this.refreshingText = "Refreshing...",
      Key? key})
      : super(
            isRefreshing: isRefreshing,
            onRefresh: onRefresh,
            maxReleaseHeight: maxReleaseHeight,
            bounceToHeightAfterRelease: bounceToHeightAfterRelease,
            key: key);
  final String releaseToRefreshText;
  final String pullToRefreshText;
  final String refreshingText;
  @override
  _AlphabetBouncingScrollRefreshState createState() =>
      _AlphabetBouncingScrollRefreshState();
}

class _AlphabetBouncingScrollRefreshState extends AlphabetRefreshState {
  AlphabetBouncingScrollRefresh get ownWidget {
    return this.widget as AlphabetBouncingScrollRefresh;
  }

  @override
  Widget renderBeforeRelease(double _offset) {
    Widget? pullControl;
    if (_offset >= this.widget.maxReleaseHeight) {
      pullControl = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.arrow_downward),
          Text(ownWidget.releaseToRefreshText)
        ],
      );
    } else {
      pullControl = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Icon(Icons.arrow_upward), Text(ownWidget.pullToRefreshText)],
      );
    }
    return Padding(
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

  @override
  Widget renderAfterRelease() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 15, height: 15, child: CupertinoActivityIndicator()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(ownWidget.refreshingText),
          )
        ],
      ),
    );
  }
}
