import 'package:flutter/material.dart';

typedef SPAlphabetListViewOnFetchListData<T, N> = List<N> Function(
    T sourceItem);
typedef SPAlphabetListViewOnFetchAlphabet<T> = String Function(T header);
typedef SPAlphabetListViewItemBuilder<T, N> = Widget Function(
  BuildContext context,
  N itemData,
  int itemIndex,
  T headerData,
  int headerIndex,
);
typedef SPAlphabetListViewHeaderBuilder<T> = Widget Function(
    BuildContext context, T headerData, int headerIndex);

typedef SPAlphabetListViewAlphabetBuilder<T> = Widget Function(
    BuildContext context, T headerData, bool isCurrent, int headerIndex);

typedef SPAlphabetListViewTipBuilder<T> = Widget Function(
    BuildContext context, T headerData);

typedef SPAlphabetListViewRefresh = Future Function();

typedef SPAlphabetRefreshWidgetBuilder = Widget Function(double offset);

typedef SPAlphabetListViewRefreshBuilder = Widget Function(bool isRefreshing,
    SPAlphabetListViewRefresh onRefresh, bool isBouncePhysic, Widget? child);

List<AlphabetHeader<T>> convertListToAlphaHeader<T>(
    Iterable<T> data, SPAlphabetListViewOnFetchAlphabet onAlphabet) {
  List<AlphabetHeader<T>> result = [];
  Map<String, List<T>> map = {};
  for (var item in data) {
    var alphabet = onAlphabet(item);
    if (!map.containsKey(alphabet)) {
      var header = AlphabetHeader<T>(alphabet: alphabet, items: []);
      result.add(header);
      map[alphabet] = header.items;
    }
    map[alphabet]!.add(item);
  }

  return result;
}

class AlphabetModel<T> {
  AlphabetModel(
      {required this.mapIndex,
      required this.headerData,
      required this.headerIndex});

  /// [mapIndex] is used to indicate the index of list data
  int mapIndex;
  T headerData;

  /// [headerIndex] is the index of header list
  int headerIndex;
}

enum AlphabetBindListModelType { dataHeader, dataItem, refresh, loading }

class AlphabetBindListModel {
  AlphabetBindListModel(
      {required this.type,
      required this.headerIndex,
      required this.headerData,
      this.itemData,
      this.itemIndex});
  AlphabetBindListModelType type;

  /// [headerIndex] is the index of header list
  int headerIndex;
  dynamic headerData;

  /// [itemIndex] is the index of header's list
  /// it is null if type is not dataItem
  int? itemIndex;

  /// it is null if type is not dataItem
  dynamic itemData;
}

class AlphabetHeader<T> {
  AlphabetHeader({required this.alphabet, required this.items});
  String alphabet;
  List<T> items;
}
