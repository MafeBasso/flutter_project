import 'package:flutter/material.dart';

class AppNavigation {
  static void pushNamed<T>(
    BuildContext context, {
    required String routeName,
    T? arguments,
  }) {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  static void pushNamedAndRemoveAll<T>(
    BuildContext context, {
    required String routeName,
    T? arguments,
  }) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      (_) => false,
      arguments: arguments,
    );
  }

  static void pop(BuildContext context, {String? fallbackRoute}) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    } else if (fallbackRoute != null) {
      pushNamedAndRemoveAll(context, routeName: fallbackRoute);
    }
  }
}
