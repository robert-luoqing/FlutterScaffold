import 'package:flutter/material.dart';
import 'package:flutter_list_view/flutter_list_view.dart';
import 'package:lingo_dragon/common/widgets/scaffold.dart';

class TestFlutterListViewPerformance extends StatefulWidget {
  const TestFlutterListViewPerformance({Key? key}) : super(key: key);

  @override
  _TestFlutterListViewPerformanceState createState() =>
      _TestFlutterListViewPerformanceState();
}

class _TestFlutterListViewPerformanceState
    extends State<TestFlutterListViewPerformance> {
  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: const Text("List view"),
        body: FlutterListView(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ListTile(
              title: Text("List Item $index"),
            );
          },
          childCount: 1000000,
        )));
  }
}
