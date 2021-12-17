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
          child: Text(buttonText != null ? buttonText : 'OK'),
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
            child: Text(
              buttonText != null ? buttonText : 'OK',
              style: TextStyle(color: Color(0xFF000000)),
            ),
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
          child: Text(
            cancelButtonText != null ? cancelButtonText : 'CANCEL',
          ),
        ),
        TextButton(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF6200EE))),
          onPressed: () {
            SPNavigator.pop(context);
            completer.complete(true);
          },
          child: Text(okButtonText != null ? okButtonText : 'OK'),
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
            child: Text(
              cancelButtonText != null ? cancelButtonText : 'CANCEL',
              style: TextStyle(color: Colors.red[400]),
            ),
            onPressed: () {
              SPNavigator.pop(context);
              completer.complete(false);
            }),
        CupertinoButton(
            child: Text(
              okButtonText != null ? okButtonText : 'OK',
              style: TextStyle(color: Colors.blue),
            ),
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

  static Future<String?> _buildAndroidInputDialog(
      {required BuildContext context,
      String? title,
      String? defaultValue,
      String? hintText}) {
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
                                autofocus: true,
                                pattern: SPTextFieldPattern.normal,
                                placeholder: hintText,
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
                                        text: "Cancel"),
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
                                        text: "Ok"),
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

  static Future<String?> _buildiOSInputDialog(
      {required BuildContext context,
      String? title,
      String? defaultValue,
      String? hintText}) {
    var completer = Completer<String?>();
    var textController = TextEditingController(text: defaultValue);
    SPDialog.showCommonDialog(
      context: context,
      widget: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: SizedBox(
                      height: 120,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: Text(
                                title ?? "",
                                textAlign: TextAlign.center,
                                style: SPTextStyle.text15_333_BoldStyle,
                              ),
                            ),
                            Flexible(
                                child: SizedBox(
                              height: 44,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0),
                                  child: Material(
                                    child: TextField(
                                        autofocus: true,
                                        controller: textController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 5.0, horizontal: 8),
                                          hintText: hintText,
                                          hintStyle:
                                              SPTextStyle.text14_ABA_Style,
                                          border: InputBorder.none,
                                        )),
                                  )),
                            )),
                            SizedBox(
                              height: 1,
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CupertinoButton(
                                        child: Text(
                                          'CANCEL',
                                          style:
                                              TextStyle(color: Colors.red[400]),
                                        ),
                                        onPressed: () {
                                          SPNavigator.pop(context);
                                          completer.complete(null);
                                        }),
                                  ),
                                  Expanded(
                                    child: CupertinoButton(
                                        child: Text(
                                          'OK',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        onPressed: () {
                                          SPNavigator.pop(context);
                                          completer
                                              .complete(textController.text);
                                        }),
                                  )
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

  static Future<String?> showInputDialog(
      {required BuildContext context,
      String? title,
      String? defaultValue,
      String? hintText}) {
    if (SPPlatform.isIOS()) {
      return _buildiOSInputDialog(
          context: context,
          title: title,
          defaultValue: defaultValue,
          hintText: hintText);
    } else {
      return _buildAndroidInputDialog(
          context: context,
          title: title,
          defaultValue: defaultValue,
          hintText: hintText);
    }
  }

  static void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
