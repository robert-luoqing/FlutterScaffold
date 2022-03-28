import 'dart:async';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'text_field.dart';
import '../utils/platform_util.dart';
import '../../theme/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                  MaterialStateProperty.all<Color>(const Color(0xFF6200EE))),
          onPressed: () {
            SPNavigator.pop(context);
            completer.complete();
          },
          child: Text(buttonText ?? 'OK'),
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
              buttonText ?? 'OK',
              style: const TextStyle(color: Color(0xFF000000)),
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
                  MaterialStateProperty.all<Color>(const Color(0xFF6200EE))),
          onPressed: () {
            SPNavigator.pop(context);
            completer.complete(false);
          },
          child: Text(
            cancelButtonText ?? 'CANCEL',
          ),
        ),
        TextButton(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFF6200EE))),
          onPressed: () {
            SPNavigator.pop(context);
            completer.complete(true);
          },
          child: Text(okButtonText ?? 'OK'),
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
              cancelButtonText ?? 'CANCEL',
              style: TextStyle(color: Colors.red[400]),
            ),
            onPressed: () {
              SPNavigator.pop(context);
              completer.complete(false);
            }),
        CupertinoButton(
            child: Text(
              okButtonText ?? 'OK',
              style: const TextStyle(color: Colors.blue),
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

  static void showBottomDialog(
      {required BuildContext context,
      required Widget widget,
      Color? backgroundColor}) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) {
          var bottom = MediaQuery.of(context).viewInsets.bottom;
          if (bottom == 0) {
            bottom = MediaQuery.of(context).viewPadding.bottom;
          }
          return Container(
            color: backgroundColor,
            child: Padding(
              padding: EdgeInsets.only(bottom: bottom),
              child: widget,
            ),
          );
        });
  }

  static Future<String?> _buildAndroidInputDialog(
      {required BuildContext context,
      String? title,
      String? defaultValue,
      String? hintText}) {
    var completer = Completer<String?>();
    var textController = TextEditingController(text: defaultValue);
    var child = Padding(
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
                          style: SPTextStyle.text15c333BoldStyle,
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
                                      padding:
                                          const EdgeInsets.only(right: 4.0),
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFFFFFFFF),
                                                Color(0xFFFFFFFF)
                                              ]),
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0))),
                                            shadowColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                          ),
                                          onPressed: () {
                                            SPNavigator.pop(context);
                                            completer.complete(null);
                                          },
                                          child: const Text("Cancel",
                                              style:
                                                  SPTextStyle.text15c999Style),
                                        ),
                                      ))),
                              Expanded(
                                  child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 4.0),
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFFF46921),
                                                Color(0xFFF46921)
                                              ]),
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0))),
                                            shadowColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                          ),
                                          onPressed: () {
                                            SPNavigator.pop(context);
                                            completer
                                                .complete(textController.text);
                                          },
                                          child: const Text("OK",
                                              style:
                                                  SPTextStyle.text15cFFFStyle),
                                        ),
                                      )))
                            ],
                          ),
                        )
                      ]),
                ),
              ))
        ],
      ),
    );

    SPDialog.showCommonDialog(
      context: context,
      widget: child,
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
    var child = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: SizedBox(
                  height: 120,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Text(
                            title ?? "",
                            textAlign: TextAlign.center,
                            style: SPTextStyle.text15c333BoldStyle,
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
                                      hintStyle: SPTextStyle.text14cABAStyle,
                                      border: InputBorder.none,
                                    )),
                              )),
                        )),
                        const SizedBox(
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
                                      style: TextStyle(color: Colors.red[400]),
                                    ),
                                    onPressed: () {
                                      SPNavigator.pop(context);
                                      completer.complete(null);
                                    }),
                              ),
                              Expanded(
                                child: CupertinoButton(
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onPressed: () {
                                      SPNavigator.pop(context);
                                      completer.complete(textController.text);
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
    );
    SPDialog.showCommonDialog(
      context: context,
      widget: child,
    );

    return completer.future;
  }

  static void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
