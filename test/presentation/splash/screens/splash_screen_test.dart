import 'package:flutter/material.dart';
import 'package:flutter_project/presentation/splash/screens/splash_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/base_pump_widget.dart';

void main() {
  group('SplashScreen', () {
    testWidgets('Should render it correctly', (tester) async {
      await tester.runAsync(() async {
        await tester.scaffoldPumpWidget(const SplashScreen());
        expect(find.byIcon(Icons.coffee), findsOneWidget);
      });
    });
  });
}
