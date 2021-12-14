import 'package:flutter/material.dart';

class SPNavigator {
  static void pop(BuildContext context, {Object? result}) {
    Navigator.pop(context, result);
  }

  static Future<dynamic> pushNamed(BuildContext context, String routeName,
      {Object? param}) async {
    return await Navigator.pushNamed(
      context,
      routeName,
      arguments: param,
    );
  }

  static Future<dynamic> pushReplacementNamed(
      BuildContext context, String routeName,
      {Object? param}) async {
    return await Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: param,
    );
  }

  static dynamic getParam(BuildContext context) {
    return ModalRoute.of(context)!.settings.arguments;
  }
}
