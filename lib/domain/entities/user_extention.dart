import 'package:flutter_project/domain/entities/user.dart';

extension UserExtensions on User {
  static User fromMap(Map map) {
    return User(
      avatarUrl: map['user']['avatarUrl'],
      bio: map['user']['bio'],
    );
  }

  User copyWith({
    String? avatarUrl,
    String? bio,
  }) {
    return User(
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
    );
  }
}
