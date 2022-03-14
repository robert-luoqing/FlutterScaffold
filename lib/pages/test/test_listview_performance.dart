import 'package:flutter/material.dart';
import 'package:lingo_dragon/common/widgets/scaffold.dart';

class TestListViewPerformance extends StatefulWidget {
  const TestListViewPerformance({Key? key}) : super(key: key);

  @override
  _TestListViewPerformanceState createState() =>
      _TestListViewPerformanceState();
}

class _TestListViewPerformanceState extends State<TestListViewPerformance> {
  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: const Text("List view"),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("List Item $index"),
            );
          },
          itemCount: 1000000,
        ));
  }
}
