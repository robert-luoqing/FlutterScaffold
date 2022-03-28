import 'package:flutter/material.dart';

class TestTransparentGradientButton extends StatefulWidget {
  const TestTransparentGradientButton({Key? key}) : super(key: key);

  @override
  State<TestTransparentGradientButton> createState() =>
      _TestTransparentGradientButtonState();
}

class _TestTransparentGradientButtonState
    extends State<TestTransparentGradientButton> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 2.0,
                // isScrollable: true,
                unselectedLabelColor: Color(0xFF999999),
                tabs: [
                  new Container(
                    child: new Tab(text: 'Tab1_11111'),
                  ),
                  new Container(
                    child: new Tab(text: 'Tab2'),
                  ),
                  new Container(
                    child: new Tab(text: 'Tab3_33333333'),
                  ),
                  new Container(
                    child: new Tab(text: 'Tab4'),
                  ),
                ],
              ),
              Expanded(
                  flex: 1,
                  child: TabBarView(children: [
                    Container(),
                    Container(),
                    Container(),
                    Container()
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
