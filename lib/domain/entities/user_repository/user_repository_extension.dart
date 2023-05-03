import 'package:flutter_project/domain/entities/user_repository/user_repository_entity.dart';

extension UserRepositoryExtensions on UserRepository {
  static UserRepository fromMap(Map map) {
    return UserRepository(
      name: map['name'],
    );
  }
}
