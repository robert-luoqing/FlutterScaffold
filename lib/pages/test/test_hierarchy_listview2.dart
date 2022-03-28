import 'package:flutter/material.dart';
import 'package:flutter_list_view/flutter_list_view.dart';
import 'package:lingo_dragon/common/widgets/hierarchy_list_view/master_detail_hierarchy_view.dart';
import 'package:lingo_dragon/common/widgets/scaffold.dart';

class TestHierarchyListView2 extends StatefulWidget {
  const TestHierarchyListView2({Key? key}) : super(key: key);

  @override
  State<TestHierarchyListView2> createState() => _TestHierarchyListView2State();
}

class _TestHierarchyListView2State extends State<TestHierarchyListView2> {
  var data = <TestHierarchyModel>[];
  var controller = FlutterListViewController();

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

  Future _fetchMoreReplies(dynamic itemData, int parentMapListIndex) async {
    await Future.delayed(const Duration(seconds: 1));
    var data = itemData as TestHierarchyModel;
    for (var i = 0; i < 5; i++) {
      data.replies!.add(TestHierarchyModel(
          id: id, title: "Reply ${data.replies!.length + 1} of ${data.title}"));
      id++;
    }
    if (data.replies!.length > 20) {
      data.hasMore = false;
    }
  }

  Widget? _footerBuilder(
      BuildContext context,
      MasterDetailHierarchyViewUIType type,
      dynamic itemData,
      int parentMapListIndex,
      Function() callback) {
    var text = "Expand";
    switch (type) {
      case MasterDetailHierarchyViewUIType.expand:
        text = "Expand";
        break;
      case MasterDetailHierarchyViewUIType.loading:
        text = "Loading...";
        break;
      case MasterDetailHierarchyViewUIType.loadmore:
        text = "Load more";
        break;
      case MasterDetailHierarchyViewUIType.collapse:
        text = "Collapse";
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
        callback();
      },
    );
  }

  Widget _itemBuilder(BuildContext context, dynamic itemData, int index,
      int hierarchyLevel, dynamic parentData, int parentMapListIndex) {
    var data = itemData as TestHierarchyModel;
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

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: const Text("Test hierarchy list view"),
        body: MasterDetailHierarchyView(
            source: data,
            controller: controller,
            onFetchListData: (hierarchyLevel, parent) {
              var parentData = parent as TestHierarchyModel;
              return parentData.replies;
            },
            initDetailCount: 5,
            itemBuilder: _itemBuilder,
            footerBuilder: _footerBuilder,
            onFetchMoreDetails: _fetchMoreReplies,
            onFetchKey: (itemData) =>
                (itemData as TestHierarchyModel).id.toString(),
            hasMore: (itemData) => (itemData as TestHierarchyModel).hasMore));
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
