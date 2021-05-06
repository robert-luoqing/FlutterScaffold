import 'pages/test/testPageView.dart';

import 'pages/home/home.dart';
import 'package:flutter/widgets.dart';

import 'pages/test/myPageView.dart';
import 'pages/test/myPageView2.dart';
import 'pages/test/myWebView.dart';
import 'pages/test/testCarousel.dart';
import 'pages/test/testDateTimePicker.dart';
import 'pages/test/testDialogView.dart';
import 'pages/test/testGlobalLoading.dart';
import 'pages/test/testImagePicker.dart';
import 'pages/test/testListView.dart';
import 'pages/test/testMarquee.dart';
import 'pages/test/testSliverView.dart';
import 'pages/test/testSwitchControl.dart';
import 'pages/test/testTextField.dart';
import 'pages/test/testqrscanView.dart';
import 'pages/test/toastTest.dart';

class SPRoute {
  static final String initialRoute = "/";
  static final Map<String, WidgetBuilder> routes = {
    "/": (context) => Stack(
          children: [
            MyHomePage(),
            // GlobalLoading(),
          ],
        ),
    "/pager": (context) => MyPageView(),
    "/pager2": (context) => MyPageView2(),
    "/webview": (context) => MyWebView(),
    "/testToast": (context) => ToastTestView(),
    "/test": (context) => TestPageView(),
    "/testGlobalLoading": (context) => TestGlobalLoading(),
    "/testCarousel": (context) => TestCarouselPage(),
    "/testMarquee": (context) => TestMarqueePage(),
    "/testListview": (context) => TestListView(),
    "/testSliverView": (context) => TestSliverView(),
    "/testQrScanView": (context) => TestQrScanView(),
    "/testDialogView": (context) => TestDialogView(),
    "/testImagePicker": (context) => TestImagePicker(),
    "/testDateTimePicker": (context) => TestDateTimePicker(),
    "/testTextField": (context) => TestTextField(),
    "/testSwitchControl": (context) => TestSwitchControl(),
  };
}
