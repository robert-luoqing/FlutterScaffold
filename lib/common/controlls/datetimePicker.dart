import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

typedef DateChangedCallback(DateTime time);

class SPDateTimePicker {
  static void showDatePicker(BuildContext context,
      {DateChangedCallback? onConfirm,
      DateTime? selectedDate,
      DateTime? minTime,
      DateTime? maxTime}) {
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
    }, onCancel: () {
      print('canceled');
    }, currentTime: selectedDate);
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
