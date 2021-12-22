import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'alphabetBindListModel.dart';
import 'alphabetSticky.dart';

class SPAlphabetListView<T, N> extends StatefulWidget {
  final List<T> source;
  final SPAlphabetListViewOnFetchListData<T, N> onFetchListData;
  final SPAlphabetListViewHeaderWidgetBuilder<T> headerWidgetBuilder;
  final SPAlphabetListViewItemWidgetBuilder<T, N> itemWidgetBuilder;
  final SPAlphabetListViewAlphabetWidgetBuilder<T> alphabetWidgetBuilder;

  const SPAlphabetListView(
      {required this.source,
      required this.onFetchListData,
      required this.headerWidgetBuilder,
      required this.itemWidgetBuilder,
      required this.alphabetWidgetBuilder,
      Key? key})
      : super(key: key);

  @override
  _SPAlphabetListViewState<T, N> createState() =>
      _SPAlphabetListViewState<T, N>();
}

class _SPAlphabetListViewState<T, N> extends State<SPAlphabetListView> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  /// listData will used to bind [ScrollablePositionedList]
  List<AlphabetBindListModel> listData = [];

  /// Map header to index of [ScrollablePositionedList]
  List<AlphabetModel<T>> headerToIndexMap = [];

  /// It is top item on viewport, the headerData can be used to tracking
  /// current alphabet
  AlphabetBindListModel? topItem;

  final stickyKey = GlobalKey<AlphabetStickyState>();

  SPAlphabetListView<T, N> get ownWidget {
    return this.widget as SPAlphabetListView<T, N>;
  }

  _buildList() {
    List<AlphabetBindListModel> _buildData = [];
    List<AlphabetModel<T>> _buildMap = [];
    int _headerIndex = 0;
    int _listIndex = 0;
    for (T _header in this.ownWidget.source) {
      _buildData.add(AlphabetBindListModel(
          headerIndex: _headerIndex, headerData: _header));

      var _itemIndex = 0;
      _buildMap.add(AlphabetModel(
          mapIndex: _listIndex,
          headerData: _header,
          headerIndex: _headerIndex));

      _listIndex++;

      var _itemList = this.ownWidget.onFetchListData(_header);
      for (N _item in _itemList) {
        _buildData.add(AlphabetBindListModel(
            headerIndex: _headerIndex,
            headerData: _header,
            itemIndex: _itemIndex,
            itemData: _item));
        _itemIndex++;
        _listIndex++;
      }

      _headerIndex++;
    }

    this.listData = _buildData;
    this.headerToIndexMap = _buildMap;
  }

  void _positionsChanged() {
    Iterable<ItemPosition> positions =
        itemPositionsListener.itemPositions.value;

    if (positions.isNotEmpty) {
      List<ItemPosition> newPositions = positions
          .where((ItemPosition position) => position.itemTrailingEdge > 0)
          .toList();
      newPositions.sort((a, b) =>
          ((a.itemTrailingEdge - b.itemTrailingEdge) * 1000000).toInt());

      if (newPositions.length > 0) {
        var itemPosition = newPositions.first;
        int index = itemPosition.index;
        if (topItem != this.listData[index]) {
          this.setState(() {
            topItem = this.listData[index];
          });
        }
      } else {
        if (topItem != null) {
          this.setState(() {
            topItem = null;
          });
        }
      }

      if (stickyKey.currentState != null) {
        stickyKey.currentState!.updateItemPositions(newPositions);
      }
    } else {
      if (topItem != null) {
        this.setState(() {
          topItem = null;
        });
      }
      if (stickyKey.currentState != null) {
        stickyKey.currentState!.updateItemPositions([]);
      }
    }
  }

  @override
  void initState() {
    itemPositionsListener.itemPositions.addListener(_positionsChanged);
    this._buildList();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SPAlphabetListView oldWidget) {
    this._buildList();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    itemPositionsListener.itemPositions.removeListener(_positionsChanged);
    super.dispose();
  }

  Widget _renderRightAlphabet() {
    List<Widget> alphabetWidgets = [];
    for (var header in this.headerToIndexMap) {
      var _alphabetWidget = this.ownWidget.alphabetWidgetBuilder(
          context,
          header.headerData,
          header.headerIndex == this.topItem?.headerIndex,
          header.headerIndex);
      alphabetWidgets.add(GestureDetector(
          onTap: () {
            itemScrollController.jumpTo(index: header.mapIndex);
          },
          behavior: HitTestBehavior.opaque,
          child: _alphabetWidget));
    }
    return Positioned(
        top: 0,
        bottom: 0,
        right: 0,
        child: Center(
            child: Container(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: (Column(
              mainAxisSize: MainAxisSize.min,
              children: alphabetWidgets,
            )),
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            var metrics = notification.metrics;
            // print(
            //     "scroll: ${metrics.pixels}, ${metrics.extentBefore},${metrics.minScrollExtent}, ${metrics.maxScrollExtent}");
            if (stickyKey.currentState != null) {
              stickyKey.currentState!.updateScrollPixed(
                  metrics.pixels < metrics.minScrollExtent,
                  metrics.viewportDimension);
            }
            return false;
          },
          child: ScrollablePositionedList.builder(
            itemCount: this.listData.length,
            itemBuilder: (context, index) {
              AlphabetBindListModel itemData = this.listData[index];
              if (itemData.itemIndex == null) {
                return this.ownWidget.headerWidgetBuilder(
                    context, itemData.headerData, itemData.headerIndex);
              } else {
                return this.ownWidget.itemWidgetBuilder(
                    context,
                    itemData.itemData,
                    itemData.itemIndex!,
                    itemData.headerData,
                    itemData.headerIndex);
              }
            },
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
          ),
        ),
        AlphabetSticky<T>(
          listData: this.listData,
          headerWidgetBuilder: ownWidget.headerWidgetBuilder,
          key: stickyKey,
        ),
        this._renderRightAlphabet()
      ],
    ));
  }
}
