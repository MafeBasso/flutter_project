import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/presentation/user/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../domain/entities/user/user_fixture.dart';
import '../../../services/injectable/injectable.dart';

void main() {
  setupTestServices();

  final userInfoCubit = injectable.get<UserInfoCubit>();

  setUp(() {
    when(() => userInfoCubit.loadUserInfo()).thenAnswer((_) async => {});
  });

  group('UserInfoScreen', () {
    group('Loading', () {
      setUp(() {
        whenListen(
            userInfoCubit, Stream.fromIterable([const UserInfoStateLoading()]),
            initialState: const UserInfoStateLoading());
      });

      testWidgets('Should render it correctly', (tester) async {
        await tester.pumpWidget(const MaterialApp(home: UserInfoScreen()));
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('Error', () {
      setUp(() {
        whenListen(
            userInfoCubit,
            Stream.fromIterable(
                [const UserInfoStateLoading(), const UserInfoStateError()]),
            initialState: const UserInfoStateLoading());
      });

      testWidgets('Should render it correctly', (tester) async {
        await tester.pumpWidget(const MaterialApp(home: UserInfoScreen()));
        await tester.pumpAndSettle();
        expect(
            find.text(
                'Sorry, an error occurred trying to get user information by login'),
            findsOneWidget);
      });
    });

    group('Loaded', () {
      final user = UserFixture.model;

      setUp(() {
        whenListen(
            userInfoCubit,
            Stream.fromIterable([
              const UserInfoStateLoading(),
              UserInfoStateLoaded(user: user)
            ]),
            initialState: const UserInfoStateLoading());
      });

      testWidgets('Should render it correctly', (tester) async {
        await mockNetworkImages(() async {
          await tester.pumpWidget(const MaterialApp(home: UserInfoScreen()));
          await tester.pumpAndSettle();
          expect(find.byType(Image), findsOneWidget);
          expect(find.text(user.bio!), findsOneWidget);
          user.repositories!
              .map((e) => expect(find.text(e.name), findsOneWidget));
        });
      });
    });
  });
}
