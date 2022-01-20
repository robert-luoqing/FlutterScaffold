import '../../common/controlls/loading.dart';
import 'package:flutter/material.dart';

class TestGlobalLoading extends StatefulWidget {
  const TestGlobalLoading({Key? key}) : super(key: key);

  @override
  _TestGlobalLoadingState createState() => _TestGlobalLoadingState();
}

class _TestGlobalLoadingState extends State<TestGlobalLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pager"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(children: [
          ElevatedButton(
            onPressed: () async {
              SPLoading.show();
              await Future.delayed(const Duration(seconds: 3));
              Navigator.pop(context);
              await Future.delayed(const Duration(seconds: 3));
              SPLoading.hide();
            },
            child: const Text("Click"),
          ),
        ]),
      ),
    );
  }
}
