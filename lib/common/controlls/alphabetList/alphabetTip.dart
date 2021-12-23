import 'package:flutter/material.dart';

import 'alphabetBindListModel.dart';
import 'dart:async';

class AlphabetTip<T> extends StatefulWidget {
  const AlphabetTip({this.alphabetTipBuilder, Key? key}) : super(key: key);
  final SPAlphabetListViewTipBuilder<T>? alphabetTipBuilder;

  @override
  AlphabetTipState<T> createState() => AlphabetTipState<T>();
}

class AlphabetTipState<T> extends State<AlphabetTip> {
  T? _tipData;
  Timer? _timer;
  bool _showTip = false;

  set tipData(T? val) {
    setState(() {
      this._tipData = val;
    });
    if (this._tipData != null) {
      this._cancelTimerAndSetShowTip(true);
      this._timer = Timer(Duration(milliseconds: 1000), () {
        this._cancelTimerAndSetShowTip(false);
      });
    } else {
      this._cancelTimerAndSetShowTip(false);
    }
  }

  _cancelTimerAndSetShowTip(bool showTip) {
    setState(() {
      this._showTip = showTip;
    });
    if (this._timer != null) {
      this._timer!.cancel();
      this._timer = null;
    }
  }

  AlphabetTip<T> get ownWidget {
    return this.widget as AlphabetTip<T>;
  }

  @override
  void dispose() {
    if (this._timer != null) {
      this._timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ownWidget.alphabetTipBuilder != null &&
        _tipData != null &&
        this._showTip) {
      return Positioned(
          child: Center(
        child:
            Container(child: ownWidget.alphabetTipBuilder!(context, _tipData!)),
      ));
    } else {
      return SizedBox(
        width: 0,
        height: 0,
      );
    }
  }
}
