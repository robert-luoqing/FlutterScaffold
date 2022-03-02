import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';

import 'listview.dart';

class ExpandHeaderTabView extends StatefulWidget {
  const ExpandHeaderTabView({Key? key}) : super(key: key);

  @override
  State<ExpandHeaderTabView> createState() => _ExpandHeaderTabViewState();
}

class _ExpandHeaderTabViewState extends State<ExpandHeaderTabView>
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
    return SPListView(
        enablePullDown: true,
        enablePullUp: true,
        child: ExtendedNestedScrollView(
            headerSliverBuilder: (BuildContext c, bool f) {
              return <Widget>[
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 200.0,
                  flexibleSpace: FlexibleSpaceBar(
                    //centerTitle: true,
                    collapseMode: CollapseMode.pin,
                    background: Image.asset(
                      'assets/icons/googleIcon.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  bottom: TabBar(
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
                  ),
                )
              ];
            },
            //2.[inner scrollables in tabview sync issue](https://github.com/flutter/flutter/issues/21868)
            onlyOneScrollInBody: true,
            body: TabBarView(controller: _tabController, children: <Widget>[
              Container(
                child: Text("tab1"),
              ),
              Container(
                child: Text("tab2"),
              )
            ])));
  }
}
