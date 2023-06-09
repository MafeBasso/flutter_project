import 'package:flutter/material.dart';

class AppNavigation {
  void pushNamed<T>(
    BuildContext context, {
    required String routeName,
    T? arguments,
  }) {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  void pushNamedAndRemoveAll<T>(
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

  void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
