import '../../common/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class TestPageView extends StatefulWidget {
  const TestPageView({Key? key}) : super(key: key);

  @override
  _TestPageViewState createState() => _TestPageViewState();
}

class _TestPageViewState extends State<TestPageView> {
  @override
  Widget build(BuildContext context) {
    return SPScaffold(
      title: const Text("Test"),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,

          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testToast");
                },
                child: const Text("Open Toast View")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/pager");
                },
                child: const Text("Open Page View")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/webview");
                },
                child: const Text("Open Webview")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testGlobalLoading");
                },
                child: const Text("Open Global Loading")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testCarousel");
                },
                child: const Text("Open Carousel")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testMarquee");
                },
                child: const Text("Open Marquee")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testListview");
                },
                child: const Text("Open List View")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testSliverView");
                },
                child: const Text("Open Sliver View")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testQrScanView");
                },
                child: const Text("Open QR Scanner")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testDialogView");
                },
                child: const Text("Open Dialog")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testImagePicker");
                },
                child: const Text("Open Image Picker")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testDateTimePicker");
                },
                child: const Text("Open DateTime Picker")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testTextField");
                },
                child: const Text("Open Text Field")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testSwitchControl");
                },
                child: const Text("Open Switch Control")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testShowModalSideSheet");
                },
                child: const Text("Open Side sheet")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testGraphQL");
                },
                child: const Text("Test GraphQL")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testImage");
                },
                child: const Text("Test Image")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testPicker");
                },
                child: const Text("Test Picker")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testAlphabetListView");
                },
                child: const Text("Test AlphabetListView")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testButton");
                },
                child: const Text("Test Button")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testVoice");
                },
                child: const Text("Test Voice")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testThemeAndI18N");
                },
                child: const Text("Test Theme AndI 18N")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testCalendar");
                },
                child: const Text("Test Calendar")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testChat");
                },
                child: const Text("Test Chat")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testChatBubble");
                },
                child: const Text("Test ChatBubble")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testListViewPerformance");
                },
                child: const Text("Test List View Performance")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, "/testFlutterListViewPerformance");
                },
                child: const Text("Test Flutter List View Performance")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testExpandTabview");
                },
                child: const Text("Test Expand Tabview")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testHierarchyListView");
                },
                child: const Text("Test Hierarchy List View")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testHierarchyListView2");
                },
                child: const Text("Test Hierarchy List View 2")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, "/testTransparentGradientButton");
                },
                child: const Text("Test Transparent Gradient Button")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/testListSkeleton");
                },
                child: const Text("Test List Skeleton")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
