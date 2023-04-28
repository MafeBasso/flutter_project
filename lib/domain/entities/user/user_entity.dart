import 'package:equatable/equatable.dart';
import 'package:flutter_project/domain/entities/user_repository/user_repository_entity.dart';

class User extends Equatable {
  final String? avatarUrl;
  final String? bio;
  final List<UserRepository>? repositories;

  const User({
    this.avatarUrl,
    this.bio,
    this.repositories,
  });

  @override
  List<Object?> get props => [avatarUrl, bio, repositories];
}
