import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:lingo_dragon/common/utils/navigator.dart';

enum SPPaletteType {
  hsv,
  hsvWithHue,
  hsvWithValue,
  hsvWithSaturation,
  hsl,
  hslWithHue,
  hslWithLightness,
  hslWithSaturation,
  rgbWithBlue,
  rgbWithGreen,
  rgbWithRed,
  hueWheel,
}

class SPColorPicker {
  static Future<Color?> show(BuildContext context,
      {Color initColor = Colors.white,
      bool enableAlpha = true,
      SPPaletteType paletteType = SPPaletteType.hsvWithHue,
      bool hexInputBar = false,
      ValueChanged<Color>? onColorChanged,
      String? okButtonText,
      String? cancelButtonText}) async {
    var _selectedColor = initColor;
    _onColorChanged(Color color) {
      _selectedColor = color;
      if (onColorChanged != null) {
        onColorChanged(color);
      }
    }

    var type = PaletteType.values[paletteType.index];
    var content = SingleChildScrollView(
      child: ColorPicker(
        pickerColor: initColor,
        onColorChanged: _onColorChanged,
        colorPickerWidth: 300,
        pickerAreaHeightPercent: 0.7,
        enableAlpha: enableAlpha,
        // labelTypes: _labelTypes,
        displayThumbColor: false,
        paletteType: type,
        pickerAreaBorderRadius: const BorderRadius.only(
          topLeft: Radius.circular(2),
          topRight: Radius.circular(2),
        ),
        hexInputBar: hexInputBar,
        // colorHistory: widget.colorHistory,
        // onHistoryChanged: widget.onHistoryChanged,
      ),
    );

    var completer = Completer<Color?>();
    void callback(bool isOK) {
      if (isOK) {
        completer.complete(_selectedColor);
      } else {
        completer.complete(null);
      }
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: defaultTargetPlatform == TargetPlatform.iOS
                  ? _buildiOSConfirmDialog(context, content, callback,
                      okButtonText: okButtonText,
                      cancelButtonText: cancelButtonText)
                  : _buildAndroidConfirmDialog(context, content, callback,
                      okButtonText: okButtonText,
                      cancelButtonText: cancelButtonText));
        });

    return completer.future;
  }

  static Widget _buildAndroidConfirmDialog(
      BuildContext context, Widget content, void Function(bool isOK) callback,
      {okButtonText, String? cancelButtonText}) {
    return AlertDialog(
      content: content,
      actions: [
        TextButton(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFF6200EE))),
          onPressed: () {
            SPNavigator.pop(context);
            callback(false);
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
            callback(true);
          },
          child: Text(okButtonText ?? 'OK'),
        ),
      ],
    );
  }

  static Widget _buildiOSConfirmDialog(
      BuildContext context, Widget content, void Function(bool isOK) callback,
      {String? okButtonText, String? cancelButtonText}) {
    return CupertinoAlertDialog(
      content: content,
      actions: [
        CupertinoButton(
            child: Text(
              cancelButtonText ?? 'CANCEL',
              style: TextStyle(color: Colors.red[400]),
            ),
            onPressed: () {
              SPNavigator.pop(context);
              callback(false);
            }),
        CupertinoButton(
            child: Text(
              okButtonText ?? 'OK',
              style: const TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              SPNavigator.pop(context);
              callback(true);
            }),
      ],
    );
  }
}
