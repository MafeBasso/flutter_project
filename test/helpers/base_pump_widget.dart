import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension BasePump on WidgetTester {
  Future<void> scaffoldPumpWidget(Widget widget) async {
    await pumpWidget(MaterialApp(
      home: Scaffold(
        body: widget,
      ),
    ));
  }
}
