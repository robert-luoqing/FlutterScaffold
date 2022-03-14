import 'package:flutter/material.dart';
import 'package:flutter_list_view/flutter_list_view.dart';

import 'hierarchy_list_view.dart';

enum _MasterDetailHierarchyViewInnerStatus {
  collapse,
  isLoadingMore,
  expand,
}

enum MasterDetailHierarchyViewUIType { expand, loading, loadmore, collapse }

class MasterDetailHierarchyView extends StatefulWidget {
  const MasterDetailHierarchyView(
      {required this.source,
      required this.onFetchListData,
      required this.itemBuilder,
      this.refreshBuilder,
      this.physics,
      this.rebuildListOnlySourceMutation = false,
      this.onItemSticky,
      this.controller,
      this.onFetchMoreDetails,
      this.footerBuilder,
      this.hasMore,
      this.initDetailCount = 10,
      required this.onFetchKey,
      Key? key})
      : super(key: key);

  final List<dynamic> source;
  final HierarchyListOnFetchListData onFetchListData;
  final HierarchyListItemBuilder itemBuilder;
  final HierarchyListRefreshBuilder? refreshBuilder;
  final ScrollPhysics? physics;

  /// [rebuildListOnlySourceMutation] == true, Only the passed source mutated, the list will rebuild
  /// [rebuildListOnlySourceMutation] == false, that mean didUpdateWidget will cause list rebuild in every time
  final bool rebuildListOnlySourceMutation;

  final HierarchyListOnItemSticky? onItemSticky;
  final FlutterListViewController? controller;

  final Future Function(dynamic itemData, int parentMapListIndex)?
      onFetchMoreDetails;
  final Widget? Function(
      BuildContext context,
      MasterDetailHierarchyViewUIType type,
      dynamic itemData,
      int parentMapListIndex,
      Function() callback)? footerBuilder;

  final bool Function(dynamic itemData)? hasMore;

  final int initDetailCount;

  final String Function(dynamic itemData) onFetchKey;

  @override
  State<MasterDetailHierarchyView> createState() =>
      MasterDetailHierarchyViewState();
}

class MasterDetailHierarchyViewState extends State<MasterDetailHierarchyView> {
  /// key is id, value: state
  var dataStatus = <String, _MasterDetailHierarchyViewInnerStatus>{};
  final _localController = FlutterListViewController();

  FlutterListViewController get controller {
    if (widget.controller == null) {
      return _localController;
    } else {
      return widget.controller!;
    }
  }

  @override
  dispose() {
    _localController.dispose();
    super.dispose();
  }

  String getIdFromItemData(dynamic itemData) {
    return widget.onFetchKey(itemData);
  }

  get initDetailCount {
    return widget.initDetailCount;
  }

  Widget? _footerBuilder(
      context, itemData, index, hierarchyLevel, parentMapListIndex) {
    if (hierarchyLevel > 0) {
      // 少于指定个及指定个个的不显示footer
      var detailList = widget.onFetchListData(hierarchyLevel, itemData);
      var hasMore = false;
      if (widget.hasMore != null) {
        hasMore = widget.hasMore!(itemData);
      }
      if (hasMore == false && (detailList?.length ?? 0) <= initDetailCount) {
        return null;
      }
      if (widget.footerBuilder != null) {
        switch (dataStatus[getIdFromItemData(itemData)] ??
            _MasterDetailHierarchyViewInnerStatus.expand) {
          case _MasterDetailHierarchyViewInnerStatus.collapse:
            return widget.footerBuilder!(
                context,
                MasterDetailHierarchyViewUIType.expand,
                itemData,
                parentMapListIndex, () {
              setState(() {
                dataStatus[widget.onFetchKey(itemData)] =
                    _MasterDetailHierarchyViewInnerStatus.expand;
              });
            });
          case _MasterDetailHierarchyViewInnerStatus.isLoadingMore:
            return widget.footerBuilder!(
                context,
                MasterDetailHierarchyViewUIType.loading,
                itemData,
                parentMapListIndex,
                () {});
          case _MasterDetailHierarchyViewInnerStatus.expand:
            var hasMore = false;
            if (widget.hasMore != null) {
              hasMore = widget.hasMore!(itemData);
            }
            if (hasMore) {
              return widget.footerBuilder!(
                  context,
                  MasterDetailHierarchyViewUIType.loadmore,
                  itemData,
                  parentMapListIndex, () async {
                setState(() {
                  dataStatus[widget.onFetchKey(itemData)] =
                      _MasterDetailHierarchyViewInnerStatus.isLoadingMore;
                });
                try {
                  if (widget.onFetchMoreDetails != null) {
                    await widget.onFetchMoreDetails!(
                        itemData, parentMapListIndex);
                  }
                } finally {
                  setState(() {
                    dataStatus[widget.onFetchKey(itemData)] =
                        _MasterDetailHierarchyViewInnerStatus.expand;
                  });
                }
              });
            } else {
              return widget.footerBuilder!(
                  context,
                  MasterDetailHierarchyViewUIType.collapse,
                  itemData,
                  parentMapListIndex, () {
                setState(() {
                  controller.sliverController.ensureVisible(parentMapListIndex);
                  dataStatus[widget.onFetchKey(itemData)] =
                      _MasterDetailHierarchyViewInnerStatus.collapse;
                });
              });
            }
        }
      }
    }
    return null;
  }

  Widget _itemBuilder(context, itemData, index, hierarchyLevel, parentData,
      parentMapListIndex) {
    if (parentData != null &&
        dataStatus[widget.onFetchKey(parentData)] ==
            _MasterDetailHierarchyViewInnerStatus.collapse &&
        index > initDetailCount) {
      return Container();
    } else {
      return widget.itemBuilder(context, itemData, index, hierarchyLevel,
          parentData, parentMapListIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return HierarchyListView(
      source: widget.source,
      controller: widget.controller,
      onFetchListData: widget.onFetchListData,
      itemBuilder: _itemBuilder,
      footerBuilder: _footerBuilder,
      refreshBuilder: widget.refreshBuilder,
      physics: widget.physics,
      rebuildListOnlySourceMutation: widget.rebuildListOnlySourceMutation,
      onItemSticky: widget.onItemSticky,
    );
  }
}
