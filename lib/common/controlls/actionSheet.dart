import 'dart:async';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/navigator.dart';

class _ActionSheetInnerContainer extends StatefulWidget {
  final Widget child;
  final Function onDisponse;
  _ActionSheetInnerContainer(this.child, this.onDisponse);

  @override
  __ActionSheetInnerContainerState createState() =>
      __ActionSheetInnerContainerState();
}

class __ActionSheetInnerContainerState
    extends State<_ActionSheetInnerContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(child: this.widget.child);
  }

  @override
  void dispose() {
    this.widget.onDisponse();
    super.dispose();
  }
}

class SPActionSheet {
  static Future showActionSheetWithList(BuildContext context, List<String> data,
      {String? title, bool? showCancelButton, String? cancelButtonText}) {
    Map<dynamic, String> uidata = {};
    for (var item in data) {
      uidata.putIfAbsent(item, () => item);
    }
    return showActionSheet(context, uidata,
        title: title,
        showCancelButton: showCancelButton,
        cancelButtonText: cancelButtonText);
  }

  static Future<dynamic> showActionSheet(
      BuildContext context, Map<dynamic, String> data,
      {String? title,
      bool? showCancelButton,
      String? cancelButtonText,
      TextStyle? textStyle}) {
    var completer = Completer<dynamic>();
    List<BottomSheetAction> actions = [];

    var disposibaleContainerAdded = false;
    var onDispose = () {
      if (!completer.isCompleted) {
        completer.complete(null);
      }
    };

    for (var key in data.keys) {
      String display = data[key]!;
      var bottomSheetAction = BottomSheetAction(
        title: disposibaleContainerAdded
            ? Text(display, style: textStyle)
            : _ActionSheetInnerContainer(
                Text(display, style: textStyle), onDispose),
        onPressed: () {
          SPNavigator.pop(context);
          completer.complete(key);
        },
      );
      actions.add(bottomSheetAction);
      disposibaleContainerAdded = true;
    }

    CancelAction? cancelAction;
    if (showCancelButton == true) {
      var text = cancelButtonText == null ? 'Cancel' : cancelButtonText;
      cancelAction = CancelAction(
          title: disposibaleContainerAdded
              ? Text(text)
              : _ActionSheetInnerContainer(Text(text), onDispose),
          onPressed: () {
            SPNavigator.pop(context);
            completer.complete(null);
          });
      disposibaleContainerAdded = true;
    }

    showAdaptiveActionSheet(
        context: context,
        title: title == null ? null : Text(title),
        actions: actions,
        cancelAction: cancelAction);

    return completer.future;
  }
}
