import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_project/app/constants/constants.dart';
import 'package:flutter_project/app/failure/failure.dart';
import 'package:flutter_project/domain/usecases/get_user_info.dart';
import 'package:flutter_project/presentation/user/controllers/user_info/user_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/entities/user/user_fixture.dart';
import '../../../../services/injectable/injectable.dart';

void main() {
  setupTestServices();

  const login = 'login';
  final user = UserFixture.model;
  final getUserInfo = injectable.get<GetUserInfo>();

  UserInfoCubit sut() => UserInfoCubit(getUserInfo: getUserInfo);

  group('UserInfoCubit', () {
    test('UserInfoCubit init state should be no UserInfoStateLoading', () {
      expect(sut().state, const UserInfoStateLoading());
    });

    group('loadUserInfo', () {
      blocTest<UserInfoCubit, UserInfoState>(
        'Emits UserInfoStateLoading and UserInfoStateLoaded on success',
        build: sut,
        setUp: () {
          SharedPreferences.setMockInitialValues({Constants.login: login});
          when(() => getUserInfo.call(login, 100))
              .thenAnswer((_) async => Right(user));
        },
        act: (cubit) => cubit.loadUserInfo(),
        expect: () =>
            [const UserInfoStateLoading(), UserInfoStateLoaded(user: user)],
      );
    });

    group('loadUserInfo', () {
      blocTest<UserInfoCubit, UserInfoState>(
        'Emits UserInfoStateLoading and UserInfoStateLoaded on success',
        build: sut,
        setUp: () {
          SharedPreferences.setMockInitialValues({Constants.login: login});
          when(() => getUserInfo.call(login, 100))
              .thenAnswer((_) async => Right(user));
        },
        act: (cubit) => cubit.loadUserInfo(),
        expect: () =>
        [const UserInfoStateLoading(), UserInfoStateLoaded(user: user)],
      );

      blocTest<UserInfoCubit, UserInfoState>(
        'Emits UserInfoStateLoading and UserInfoStateError on failure',
        build: sut,
        setUp: () {
          SharedPreferences.setMockInitialValues({Constants.login: login});
          when(() => getUserInfo.call(login, 100))
              .thenAnswer((_) async => Left(GetUserInfoFailure()));
        },
        act: (cubit) => cubit.loadUserInfo(),
        expect: () =>
        [const UserInfoStateLoading(), const UserInfoStateError()],
      );

      blocTest<UserInfoCubit, UserInfoState>(
        'Emits UserInfoStateLoading and UserInfoStateError on none local login',
        build: sut,
        act: (cubit) => cubit.loadUserInfo(),
        expect: () =>
        [const UserInfoStateLoading(), const UserInfoStateError()],
      );
    });
  });
}
