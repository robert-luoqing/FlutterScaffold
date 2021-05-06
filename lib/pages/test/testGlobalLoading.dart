import '../../common/controlls/loading.dart';
import 'package:flutter/material.dart';

class TestGlobalLoading extends StatefulWidget {
  @override
  _TestGlobalLoadingState createState() => _TestGlobalLoadingState();
}

class _TestGlobalLoadingState extends State<TestGlobalLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pager"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(children: [
          ElevatedButton(
            onPressed: () async {
              SPLoading.show();
              await Future.delayed(Duration(seconds: 3));
              Navigator.pop(context);
              await Future.delayed(Duration(seconds: 3));
              SPLoading.hide();
            },
            child: Text("Click"),
          ),
        ]),
      ),
    );
  }
}
