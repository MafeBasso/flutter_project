import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? avatarUrl;
  final String? bio;

  const User({
    this.avatarUrl,
    this.bio,
  });

  @override
  List<Object?> get props => [avatarUrl, bio];
}
