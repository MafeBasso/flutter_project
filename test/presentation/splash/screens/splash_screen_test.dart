import 'package:flutter/material.dart';
import 'package:flutter_project/app/router/app_navigation.dart';
import 'package:flutter_project/app/router/routes.dart';
import 'package:flutter_project/presentation/splash/screens/splash_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/base_pump_widget.dart';
import '../../../helpers/fake_build_context.dart';
import '../../../services/injectable/injectable.dart';

void main() {
  setupTestServices();
  setUpAll(() => registerFallbackValue(FakeBuildContext()));

  group('SplashScreen', () {
    testWidgets('Should render it correctly', (tester) async {
      await tester.runAsync(() async {
        await tester.scaffoldPumpWidget(const SplashScreen());
        expect(find.byIcon(Icons.coffee), findsOneWidget);
      });
    });

    testWidgets('Should go to UserLoginScreen when timer ends', (tester) async {
      await tester.scaffoldPumpWidget(const SplashScreen());
      await tester.pumpAndSettle(
        const Duration(milliseconds: 300),
      );
      verify(() => injectable.get<AppNavigation>().pushNamedAndRemoveAll(
            any(),
            routeName: Routes.login,
          )).called(1);
    });
  });
}
