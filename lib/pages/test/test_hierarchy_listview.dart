import 'package:flutter/material.dart';
import 'package:flutter_list_view/flutter_list_view.dart';
import 'package:lingo_dragon/common/widgets/hierarchy_list_view/hierarchy_list_view.dart';
import 'package:lingo_dragon/common/widgets/scaffold.dart';

class TestHierarchyListView extends StatefulWidget {
  const TestHierarchyListView({Key? key}) : super(key: key);

  @override
  State<TestHierarchyListView> createState() => _TestHierarchyListViewState();
}

class _TestHierarchyListViewState extends State<TestHierarchyListView> {
  var data = <TestHierarchyModel>[];
  var controller = FlutterListViewController();

  /// key is id, value: state
  var dataStatus = <int, LoadStatus>{};
  var id = 1;

  @override
  void initState() {
    for (var i = 0; i < 10; i++) {
      var comment = TestHierarchyModel(id: id, title: "Comment $i");
      data.add(comment);
      id++;
      comment.replies = [];
      for (var j = 0; j < 5; j++) {
        var reply = TestHierarchyModel(id: id, title: "Reply $j of Comment $i");
        comment.replies!.add(reply);
        id++;
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _fetchMoreReplies(TestHierarchyModel itemData) async {
    await Future.delayed(Duration(seconds: 1));
    for (var i = 0; i < 5; i++) {
      itemData.replies!.add(TestHierarchyModel(
          id: id,
          title: "Reply ${itemData.replies!.length + 1} of ${itemData.title}"));
      id++;
    }
    if (itemData.replies!.length > 20) {
      itemData.hasMore = false;
    }

    setState(() {
      dataStatus[itemData.id] = LoadStatus.expand;
    });
  }

  _clickFooter(TestHierarchyModel itemData, int parentMapListIndex) {
    switch (dataStatus[itemData.id] ?? LoadStatus.expand) {
      case LoadStatus.collapse:
        setState(() {
          dataStatus[itemData.id] = LoadStatus.expand;
        });
        break;
      case LoadStatus.isLoadingMore:
        // Do nothing
        break;
      case LoadStatus.expand:
        if (itemData.hasMore) {
          setState(() {
            dataStatus[itemData.id] = LoadStatus.isLoadingMore;
          });
          _fetchMoreReplies(itemData);
        } else {
          controller.sliverController.ensureVisible(parentMapListIndex);
          setState(() {
            dataStatus[itemData.id] = LoadStatus.collapse;
          });
        }
        break;
    }
  }

  Widget? _footerBuilder(
      context, itemData, index, hierarchyLevel, parentMapListIndex) {
    if (hierarchyLevel > 0) {
      var data = itemData as TestHierarchyModel;
      // 少于5个及5个的不显示footer
      if (data.hasMore == false && (data.replies?.length ?? 0) <= 5) {
        return null;
      }

      var text = "Expand";
      switch (dataStatus[data.id] ?? LoadStatus.expand) {
        case LoadStatus.collapse:
          text = "Expand";
          break;
        case LoadStatus.isLoadingMore:
          text = "Loading...";
          break;
        case LoadStatus.expand:
          if (data.hasMore) {
            text = "Load more";
          } else {
            text = "Collapse";
          }
          break;
      }

      return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
          child: Text(
            text,
            style: const TextStyle(color: Colors.green),
          ),
        ),
        onTap: () {
          _clickFooter(itemData, parentMapListIndex);
        },
      );
    }
    return null;
  }

  Widget _itemBuilder(context, itemData, index, hierarchyLevel, parentData,
      parentMapListIndex) {
    var data = itemData as TestHierarchyModel;
    if (parentData != null &&
        dataStatus[parentData.id] == LoadStatus.collapse &&
        index > 5) {
      return Container();
    } else {
      if (hierarchyLevel == 0) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(data.title),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
          child: Text(data.title),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: const Text("Test hierarchy list view"),
        body: HierarchyListView(
          source: data,
          controller: controller,
          onFetchListData: (hierarchyLevel, parent) {
            var parentData = parent as TestHierarchyModel;
            return parentData.replies;
          },
          itemBuilder: _itemBuilder,
          footerBuilder: _footerBuilder,
        ));
  }
}

class TestHierarchyModel {
  TestHierarchyModel(
      {required this.id, required this.title, this.hasMore = true});
  int id;
  String title;
  List<TestHierarchyModel>? replies;
  bool hasMore;
}

enum LoadStatus {
  collapse,
  isLoadingMore,
  expand,
}
