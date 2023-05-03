import 'package:flutter_project/domain/entities/user/user_entity.dart';
import '../user_repository/user_repository_fixture.dart';

class UserFixture {
  static User model = User(
      avatarUrl: 'https://avatarUrl',
      bio: 'My bio',
      repositories: UserRepositoryFixture.list);
}
