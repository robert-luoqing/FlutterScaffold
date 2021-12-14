import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/navigator.dart';

class SPPicker extends StatefulWidget {
  final Completer<dynamic> completer;
  final Map<dynamic, String> data;
  final double height;
  final dynamic selectedKey;
  const SPPicker(
      {required this.completer,
      required this.data,
      this.selectedKey,
      this.height = 100,
      Key? key})
      : super(key: key);

  @override
  _SPPickerState createState() => _SPPickerState();

  static Future<dynamic> show(BuildContext context, Map<dynamic, String> data,
      {double height = 250}) {
    var completer = Completer<dynamic>();

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SPPicker(completer: completer, data: data, height: height);
        });
    return completer.future;
  }
}

class _SPPickerState extends State<SPPicker> {
  bool invokeCompleter = false;
  late FixedExtentScrollController controller;
  @override
  void initState() {
    var selectedIndex = 0;
    for (var i = 0; i < this.widget.data.length; i++) {
      if (this.widget.data.keys.elementAt(i) == this.widget.selectedKey) {
        selectedIndex = i;
        break;
      }
    }

    this.controller = FixedExtentScrollController(initialItem: selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.widget.height,
      child: Column(
        children: [
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    invokeCompleter = true;
                    SPNavigator.pop(context);
                    this.widget.completer.complete(null);
                  },
                  child: Text("取消")),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      invokeCompleter = true;
                      SPNavigator.pop(context);
                      var selectedItem = this
                          .widget
                          .data
                          .keys
                          .elementAt(controller.selectedItem);
                      this.widget.completer.complete(selectedItem);
                    },
                    child: Text("确定")),
              ))
            ],
          ),
          Expanded(
            child: CupertinoPicker(
              backgroundColor: Colors.white,
              scrollController: this.controller,
              magnification: 1.2,
              useMagnifier: true,
              onSelectedItemChanged: (value) {
                print("selectedd: $value");
              },
              itemExtent: 32.0,
              children:
                  this.widget.data.values.map((item) => Text(item)).toList(),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (invokeCompleter == false) {
      this.widget.completer.complete(null);
    }
    super.dispose();
  }
}
