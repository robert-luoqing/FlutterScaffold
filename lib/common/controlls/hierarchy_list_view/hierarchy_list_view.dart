import 'package:flutter/material.dart';
import 'package:flutter_list_view/flutter_list_view.dart';

import 'hierarchy_list_data.dart';

typedef HierarchyListOnFetchListData = List<dynamic>? Function(
    {int hierarchyLevel, dynamic parent});
typedef HierarchyListOnRefresh = Future Function();

typedef HierarchyListRefreshWidgetBuilder = Widget Function(double offset);

typedef HierarchyListRefreshBuilder = Widget Function(Widget? child);
typedef HierarchyListItemBuilder = Widget Function(
  BuildContext context,
  dynamic itemData,
  int index,
  int hierarchyLevel,
  dynamic parentData,
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
      this.enableSticky = true,
      this.physics,
      Key? key})
      : super(key: key);

  final List<dynamic> source;
  final HierarchyListOnFetchListData onFetchListData;
  final HierarchyListItemBuilder itemBuilder;
  final HierarchyListRefreshBuilder? refreshBuilder;
  final bool enableSticky;
  final ScrollPhysics? physics;
  @override
  State<HierarchyListView> createState() => _HierarchyListViewState();
}

class _HierarchyListViewState extends State<HierarchyListView> {
  final FlutterListViewController _controller = FlutterListViewController();

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
    if (listData != null) {
      for (var item in listData) {
        var data = HierarchyListData(
          data: item,
          hierarchyLevel: hierarchyLevel,
          parentData: parentData,
          mapListIndex: mapListIndex,
        );
        buildData.add(data);
        mapListIndex++;

        var childListData = widget.onFetchListData(
            hierarchyLevel: hierarchyLevel, parent: item);

        mapListIndex = _buildHierarchy(
            buildData: buildData,
            listData: childListData,
            parentData: item,
            hierarchyLevel: hierarchyLevel + 1,
            mapListIndex: mapListIndex);
      }
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
    _listData = [];
    _buildHierarchy(
        buildData: _listData,
        listData: widget.source,
        parentData: null,
        hierarchyLevel: 0,
        mapListIndex: 0);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _getPhysicsIsBounce() {
    late ScrollPhysics physics;
    if (ownWidget.physics != null) {
      physics = ownWidget.physics!;
    } else {
      var sc = ScrollConfiguration.of(context);
      physics = sc.getScrollPhysics(context);
    }
    return physics is BouncingScrollPhysics;
  }

  Widget _renderList(bool isBouncePhysic) {
    Widget result = FlutterListView(
        delegate: FlutterListViewDelegate(
          (BuildContext context, int index) {
            HierarchyListData itemData = _listData[index];
            return ownWidget.itemBuilder(context, itemData.data, index,
                itemData.hierarchyLevel, itemData.parentData);
          },
          childCount: _listData.length,
          // onItemSticky: (index) {
          //   if (ownWidget.enableSticky) {
          //     final data = _listData[index];
          //     if (data.type == SectionViewDataType.dataHeader) {
          //       return true;
          //     }
          //   }

          //   return false;
          // }
        ),
        controller: _controller);

    if (ownWidget.refreshBuilder != null) {
      result = ownWidget.refreshBuilder!(result);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    var isBouncePhysic = _getPhysicsIsBounce();

    Widget content = Stack(
      children: [
        _renderList(isBouncePhysic),
      ],
    );

    return content;
  }
}
