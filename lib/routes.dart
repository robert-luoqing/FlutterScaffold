import 'package:FlutterScaffold/pages/login/phoneLoginPage.dart';
import 'package:FlutterScaffold/pages/test/testGrahpQL.dart';
import 'package:FlutterScaffold/pages/login/phoneVerifyPage.dart';
import 'pages/test/testAlphabetListView.dart';
import 'pages/test/testButton.dart';
import 'pages/test/testCalendar.dart';
import 'pages/test/testChat.dart';
import 'pages/test/testImage.dart';
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
import 'pages/test/testPicker.dart';
import 'pages/test/testShowModalSideSheet.dart';
import 'pages/test/testSliverView.dart';
import 'pages/test/testSwitchControl.dart';
import 'pages/test/testTextField.dart';
import 'pages/test/testThemeAndI18N.dart';
import 'pages/test/testVoice.dart';
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
    "/phoneLogin": (context) => PhoneLoginPage(),
    "/phoneVerify": (context) => VerifyCodePage(
          phone: '',
        ),
    '/alphabetListView': (context) => TestAlphabetListView(),
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
    "/testShowModalSideSheet": (context) => TestShowModalSideSheet(),
    "/testGraphQL": (context) => TestGraphQL(),
    "/testImage": (context) => TestImage(),
    "/testPicker": (context) => TestPicker(),
    "/testAlphabetListView": (context) => TestAlphabetListView(),
    "/testButton": (context) => TestButton(),
    "/testVoice": (context) => TestVoice(),
    "/testThemeAndI18N": (context) => TestThemeAndI18N(),
    "/testCalendar": (context) => TestCalendar(),
    "/testChat": (context) => TestChat()
  };
}
