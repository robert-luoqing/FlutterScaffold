import '../../../common/utils/screenUtil.dart';
import '../../../common/utils/textStyleUtil.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SPToast {
  SPToast._();

  static void show(BuildContext context, String content) {
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Color(0xCC000000),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon(Icons.check),
          // SizedBox(
          //   width: 12.0,
          // ),
          ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: SPScreen.getSize(context).width - 100),
            child: Text(
              content,
              style: SPTextStyle.text12_FFF_Style,
            ),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }

  static void showError(BuildContext context, String content) {
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Color(0xCC000000),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error),
          SizedBox(
            width: 12.0,
          ),
          ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: SPScreen.getSize(context).width - 120),
            child: Text(
              content,
              style: SPTextStyle.text12_FFF_Style,
            ),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }

  static void showInBottom(BuildContext context, String content) {
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Color(0x77000000),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon(Icons.check),
          // SizedBox(
          //   width: 12.0,
          // ),
          Text(
            content,
            style: SPTextStyle.text12_FFF_Style,
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}
