import 'package:flutter/material.dart';
import 'package:lingo_dragon/common/widgets/expand_header_tab_view.dart';
import 'package:lingo_dragon/common/widgets/listview.dart';
import 'package:lingo_dragon/common/widgets/measure_size.dart';

class TestExpandTabview extends StatefulWidget {
  const TestExpandTabview({Key? key}) : super(key: key);

  @override
  State<TestExpandTabview> createState() => _TestExpandTabviewState();
}

class _TestExpandTabviewState extends State<TestExpandTabview>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  double maxExtend = 50;
  List<String> texts = ["33333"];
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      for (var i = 0; i < 10; i++) {
        texts.add((i.toString()));
      }
      setState(() {});
    });
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
          maxExtend: maxExtend,
          pinnedHeaderSliverHeightBuilder:() => 50,
          refreshControlBuilder: _buildRefreshControl,
          sliverBuilder: () {
            return [
              SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: PersistentHeaderBuilder(
                      builder: (ctx, offset) =>
                          SizedBox(height: maxExtend, child: _buildHeader()),
                      min: 50,
                      max: maxExtend)),
    
            ];
          },
          // headerControlBuilder: (offset) => _buildHeader(),
          child: TabBarView(controller: _tabController, children: <Widget>[
            SPListView(
                enablePullDown: false,
                enablePullUp: true,
                onLoad: () async {
                  await Future.delayed(const Duration(seconds: 2));
                },
                child: ListView.builder(
                  itemBuilder: (c, i) =>
                      Card(child: Center(child: Text(i.toString()))),
                  itemExtent: 100.0,
                  itemCount: 20,
                  physics: const ClampingScrollPhysics(),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: const Text("Test..."),
            )
          ]),
        ));

  }

  Widget _buildRefreshControl(Widget child) {
    return SPListView(
        enablePullDown: true,
        enablePullUp: false,
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 3));
        },
        child: child);
  }

  _buildHeader() {
    return Stack(
      children: [
        Positioned(
            left: 0,
            right: 0,
            bottom: 65,
            child: MeasureSize(
                child: Column(children: texts.map((e) => Text(e)).toList()),
                onChange: (size) {
                  setState(() {
                    maxExtend = 50 + size.height;
                  });
                })),
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
    );
  }
}
