import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class SPScreen {
  static Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }
}
