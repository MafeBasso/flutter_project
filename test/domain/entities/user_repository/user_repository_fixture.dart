import 'package:flutter_project/domain/entities/user_repository/user_repository.dart';

class UserRepositoryFixture {
  static UserRepository model = const UserRepository(
    name: 'Fake repository',
  );

  static UserRepository other = const UserRepository(
    name: 'Other fake repository',
  );

  static List<UserRepository> list = [model, other];
}
