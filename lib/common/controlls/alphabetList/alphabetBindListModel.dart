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
  int mapIndex;
  T headerData;
  int headerIndex;
}

class AlphabetBindListModel {
  AlphabetBindListModel(
      {required this.headerIndex,
      required this.headerData,
      this.itemData,
      this.itemIndex});
  int headerIndex;
  int? itemIndex;
  dynamic headerData;
  dynamic itemData;
}

class AlphabetHeader<T> {
  AlphabetHeader({required this.alphabet, required this.items});
  String alphabet;
  List<T> items;
}
