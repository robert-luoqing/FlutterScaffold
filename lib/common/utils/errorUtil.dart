import '../../../common/controlls/toast.dart';
import 'package:flutter/material.dart';

class SPErrorUtil {
  static void toastError(BuildContext context, dynamic e, dynamic s) {
    print("Error, $e $s");
    SPToast.show(context, "$e");
  }
}
