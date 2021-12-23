import 'package:FlutterScaffold/common/controlls/alphabetList/alphabetBindListModel.dart';
import 'package:flutter/material.dart';

typedef AlphabetItemOnTap<T> = void Function<T>(AlphabetModel<T> item);

class AlphabetSideList<T> extends StatefulWidget {
  const AlphabetSideList(
      {required this.headerToIndexMap,
      required this.onTap,
      required this.alphabetAlign,
      required this.alphabetInset,
      this.alphabetBuilder,
      Key? key})
      : super(key: key);
  final SPAlphabetListViewAlphabetBuilder<T>? alphabetBuilder;
  final List<AlphabetModel<T>> headerToIndexMap;
  final AlphabetItemOnTap<AlphabetModel<T>> onTap;
  final Alignment alphabetAlign;
  final EdgeInsets alphabetInset;

  @override
  AlphabetSideListState<T> createState() => AlphabetSideListState<T>();
}

class AlphabetSideListState<T> extends State<AlphabetSideList> {
  /// It is top item on viewport, the headerData can be used to tracking
  /// current alphabet
  AlphabetBindListModel? _topItem;

  AlphabetSideList<T> get ownWidget {
    return this.widget as AlphabetSideList<T>;
  }

  set topItem(AlphabetBindListModel? val) {
    if (_topItem != val) {
      try {
        this.setState(() {
          this._topItem = val;
        });
      } catch (e, s) {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          this.setState(() {
            this._topItem = val;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.ownWidget.alphabetBuilder == null) {
      return SizedBox(
        width: 0,
        height: 0,
      );
    } else {
      List<Widget> alphabetWidgets = [];
      for (var header in ownWidget.headerToIndexMap) {
        var _alphabetWidget = this.ownWidget.alphabetBuilder!(
            context,
            header.headerData,
            header.headerIndex == this._topItem?.headerIndex,
            header.headerIndex);
        alphabetWidgets.add(GestureDetector(
            onTap: () {
              ownWidget.onTap(header);
            },
            behavior: HitTestBehavior.opaque,
            child: _alphabetWidget));
      }
      return Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          child: Align(
              alignment: ownWidget.alphabetAlign,
              child: Container(
                child: Padding(
                  padding: ownWidget.alphabetInset,
                  child: (Column(
                    mainAxisSize: MainAxisSize.min,
                    children: alphabetWidgets,
                  )),
                ),
              )));
    }
  }
}
