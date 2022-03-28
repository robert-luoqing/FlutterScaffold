import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/navigator.dart';

typedef SPPickerItemBuilder = Widget Function(dynamic key, dynamic val);

class SPPicker extends StatefulWidget {
  final Completer<dynamic> completer;
  final Map<dynamic, dynamic> data;
  final double height;
  final dynamic selectedKey;
  final String okButtonText;
  final String cancelButtonText;

  /// [dismissIsSelect] is true mean: the selected item is the value if click outside content
  /// default is false
  final bool dismissIsSelect;
  final bool showTopBar;
  final SPPickerItemBuilder itemBuilder;
  final double itemExtent;

  const SPPicker(
      {required this.completer,
      required this.data,
      required this.itemBuilder,
      this.selectedKey,
      this.height = 100,
      this.okButtonText = "OK",
      this.cancelButtonText = "CANCEL",
      this.dismissIsSelect = false,
      this.showTopBar = true,
      this.itemExtent = 32,
      Key? key})
      : super(key: key);

  @override
  _SPPickerState createState() => _SPPickerState();

  static Future<dynamic> show(BuildContext context, Map<dynamic, dynamic> data,
      {double height = 250,
      dynamic selectedKey,
      bool isDismissible = true,
      bool dismissIsSelect = false,
      bool showTopBar = true,
      SPPickerItemBuilder? itemBuilder,
      String okButtonText = "OK",
      String cancelButtonText = "CANCEL",
      double itemExtent = 32}) {
    var completer = Completer<dynamic>();

    showModalBottomSheet(
        context: context,
        isDismissible: isDismissible,
        builder: (BuildContext context) {
          return SPPicker(
              completer: completer,
              data: data,
              height: height,
              selectedKey: selectedKey,
              okButtonText: okButtonText,
              cancelButtonText: cancelButtonText,
              dismissIsSelect: dismissIsSelect,
              showTopBar: showTopBar,
              itemExtent: itemExtent,
              itemBuilder:
                  itemBuilder ?? (key, val) => Center(child: Text('$val')));
        });
    return completer.future;
  }
}

class _SPPickerState extends State<SPPicker> {
  bool invokeCompleter = false;
  late FixedExtentScrollController controller;
  dynamic selectedValue;
  @override
  void initState() {
    var selectedIndex = 0;
    for (var i = 0; i < widget.data.length; i++) {
      if (widget.data.keys.elementAt(i) == widget.selectedKey) {
        selectedIndex = i;
        break;
      }
    }
    selectedValue = widget.selectedKey;
    controller = FixedExtentScrollController(initialItem: selectedIndex);
    super.initState();
  }

  _selectValue() {
    invokeCompleter = true;
    var selectedItem = widget.data.keys.elementAt(controller.selectedItem);
    widget.completer.complete(selectedItem);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
        children: [
          widget.showTopBar
              ? Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          invokeCompleter = true;
                          SPNavigator.pop(context);
                          widget.completer.complete(null);
                        },
                        child: Text(widget.cancelButtonText)),
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            _selectValue();
                            SPNavigator.pop(context);
                          },
                          child: Text(widget.okButtonText)),
                    ))
                  ],
                )
              : Container(),
          Expanded(
            child: CupertinoPicker(
              backgroundColor: Colors.white,
              scrollController: controller,
              magnification: 1,
              useMagnifier: true,
              onSelectedItemChanged: (index) {
                var selectedItem = widget.data.keys.elementAt(index);
                selectedValue = selectedItem;
                // print("selectedd: $index");
              },
              itemExtent: widget.itemExtent,
              children: widget.data.keys
                  .map((dataKey) =>
                      widget.itemBuilder(dataKey, widget.data[dataKey]))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (invokeCompleter == false) {
      if (widget.dismissIsSelect) {
        widget.completer.complete(selectedValue);
      } else {
        widget.completer.complete(null);
      }
    }
    controller.dispose();
    super.dispose();
  }
}
