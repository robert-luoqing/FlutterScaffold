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
    return DatePicker.showDatePicker(context,
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

  static Future<DateTime?> showDateTimePicker(BuildContext context,
      {DateChangedCallback? onConfirm,
      DateTime? selectedDate,
      DateTime? minTime,
      DateTime? maxTime}) {
    return DatePicker.showDateTimePicker(context,
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

  static Future<DateTime?> showTimePicker(BuildContext context,
      {DateChangedCallback? onConfirm,
      DateTime? selectedDate,
      DateTime? minTime,
      DateTime? maxTime}) {
    return DatePicker.showTimePicker(context, showTitleActions: true,
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
