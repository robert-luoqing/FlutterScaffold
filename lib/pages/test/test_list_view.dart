import '../../common/controlls/listview.dart';
import 'package:flutter/material.dart';

class TestListView extends StatefulWidget {
  const TestListView({Key? key}) : super(key: key);

  @override
  _TestListViewState createState() => _TestListViewState();
}

class _TestListViewState extends State<TestListView> {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("List view"),
        ),
        body: SPListView(
            enablePullDown: true,
            enablePullUp: true,
            child: ListView.builder(
              itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
              itemExtent: 100.0,
              itemCount: items.length,
            )));
  }
}
