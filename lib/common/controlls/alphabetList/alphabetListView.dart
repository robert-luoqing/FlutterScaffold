import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'alphabetBindListModel.dart';
import 'alphabetSideList.dart';
import 'alphabetSticky.dart';
import 'alphabetTip.dart';

class SPAlphabetListView<T, N> extends StatefulWidget {
  const SPAlphabetListView(
      {required this.source,
      required this.onFetchListData,
      required this.headerBuilder,
      required this.itemBuilder,
      this.alphabetAlign = Alignment.center,
      this.alphabetInset = const EdgeInsets.all(4.0),
      this.enableSticky = true,
      this.alphabetBuilder,
      this.alphabetTipBuilder,
      Key? key})
      : super(key: key);

  final List<T> source;
  final SPAlphabetListViewOnFetchListData<T, N> onFetchListData;
  final SPAlphabetListViewHeaderBuilder<T> headerBuilder;
  final SPAlphabetListViewItemBuilder<T, N> itemBuilder;
  final SPAlphabetListViewAlphabetBuilder<T>? alphabetBuilder;
  final SPAlphabetListViewTipBuilder<T>? alphabetTipBuilder;
  final bool enableSticky;
  final Alignment alphabetAlign;
  final EdgeInsets alphabetInset;

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

  final stickyKey = GlobalKey<AlphabetStickyState>();
  final alphabetTipKey = GlobalKey<AlphabetTipState>();
  final alphabetSideListKey = GlobalKey<AlphabetSideListState>();

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
        if (alphabetSideListKey.currentState != null) {
          alphabetSideListKey.currentState!.topItem = this.listData[index];
        }
      } else {
        if (alphabetSideListKey.currentState != null) {
          alphabetSideListKey.currentState!.topItem = null;
        }
      }

      if (stickyKey.currentState != null) {
        stickyKey.currentState!.updateItemPositions(newPositions);
      }
    } else {
      if (alphabetSideListKey.currentState != null) {
        alphabetSideListKey.currentState!.topItem = null;
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

  Widget _renderList() {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        var metrics = notification.metrics;
        if (stickyKey.currentState != null) {
          stickyKey.currentState!.updateScrollPixed(
              metrics.pixels <= metrics.minScrollExtent,
              metrics.viewportDimension);
        }
        return false;
      },
      child: ScrollablePositionedList.builder(
        itemCount: this.listData.length,
        itemBuilder: (context, index) {
          AlphabetBindListModel itemData = this.listData[index];
          if (itemData.itemIndex == null) {
            return this.ownWidget.headerBuilder(
                context, itemData.headerData, itemData.headerIndex);
          } else {
            return this.ownWidget.itemBuilder(context, itemData.itemData,
                itemData.itemIndex!, itemData.headerData, itemData.headerIndex);
          }
        },
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        this._renderList(),
        ownWidget.enableSticky
            ? AlphabetSticky<T>(
                listData: this.listData,
                headerBuilder: ownWidget.headerBuilder,
                key: stickyKey,
              )
            : Container(),
        AlphabetSideList<T>(
          alphabetBuilder: ownWidget.alphabetBuilder,
          headerToIndexMap: this.headerToIndexMap,
          alphabetAlign: ownWidget.alphabetAlign,
          alphabetInset: ownWidget.alphabetInset,
          key: alphabetSideListKey,
          onTap: <T>(item) {
            if (alphabetTipKey.currentState != null) {
              alphabetTipKey.currentState!.tipData = item.headerData;
            }
            itemScrollController.jumpTo(index: item.mapIndex);
          },
        ),
        AlphabetTip(
          alphabetTipBuilder: ownWidget.alphabetTipBuilder,
          key: alphabetTipKey,
        )
      ],
    ));
  }
}
