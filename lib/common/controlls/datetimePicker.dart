import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

typedef DateChangedCallback(DateTime time);

class SPDateTimePicker {
  static Future<DateTime?> showDatePicker(BuildContext context,
      {DateChangedCallback? onConfirm,
      DateTime? selectedDate,
      DateTime? minTime,
      DateTime? maxTime}) {
    var completer = Completer<DateTime?>();

    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: minTime,
        maxTime: maxTime, onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      print('confirm $date');
      if (onConfirm != null) {
        onConfirm(date);
      }
      completer.complete(date);
    }, onCancel: () {
      print('canceled');
      completer.complete(null);
    }, currentTime: selectedDate);
    return completer.future;
  }

  static void showDateTimePicker(BuildContext context,
      {DateChangedCallback? onConfirm,
      DateTime? selectedDate,
      DateTime? minTime,
      DateTime? maxTime}) {
    DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: minTime,
        maxTime: maxTime, onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      print('confirm $date');
      if (onConfirm != null) {
        onConfirm(date);
      }
    }, onCancel: () {
      print('canceled');
    }, currentTime: selectedDate);
  }

  static void showTimePicker(BuildContext context,
      {DateChangedCallback? onConfirm,
      DateTime? selectedDate,
      DateTime? minTime,
      DateTime? maxTime}) {
    DatePicker.showTimePicker(context, showTitleActions: true,
        onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      print('confirm $date');
      if (onConfirm != null) {
        onConfirm(date);
      }
    }, onCancel: () {
      print('canceled');
    }, currentTime: selectedDate);
  }
}
