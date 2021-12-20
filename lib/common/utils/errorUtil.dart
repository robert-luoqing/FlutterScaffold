import '../core/exception.dart';

import '../../../common/controlls/toast.dart';
import 'package:flutter/material.dart';

class SPErrorUtil {
  static void toastError(BuildContext context, dynamic e, dynamic s) {
    if (e.runtimeType == SPException) {
      var ex = e as SPException;
      print("Error, code: ${ex.code}, msg: ${ex.message}, stack: $s");
      SPToast.show(context, "${ex.message}");
    } else {
      print("Error, $e $s");
      SPToast.show(context, "$e");
    }
  }
}
