import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

typedef DateChangedCallback = Function(DateTime time);

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
      if (kDebugMode) {
        print('change $date');
      }
    }, onConfirm: (date) {
      if (kDebugMode) {
        print('confirm $date');
      }
      if (onConfirm != null) {
        onConfirm(date);
      }
    }, onCancel: () {
      if (kDebugMode) {
        print('canceled');
      }
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
      if (kDebugMode) {
        print('change $date');
      }
    }, onConfirm: (date) {
      if (kDebugMode) {
        print('confirm $date');
      }
      if (onConfirm != null) {
        onConfirm(date);
      }
    }, onCancel: () {
      if (kDebugMode) {
        print('canceled');
      }
    }, currentTime: selectedDate);
  }

  static Future<DateTime?> showTimePicker(BuildContext context,
      {DateChangedCallback? onConfirm,
      DateTime? selectedDate,
      DateTime? minTime,
      DateTime? maxTime}) {
    return DatePicker.showTimePicker(context, showTitleActions: true,
        onChanged: (date) {
      if (kDebugMode) {
        print('change $date');
      }
    }, onConfirm: (date) {
      if (kDebugMode) {
        print('confirm $date');
      }
      if (onConfirm != null) {
        onConfirm(date);
      }
    }, onCancel: () {
      if (kDebugMode) {
        print('canceled');
      }
    }, currentTime: selectedDate);
  }
}
