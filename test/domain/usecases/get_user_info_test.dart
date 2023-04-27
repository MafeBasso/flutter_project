import 'package:flutter_project/domain/usecases/get_user_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../entities/user_fixture.dart';
import '../repositories/mock_user_repository.dart';

void main() {
  const login = 'login';
  final user = UserFixture.model;
  final userRepository = MockUserRepository();
  final sut = GetUserInfo(repository: userRepository);

  test('Should return a user on success', () async {
    when(() => userRepository.getUserInfo(login: login))
        .thenAnswer((_) async => user);

    final result = await sut(login);
    expect(result, user);
  });
}
