import '../../common/widgets/listview.dart';
import 'package:flutter/material.dart';

class TestSliverView extends StatefulWidget {
  const TestSliverView({Key? key}) : super(key: key);

  @override
  _TestSliverViewState createState() => _TestSliverViewState();
}

class _TestSliverViewState extends State<TestSliverView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sliver view + Refresh"),
        ),
        body: SPListView(
            enablePullDown: true,
            enablePullUp: true,
            child: CustomScrollView(
              slivers: [
                // const SliverAppBar(
                //   pinned: true,
                //   expandedHeight: 250.0,
                //   flexibleSpace: FlexibleSpaceBar(
                //     title: Text('Sliver view + Refresh'),
                //   ),
                // ),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 4.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.center,
                        color: Colors.teal[100 * (index % 9)],
                        child: Text('Grid Item $index'),
                      );
                    },
                    childCount: 20,
                  ),
                ),
                SliverFixedExtentList(
                  itemExtent: 50.0,
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.center,
                        color: Colors.lightBlue[100 * (index % 9)],
                        child: Text('List Item $index'),
                      );
                    },
                  ),
                ),
              ],
            )));
  }
}
