import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/app/router/app_navigation.dart';
import 'package:flutter_project/app/router/routes.dart';
import 'package:flutter_project/presentation/user/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/fake_build_context.dart';
import '../../../services/injectable/injectable.dart';

void main() {
  setupTestServices();

  final userLoginCubit = injectable.get<UserLoginCubit>();

  setUp(() {
    registerFallbackValue(FakeBuildContext());
    when(() => userLoginCubit.initLogin()).thenAnswer((_) async => {});
  });

  group('UserLoginScreen', () {
    group('Loading', () {
      setUp(() {
        whenListen(userLoginCubit,
            Stream.fromIterable([const UserLoginStateLoading()]),
            initialState: const UserLoginStateLoading());
      });

      testWidgets('Should render it correctly', (tester) async {
        await tester.pumpWidget(const MaterialApp(home: UserLoginScreen()));
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('Error', () {
      setUp(() {
        whenListen(
            userLoginCubit,
            Stream.fromIterable([
              const UserLoginStateLoading(),
              UserLoginStateError(error: Exception())
            ]),
            initialState: const UserLoginStateLoading());
      });

      testWidgets('Should render it correctly', (tester) async {
        await tester.pumpWidget(const MaterialApp(home: UserLoginScreen()));
        await tester.pumpAndSettle();
        expect(
            find.text(
                'Sorry, an error occurred trying to recover login from cache'),
            findsOneWidget);
      });
    });

    group('Loaded', () {
      setUp(() {
        whenListen(
            userLoginCubit,
            Stream.fromIterable(
                [const UserLoginStateLoading(), const UserLoginStateLoaded()]),
            initialState: const UserLoginStateLoading());
        when(() => userLoginCubit.loginController)
            .thenReturn(TextEditingController());
      });

      testWidgets('Should render it correctly', (tester) async {
        await tester.pumpWidget(const MaterialApp(home: UserLoginScreen()));
        await tester.pumpAndSettle();
        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.byType(TextButton), findsOneWidget);
      });

      group('Behaviours of empty login', () {
        testWidgets('Should show error message of empty login on tap',
            (tester) async {
          await tester.pumpWidget(const MaterialApp(home: UserLoginScreen()));
          await tester.pumpAndSettle();
          await tester.tap(find.byType(TextButton));
          await tester.pumpAndSettle();
          expect(find.text('Login cannot be empty'), findsNWidgets(2));
          expect(find.byType(SnackBar), findsOneWidget);
        });

        testWidgets(
            'Should show error message of empty login on TextFormField interaction',
            (tester) async {
          await tester.pumpWidget(const MaterialApp(home: UserLoginScreen()));
          await tester.pumpAndSettle();
          await tester.enterText(find.byType(TextFormField), 'test');
          await tester.pumpAndSettle();
          await tester.enterText(find.byType(TextFormField), '');
          await tester.pumpAndSettle();
          expect(find.text('Login cannot be empty'), findsOneWidget);
        });
      });

      group('Behaviours of already filled login', () {
        const login = 'login';

        setUp(() => when(() => userLoginCubit.loginController)
            .thenReturn(TextEditingController(text: login)));

        testWidgets('Should show error message of failed update on tap',
            (tester) async {
          when(() => userLoginCubit.updateUserLogin(login))
              .thenAnswer((_) async => false);
          await tester.pumpWidget(const MaterialApp(home: UserLoginScreen()));
          await tester.pumpAndSettle();
          await tester.tap(find.byType(TextButton));
          await tester.pumpAndSettle();
          expect(find.text('Could not update cache login'), findsOneWidget);
          expect(find.byType(SnackBar), findsOneWidget);
        });

        testWidgets('Should go to UserInfoScreen on success tap',
            (tester) async {
          when(() => userLoginCubit.updateUserLogin(login))
              .thenAnswer((_) async => true);
          await tester.pumpWidget(const MaterialApp(home: UserLoginScreen()));
          await tester.pumpAndSettle();
          await tester.tap(find.byType(TextButton));
          await tester.pumpAndSettle();
          verify(() => injectable.get<AppNavigation>().pushNamed(
                any(),
                routeName: Routes.userInfo,
              )).called(1);
        });
      });
    });
  });
}
