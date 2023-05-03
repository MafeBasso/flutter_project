import 'package:flutter_project/domain/entities/user/user_entity.dart';
import 'package:flutter_project/domain/entities/user_repository/user_repository.dart';

extension UserExtensions on User {
  static User fromMap(Map map) {
    return User(
      avatarUrl: map['user']['avatarUrl'],
      bio: map['user']['bio'],
      repositories: (map['user']['repositories']['nodes'] as List?)
          ?.map((repo) => UserRepositoryExtensions.fromMap(repo))
          .toList(),
    );
  }
}
