import 'package:flutter/material.dart';
import 'package:lingo_dragon/common/controlls/expand_header_tab_view.dart';
import 'package:lingo_dragon/common/controlls/listview.dart';

class TestExpandTabview extends StatefulWidget {
  const TestExpandTabview({Key? key}) : super(key: key);

  @override
  State<TestExpandTabview> createState() => _TestExpandTabviewState();
}

class _TestExpandTabviewState extends State<TestExpandTabview>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Test Expand Header Tabview"),
        ),
        body: ExpandHeaderTabView(
          minExtend: 50,
          maxExtend: 150,
          refreshControlBuilder: (child) => SPListView(
              enablePullDown: true,
              enablePullUp: false,
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 3));
              },
              child: child),
          headerControlBuilder: (offset) => Stack(
            children: [
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 65,
                  child: Text("shrinkOffset:${offset.toStringAsFixed(1)}",
                      style:
                          const TextStyle(fontSize: 20, color: Colors.white))),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.blue,
                    indicatorColor: Colors.blue,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 2.0,
                    isScrollable: false,
                    unselectedLabelColor: Colors.grey,
                    tabs: const <Tab>[
                      Tab(text: 'Tab0'),
                      Tab(text: 'Tab1'),
                    ],
                  )),
            ],
          ),
          child: TabBarView(controller: _tabController, children: <Widget>[
            SPListView(
                enablePullDown: false,
                enablePullUp: true,
                onLoad: () async {
                  await Future.delayed(Duration(seconds: 2));
                },
                child: ListView.builder(
                  itemBuilder: (c, i) =>
                      Card(child: Center(child: Text(i.toString()))),
                  itemExtent: 100.0,
                  itemCount: 20,
                  physics: const ClampingScrollPhysics(),
                )),
            ListView.builder(
              itemBuilder: (c, i) =>
                  Card(child: Center(child: Text(i.toString()))),
              itemExtent: 100.0,
              itemCount: 20,
              physics: const ClampingScrollPhysics(),
            )
          ]),
        ));
  }
}
