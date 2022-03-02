import 'package:flutter/material.dart';
import 'package:lingo_dragon/common/controlls/expand_header_tab_view.dart';

class TestExpandTabview extends StatefulWidget {
  const TestExpandTabview({Key? key}) : super(key: key);

  @override
  State<TestExpandTabview> createState() => _TestExpandTabviewState();
}

class _TestExpandTabviewState extends State<TestExpandTabview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Test Expand Header Tabview"),
        ),
        body: ExpandHeaderTabView());
  }
}
