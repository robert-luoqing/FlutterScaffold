import 'dart:async';

import 'package:flutter/material.dart';

class SPDialog {
  static Future alert(BuildContext context, String message,
      {String? title, String? buttonText}) {
    var completer = Completer<void>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: Text(title ?? ""),
                content: Text(message),
                actions: [
                  TextButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF6200EE))),
                    onPressed: () {
                      Navigator.pop(context);
                      completer.complete();
                    },
                    child: Text(buttonText != null ? buttonText : 'OK'),
                  ),
                ],
              ));
        });

    return completer.future;
  }

  static Future<bool> confirm(BuildContext context, String message,
      {String? title, String? okButtonText, String? cancelButtonText}) {
    var completer = Completer<bool>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: Text(title ?? ""),
                content: Text(message),
                actions: [
                  TextButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF6200EE))),
                    onPressed: () {
                      Navigator.pop(context);
                      completer.complete(false);
                    },
                    child: Text(
                        cancelButtonText != null ? cancelButtonText : 'CANCEL'),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF6200EE))),
                    onPressed: () {
                      Navigator.pop(context);
                      completer.complete(true);
                    },
                    child: Text(okButtonText != null ? okButtonText : 'OK'),
                  ),
                ],
              ));
        });

    return completer.future;
  }
}
