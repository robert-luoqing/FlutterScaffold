import 'dart:async';

import '../../../common/controlls/textField.dart';
import '../../../common/utils/platformUtil.dart';
import '../../../common/utils/textStyleUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button.dart';
import '../utils/navigator.dart';

class SPDialog {
  static Widget _buildAndroidAlertDialog(
      BuildContext context, String message, Completer completer,
      {String? title, String? buttonText}) {
    return AlertDialog(
      title: Text(title ?? ""),
      content: Text(message),
      actions: [
        TextButton(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF6200EE))),
          onPressed: () {
            SPNavigator.pop(context);
            completer.complete();
          },
          child: Text(buttonText != null ? buttonText : '确认'),
        ),
      ],
    );
  }

  static Widget _buildiOSAlertDialog(
      BuildContext context, String message, Completer completer,
      {String? title, String? buttonText}) {
    return CupertinoAlertDialog(
      title: title == null ? null : Text(title),
      content: Text(message),
      actions: [
        CupertinoButton(
            child: Text(buttonText != null ? buttonText : '确认'),
            onPressed: () {
              SPNavigator.pop(context);
              completer.complete();
            }),
      ],
    );
  }

  static Future alert(BuildContext context, String message,
      {String? title, String? buttonText}) {
    var completer = Completer<void>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SPPlatform.isIOS()
                  ? _buildiOSAlertDialog(context, message, completer,
                      title: title, buttonText: buttonText)
                  : _buildAndroidAlertDialog(context, message, completer,
                      title: title, buttonText: buttonText));
        });

    return completer.future;
  }

  static Widget _buildAndroidConfirmDialog(
      BuildContext context, String message, Completer completer,
      {String? title, String? okButtonText, String? cancelButtonText}) {
    return AlertDialog(
      title: Text(title ?? ""),
      content: Text(message),
      actions: [
        TextButton(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF6200EE))),
          onPressed: () {
            SPNavigator.pop(context);
            completer.complete(false);
          },
          child: Text(cancelButtonText != null ? cancelButtonText : '取消'),
        ),
        TextButton(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF6200EE))),
          onPressed: () {
            SPNavigator.pop(context);
            completer.complete(true);
          },
          child: Text(okButtonText != null ? okButtonText : '确认'),
        ),
      ],
    );
  }

  static Widget _buildiOSConfirmDialog(
      BuildContext context, String message, Completer completer,
      {String? title, String? okButtonText, String? cancelButtonText}) {
    return CupertinoAlertDialog(
      title: title == null ? null : Text(title),
      content: Text(message),
      actions: [
        CupertinoButton(
            child: Text(cancelButtonText != null ? cancelButtonText : '取消'),
            onPressed: () {
              SPNavigator.pop(context);
              completer.complete(false);
            }),
        CupertinoButton(
            child: Text(okButtonText != null ? okButtonText : '确认'),
            onPressed: () {
              SPNavigator.pop(context);
              completer.complete(true);
            }),
      ],
    );
  }

  static Future<bool> confirm(BuildContext context, String message,
      {String? title, String? okButtonText, String? cancelButtonText}) {
    var completer = Completer<bool>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SPPlatform.isIOS()
                  ? _buildiOSConfirmDialog(context, message, completer,
                      title: title,
                      okButtonText: okButtonText,
                      cancelButtonText: cancelButtonText)
                  : _buildAndroidConfirmDialog(context, message, completer,
                      title: title,
                      okButtonText: okButtonText,
                      cancelButtonText: cancelButtonText));
        });

    return completer.future;
  }

  static void showCommonDialog(
      {required BuildContext context, required Widget widget}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      // transitionDuration: Duration(milliseconds: 100),
      // transitionBuilder: (context, animation, secondaryAnimation, child) {
      //   return FadeTransition(
      //     opacity: animation,
      //     child: ScaleTransition(
      //       scale: animation,
      //       child: child,
      //     ),
      //   );
      // },
      pageBuilder: (context, animation, secondaryAnimation) {
        return widget;
      },
    );
  }

  static Future<String?> showInputDialog(
      {required BuildContext context, String? title, String? defaultValue}) {
    var completer = Completer<String?>();
    var textController = TextEditingController(text: defaultValue);
    SPDialog.showCommonDialog(
      context: context,
      widget: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: 120,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              title ?? "",
                              style: SPTextStyle.text15_333_BoldStyle,
                            ),
                            Flexible(
                                child: SizedBox(
                              height: 55,
                              child: SPTextField(
                                pattern: SPTextFieldPattern.normal,
                                controller: textController,
                              ),
                            )),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: SPButton(
                                        pattern:
                                            SPButtonPattern.normal_h40_15_FFF,
                                        onPressed: () {
                                          SPNavigator.pop(context);
                                          completer.complete(null);
                                        },
                                        text: "取消"),
                                  )),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: SPButton(
                                        pattern: SPButtonPattern
                                            .normal_h40_15_F46921,
                                        onPressed: () {
                                          SPNavigator.pop(context);
                                          completer
                                              .complete(textController.text);
                                        },
                                        text: "确定"),
                                  ))
                                ],
                              ),
                            )
                          ]),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );

    return completer.future;
  }

  static void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
