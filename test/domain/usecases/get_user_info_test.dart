import 'package:dartz/dartz.dart';
import 'package:flutter_project/app/failure/failure.dart';
import 'package:flutter_project/domain/usecases/get_user_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../entities/user/user_fixture.dart';
import '../repositories/mock_user_repository.dart';

void main() {
  const maxRepositories = 3;
  const login = 'login';
  final user = UserFixture.model;
  final userRepository = MockUserRepository();
  final sut = GetUserInfo(repository: userRepository);

  test('Should return a user on success', () async {
    when(() => userRepository.getUserInfo(login: login, maxRepositories: maxRepositories))
        .thenAnswer((_) async => Right(user));

    final result = await sut(login, maxRepositories);
    expect(result, Right(user));
  });

  test('Should return a GetUserInfoFailure on error', () async {
    when(() => userRepository.getUserInfo(login: login, maxRepositories: maxRepositories))
        .thenAnswer((_) async => Left(GetUserInfoFailure()));

    final result = await sut(login, maxRepositories);
    expect(result, Left(GetUserInfoFailure()));
  });
}
