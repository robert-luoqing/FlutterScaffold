import 'package:flutter/material.dart';
// import 'package:page_turn/page_turn.dart';

class MyPageView2 extends StatefulWidget {
  const MyPageView2({
    Key? key,
  }) : super(key: key);

  @override
  _MyPageView2State createState() => _MyPageView2State();
}

class _MyPageView2State extends State<MyPageView2> {
  // final _controller = GlobalKey<PageTurnState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pager2"),
      ),
      // body: PageTurn(
      //   key: _controller,
      //   backgroundColor: Colors.white,
      //   showDragCutoff: false,
      //   lastPage: Container(child: Center(child: Text('Last Page!'))),
      //   children: <Widget>[
      //     for (var i = 0; i < 20; i++)
      //       Container(
      //         child: Text(i.toString()),
      //       ),
      //   ],
      // )
      body: Container(),
    );
  }
}
