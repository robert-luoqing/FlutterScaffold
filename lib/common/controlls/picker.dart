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
      String cancelButtonText = "CANCEL"}) {
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
              itemBuilder: itemBuilder == null
                  ? (key, val) => Center(child: Text('$val'))
                  : itemBuilder);
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
    for (var i = 0; i < this.widget.data.length; i++) {
      if (this.widget.data.keys.elementAt(i) == this.widget.selectedKey) {
        selectedIndex = i;
        break;
      }
    }
    this.selectedValue = this.widget.selectedKey;
    this.controller = FixedExtentScrollController(initialItem: selectedIndex);
    super.initState();
  }

  _selectValue() {
    invokeCompleter = true;
    var selectedItem = this.widget.data.keys.elementAt(controller.selectedItem);
    this.widget.completer.complete(selectedItem);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.widget.height,
      child: Column(
        children: [
          this.widget.showTopBar
              ? Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          invokeCompleter = true;
                          SPNavigator.pop(context);
                          this.widget.completer.complete(null);
                        },
                        child: Text(this.widget.cancelButtonText)),
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            this._selectValue();
                            SPNavigator.pop(context);
                          },
                          child: Text(this.widget.okButtonText)),
                    ))
                  ],
                )
              : Container(),
          Expanded(
            child: CupertinoPicker(
              backgroundColor: Colors.white,
              scrollController: this.controller,
              magnification: 1,
              useMagnifier: true,
              onSelectedItemChanged: (index) {
                var selectedItem = this.widget.data.keys.elementAt(index);
                this.selectedValue = selectedItem;
                print("selectedd: $index");
              },
              itemExtent: 32.0,
              children: this
                  .widget
                  .data
                  .keys
                  .map((dataKey) =>
                      widget.itemBuilder(dataKey, this.widget.data[dataKey]))
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
      if (this.widget.dismissIsSelect) {
        this.widget.completer.complete(this.selectedValue);
      } else {
        this.widget.completer.complete(null);
      }
    }
    this.controller.dispose();
    super.dispose();
  }
}
