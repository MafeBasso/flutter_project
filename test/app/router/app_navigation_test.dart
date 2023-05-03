import 'package:flutter/material.dart';
import 'package:flutter_project/app/router/app_navigation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../services/injectable/injectable.dart';

void main() {
  injectable.registerSingleton<AppNavigation>(AppNavigation());
  final routes = <String, Widget Function(BuildContext)>{
    '/': (context) => const FirstPage(),
    '/secondPage': (context) => const SecondPage(),
  };

  Future<void> pumpApp(WidgetTester tester) {
    return tester.pumpWidget(MaterialApp(initialRoute: '/', routes: routes));
  }

  group('App Navigation', () {
    testWidgets('should pushNamed to second page', (WidgetTester tester) async {
      await pumpApp(tester);

      final button = find.byKey(const Key('pushNamed'));
      await tester.tap(button);
      await tester.pumpAndSettle();

      expect(find.byType(SecondPage), findsOneWidget);
      expect(find.text('SecondPage'), findsOneWidget);
    });

    testWidgets('should push and remove all to second page',
        (WidgetTester tester) async {
      await pumpApp(tester);

      await tester.tap(find.byKey(const Key('pushNamedAndRemoveAll')));
      await tester.pumpAndSettle();

      expect(find.byType(SecondPage), findsOneWidget);
      expect(find.text('SecondPage'), findsOneWidget);
    });

    testWidgets('should push to second page and pop to first page',
        (WidgetTester tester) async {
      await pumpApp(tester);

      await tester.tap(find.byKey(const Key('pushNamed')));
      await tester.pumpAndSettle();

      expect(find.byType(SecondPage), findsOneWidget);
      expect(find.text('SecondPage'), findsOneWidget);

      await tester.tap(find.byKey(const Key('pop')));
      await tester.pumpAndSettle();

      expect(find.byType(FirstPage), findsOneWidget);
      expect(find.text('SecondPage'), findsNothing);
    });
  });
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Row(
          children: [
            ElevatedButton(
              key: const Key('pushNamed'),
              onPressed: () => injectable
                  .get<AppNavigation>()
                  .pushNamed(context, routeName: '/secondPage'),
              child: const Text('pushNamed'),
            ),
          ],
        ),
        Row(
          children: [
            ElevatedButton(
              key: const Key('pushNamedAndRemoveAll'),
              onPressed: () => injectable
                  .get<AppNavigation>()
                  .pushNamedAndRemoveAll(context, routeName: '/secondPage'),
              child: const Text('pushNamedAndRemoveAll'),
            ),
          ],
        ),
      ],
    ));
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SecondPage')),
      body: Row(
        children: [
          ElevatedButton(
            key: const Key('pop'),
            onPressed: () => injectable.get<AppNavigation>().pop(context),
            child: const Text('pop!'),
          ),
        ],
      ),
    );
  }
}
