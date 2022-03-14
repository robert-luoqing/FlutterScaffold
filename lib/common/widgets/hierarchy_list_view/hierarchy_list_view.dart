import 'package:flutter/material.dart';
import 'package:flutter_list_view/flutter_list_view.dart';

import 'hierarchy_list_data.dart';

typedef HierarchyListOnFetchListData = List<dynamic>? Function(
    int hierarchyLevel, dynamic parent);

typedef HierarchyListRefreshBuilder = Widget Function(Widget? child);
typedef HierarchyListFooterBuilder = Widget? Function(
  BuildContext context,
  dynamic itemData,
  int index,
  int hierarchyLevel,
  int parentMapListIndex,
);

typedef HierarchyListItemBuilder = Widget Function(
  BuildContext context,
  dynamic itemData,
  int index,
  int hierarchyLevel,
  dynamic parentData,
  int parentMapListIndex,
);

typedef HierarchyListOnItemSticky = bool Function(
  dynamic itemData,
  int index,
  int hierarchyLevel,
  dynamic parentData,
  int parentMapListIndex,
);

/// The widget is used to wrap Hierarchy list
/// Like comment, reply comment etc.
/// comment1
///   reply1
///   reply2
///   <button>more</button>
///  comment2
///   reply21
///   reply22
///   ........
/// Click more, show progress and fetch more reply of comment1.
/// Widget can control if the more button show up or collapse reply button show up etc.
class HierarchyListView extends StatefulWidget {
  const HierarchyListView(
      {required this.source,
      required this.onFetchListData,
      required this.itemBuilder,
      this.refreshBuilder,
      this.physics,
      this.footerBuilder,
      this.rebuildListOnlySourceMutation = false,
      this.onItemSticky,
      this.controller,
      Key? key})
      : super(key: key);

  final List<dynamic> source;
  final HierarchyListOnFetchListData onFetchListData;
  final HierarchyListItemBuilder itemBuilder;
  final HierarchyListRefreshBuilder? refreshBuilder;
  final ScrollPhysics? physics;

  /// [footerBuilder] to create footer of each level
  /// You can handle it like "load more", "collapse" function etc.
  final HierarchyListFooterBuilder? footerBuilder;

  /// [rebuildListOnlySourceMutation] == true, Only the passed source mutated, the list will rebuild
  /// [rebuildListOnlySourceMutation] == false, that mean didUpdateWidget will cause list rebuild in every time
  final bool rebuildListOnlySourceMutation;

  final HierarchyListOnItemSticky? onItemSticky;
  final FlutterListViewController? controller;

  @override
  State<HierarchyListView> createState() => _HierarchyListViewState();
}

class _HierarchyListViewState extends State<HierarchyListView> {
  /// listData will used to bind [FlutterListView]
  List<HierarchyListData> _listData = [];

  HierarchyListView get ownWidget {
    return widget;
  }

  int _buildHierarchy(
      {required List<HierarchyListData> buildData,
      List<dynamic>? listData,
      dynamic parentData,
      required int hierarchyLevel,
      required int mapListIndex}) {
    var parentMapListIndex = mapListIndex - 1;
    if (parentMapListIndex < 0) {
      parentMapListIndex = 0;
    }

    if (listData != null) {
      for (var i = 0; i < listData.length; i++) {
        var item = listData[i];
        var data = HierarchyListData(
          type: HierarchyListDataType.data,
          data: item,
          hierarchyLevel: hierarchyLevel,
          parentData: parentData,
          mapListIndex: mapListIndex,
          indexInParent: i,
          parentMapListIndex: parentMapListIndex,
        );
        buildData.add(data);
        mapListIndex++;

        var childListData = widget.onFetchListData(hierarchyLevel, item);

        mapListIndex = _buildHierarchy(
          buildData: buildData,
          listData: childListData,
          parentData: item,
          hierarchyLevel: hierarchyLevel + 1,
          mapListIndex: mapListIndex,
        );
      }

      // Create footer item
      // Footer Widget will be null
      var footerData = HierarchyListData(
        type: HierarchyListDataType.footer,
        data: null,
        hierarchyLevel: hierarchyLevel,
        parentData: parentData,
        mapListIndex: mapListIndex,
        parentMapListIndex: parentMapListIndex,
      );
      buildData.add(footerData);
      mapListIndex++;
    }

    return mapListIndex;
  }

  @override
  void initState() {
    _listData = [];
    _buildHierarchy(
        buildData: _listData,
        listData: widget.source,
        parentData: null,
        hierarchyLevel: 0,
        mapListIndex: 0);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HierarchyListView oldWidget) {
    bool needRebuild = true;
    if (widget.rebuildListOnlySourceMutation &&
        oldWidget.source == widget.source) {
      needRebuild = false;
    }

    if (needRebuild) {
      _listData = [];
      _buildHierarchy(
          buildData: _listData,
          listData: widget.source,
          parentData: null,
          hierarchyLevel: 0,
          mapListIndex: 0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _onItemSticky(int index) {
    if (ownWidget.onItemSticky != null) {
      final data = _listData[index];
      return ownWidget.onItemSticky!(data.data, data.indexInParent,
          data.hierarchyLevel, data.parentData, data.parentMapListIndex);
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    Widget result = FlutterListView(
        physics: ownWidget.physics,
        delegate: FlutterListViewDelegate(
          (BuildContext context, int index) {
            HierarchyListData itemData = _listData[index];
            if (itemData.type == HierarchyListDataType.data) {
              return ownWidget.itemBuilder(
                  context,
                  itemData.data,
                  itemData.indexInParent,
                  itemData.hierarchyLevel,
                  itemData.parentData,
                  itemData.parentMapListIndex);
            } else {
              Widget? footerWidget;
              if (ownWidget.footerBuilder != null) {
                footerWidget = ownWidget.footerBuilder!(
                    context,
                    itemData.parentData,
                    0,
                    itemData.hierarchyLevel,
                    itemData.parentMapListIndex);
              }
              footerWidget ??= const SizedBox(height: 0);
              return footerWidget;
            }
          },
          childCount: _listData.length,
          onItemSticky: _onItemSticky,
        ),
        controller: widget.controller);

    if (ownWidget.refreshBuilder != null) {
      result = ownWidget.refreshBuilder!(result);
    }

    return result;
  }
}
