import 'package:lingo_dragon/pages/login/email_login_page.dart';
import 'package:lingo_dragon/pages/login/phone_login_page.dart';
import 'package:lingo_dragon/pages/login/verify_code_page.dart';
import 'package:lingo_dragon/pages/test/test_chat_bubble.dart';
import 'package:lingo_dragon/pages/test/test_grahp_ql.dart';
import 'package:lingo_dragon/pages/test/test_listview_performance.dart';
import 'pages/home/root.dart';
import 'pages/test/test_alphabet_list_view.dart';
import 'pages/test/test_button.dart';
import 'pages/test/test_calendar.dart';
import 'pages/test/test_chat.dart';
import 'pages/test/test_expand_tabview.dart';
import 'pages/test/test_flutter_listview_performance.dart';
import 'pages/test/test_image.dart';
import 'pages/test/test_page_view.dart';

import 'package:flutter/widgets.dart';
import 'pages/test/my_page_view.dart';
import 'pages/test/my_page_view2.dart';
import 'pages/test/my_web_view.dart';
import 'pages/test/test_carousel.dart';
import 'pages/test/test_datetime_picker.dart';
import 'pages/test/test_dialog_view.dart';
import 'pages/test/test_global_loading.dart';
import 'pages/test/test_image_picker.dart';
import 'pages/test/test_list_view.dart';
import 'pages/test/test_marquee.dart';
import 'pages/test/test_picker.dart';
import 'pages/test/test_show_modal_side_sheet.dart';
import 'pages/test/test_sliver_view.dart';
import 'pages/test/test_switch_control.dart';
import 'pages/test/test_text_field.dart';
import 'pages/test/test_theme_i18n.dart';
import 'pages/test/test_voice.dart';
import 'pages/test/testqrscan_view.dart';
import 'pages/test/toast_test.dart';

class SPRoute {
  static const String initialRoute = "/";
  static final Map<String, WidgetBuilder> routes = {
    "/": (context) => const RootPage(),
    "/pager": (context) => const MyPageView(),
    "/pager2": (context) => const MyPageView2(),
    "/webview": (context) => const MyWebView(),
    "/testToast": (context) => const ToastTestView(),
    "/test": (context) => const TestPageView(),
    '/alphabetListView': (context) => const TestAlphabetListView(),
    "/testGlobalLoading": (context) => const TestGlobalLoading(),
    "/testCarousel": (context) => const TestCarouselPage(),
    "/testMarquee": (context) => const TestMarqueePage(),
    "/testListview": (context) => const TestListView(),
    "/testSliverView": (context) => const TestSliverView(),
    "/testQrScanView": (context) => const TestQrScanView(),
    "/testDialogView": (context) => const TestDialogView(),
    "/testImagePicker": (context) => const TestImagePicker(),
    "/testDateTimePicker": (context) => const TestDateTimePicker(),
    "/testTextField": (context) => const TestTextField(),
    "/testSwitchControl": (context) => const TestSwitchControl(),
    "/testShowModalSideSheet": (context) => const TestShowModalSideSheet(),
    "/testGraphQL": (context) => const TestGraphQL(),
    "/testImage": (context) => const TestImage(),
    "/testPicker": (context) => const TestPicker(),
    "/testAlphabetListView": (context) => const TestAlphabetListView(),
    "/testButton": (context) => const TestButton(),
    "/testVoice": (context) => const TestVoice(),
    "/testThemeAndI18N": (context) => const TestThemeAndI18N(),
    "/testCalendar": (context) => const TestCalendar(),
    "/testChat": (context) => const TestChat(),
    '/testChatBubble': (context) => const ChatBubble(),
    '/testListViewPerformance': (context) => const TestListViewPerformance(),
    '/testFlutterListViewPerformance': (context) =>
        const TestFlutterListViewPerformance(),

    /// Below will put official page in here.
    "/phoneLogin": (context) => const PhoneLoginPage(),
    "/phoneVerify": (context) => const VerifyCodePage(account: ''),
    '/emailLogin': (context) => const EmailLoginPage(),
    '/testExpandTabview': (context) => const TestExpandTabview(),
  };
}
