import 'package:flutter/material.dart';

enum ModalSideSheetType { left, right }

Future<T?> showModalSideSheet<T extends Object?>(
    {required BuildContext context,
    required Widget body,
    bool barrierDismissible = false,
    ModalSideSheetType type = ModalSideSheetType.left,
    Color barrierColor = const Color(0x80000000),
    double? width,
    double elevation = 8.0,
    Duration transitionDuration = const Duration(milliseconds: 300),
    bool useRootNavigator = true,
    RouteSettings? routeSettings}) {
  var of = MediaQuery.of(context);
  var platform = Theme.of(context).platform;
  if (width == null) {
    if (platform == TargetPlatform.android || platform == TargetPlatform.iOS) {
      width = of.size.width * 0.6;
    } else {
      width = of.size.width / 4;
    }
  }

  double height = of.size.height;
  var alignment = Alignment.bottomRight;
  if (ModalSideSheetType.left == type) {
    alignment = Alignment.bottomLeft;
  }

  return showGeneralDialog(
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    transitionDuration: transitionDuration,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    barrierLabel: "",
    context: context,
    pageBuilder: (BuildContext context, _, __) {
      return Align(
        alignment: alignment,
        child: Material(
            elevation: elevation,
            child: SizedBox(
              width: width,
              height: height,
              child: body,
            )),
      );
    },
    transitionBuilder: (_, animation, __, child) {
      Tween<Offset> tween;
      if (type == ModalSideSheetType.left) {
        tween = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(child: child, position: tween.animate(animation));
    },
  );
}
