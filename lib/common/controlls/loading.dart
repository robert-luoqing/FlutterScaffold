import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:load/load.dart';

class SPLoading extends StatefulWidget {
  /// show/hide计数，如果出现<=0，则hide, 否则显示
  static int _count = 0;
  static void show() {
    _count++;
    if (_count > 0) {
      showLoadingDialog(tapDismiss: false);
    }
  }

  static void hide() {
    _count--;
    if (_count <= 0) {
      hideLoadingDialog();
    }
  }

  final Widget child;
  SPLoading({required this.child});

  @override
  _SPLoadingState createState() => _SPLoadingState();
}

class _SPLoadingState extends State<SPLoading> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingProvider(
      themeData: LoadingThemeData(),
      child: this.widget.child,
    );
  }
}