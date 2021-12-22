import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'alphabetBindListModel.dart';

class AlphabetSticky<T> extends StatefulWidget {
  final List<AlphabetBindListModel>? listData;
  final SPAlphabetListViewHeaderWidgetBuilder<T> headerWidgetBuilder;

  AlphabetSticky({required this.headerWidgetBuilder, this.listData, Key? key})
      : super(key: key);

  @override
  AlphabetStickyState<T> createState() => AlphabetStickyState<T>();
}

class AlphabetStickyState<T> extends State<AlphabetSticky> {
  /// [_positions] passed by position scroll view and sort by itemTrailingEdge
  List<ItemPosition> _positions = [];

  double _viewportHeight = 0;
  bool _isBounceState = false;

  /// [_currentHeader]用于更新当前的sticky, 如果为null表示没有
  AlphabetBindListModel? _currentHeader;

  /// [_strickyPos] will update current sticky position
  double _strickyPos = 0;

  /// [_containerKey] will used to get height of stricky
  final _containerKey = GlobalKey();

  List<AlphabetBindListModel> get listData {
    return this.widget.listData ?? [];
  }

  updateScrollPixed(bool isScrollBounce, double viewportH) {
    this._viewportHeight = viewportH;
    this._isBounceState = isScrollBounce;
    this._mixHandlePosition();
  }

  updateItemPositions(List<ItemPosition> posList) {
    this._positions = posList;
    this._mixHandlePosition();
  }

  _mixHandlePosition() {
    AlphabetBindListModel? curr;
    double strickyPos = 0;
    if (this._isBounceState == false) {
      List<ItemPosition> posList = this._positions;
      if (posList.length > 0 && listData.length > posList[0].index) {
        curr = listData[posList[0].index];
        if (_containerKey.currentContext != null) {
          var stickyHeight = _containerKey.currentContext!.size?.height ?? 0;
          if (stickyHeight > 0) {
            // Get next header info
            for (var i = 1; i < this._positions.length; i++) {
              var item = this._positions[i];
              var itemData = listData[item.index];
              if (itemData.itemIndex == null) {
                var itemLeadingOffset =
                    this._viewportHeight * item.itemLeadingEdge;
                if (itemLeadingOffset < stickyHeight) {
                  AlphabetHeader _tem = itemData.headerData as AlphabetHeader;
                  // print(
                  //     "------>$itemLeadingOffset, item: ${_tem.alphabet}， _viewportHeight: $_viewportHeight");
                  strickyPos = itemLeadingOffset - stickyHeight;
                }
                break;
              }
            }
          }
        }
      }
    }

    // print("------2>$_viewportHeight");
    if (curr != this._currentHeader || strickyPos != this._strickyPos) {
      this.setState(() {
        this._currentHeader = curr;
        this._strickyPos = strickyPos;
      });
    }
  }

  AlphabetSticky<T> get ownWidget {
    return this.widget as AlphabetSticky<T>;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: _strickyPos,
        left: 0,
        right: 0,
        child: Container(
          key: _containerKey,
          child: this._currentHeader != null
              ? ownWidget.headerWidgetBuilder(context,
                  _currentHeader!.headerData, _currentHeader!.headerIndex)
              : SizedBox(
                  height: 0,
                ),
        ));
  }
}
