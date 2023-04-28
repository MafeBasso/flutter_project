import 'package:dartz/dartz.dart';
import 'package:flutter_project/app/failure/failure.dart';
import 'package:flutter_project/data/repositories/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../domain/entities/user_fixture.dart';
import '../datasources/mock_user_datasource.dart';

void main() {
  const login = 'login';
  final user = UserFixture.model;
  final userDataSource = MockUserDataSource();
  final sut = UserRepositoryImpl(dataSource: userDataSource);

  test('Should return a user on success', () async {
    when(() => userDataSource.getUserInfo(login: login))
        .thenAnswer((_) async => Right(user));

    final result = await sut.getUserInfo(login: login);
    expect(result, Right(user));
  });

  test('Should return a GetUserInfoFailure on error', () async {
    when(() => userDataSource.getUserInfo(login: login))
        .thenAnswer((_) async => Left(GetUserInfoFailure()));

    final result = await sut.getUserInfo(login: login);
    expect(result, Left(GetUserInfoFailure()));
  });
}
