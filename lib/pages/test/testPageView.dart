import 'package:flutter/material.dart';

class TestPageView extends StatefulWidget {
  @override
  _TestPageViewState createState() => _TestPageViewState();
}

class _TestPageViewState extends State<TestPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test")),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,

            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/testToast");
                  },
                  child: Text("Open Toast View")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/pager");
                  },
                  child: Text("Open Page View")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/webview");
                  },
                  child: Text("Open Webview")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/testGlobalLoading");
                  },
                  child: Text("Open Global Loading")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/testCarousel");
                  },
                  child: Text("Open Carousel")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/testMarquee");
                  },
                  child: Text("Open Marquee")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/testListview");
                  },
                  child: Text("Open List View")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/testSliverView");
                  },
                  child: Text("Open Sliver View")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/testQrScanView");
                  },
                  child: Text("Open QR Scanner")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/testDialogView");
                  },
                  child: Text("Open Dialog")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/testImagePicker");
                  },
                  child: Text("Open Image Picker")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/testDateTimePicker");
                  },
                  child: Text("Open DateTime Picker")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/testTextField");
                  },
                  child: Text("Open Text Field")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/testSwitchControl");
                  },
                  child: Text("Open Switch Control")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/testShowModalSideSheet");
                  },
                  child: Text("Open Side sheet")),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
