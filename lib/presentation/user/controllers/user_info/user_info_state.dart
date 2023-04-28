import 'package:equatable/equatable.dart';
import 'package:flutter_project/domain/entities/user.dart';

class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List get props => [];
}

class UserInfoStateLoading extends UserInfoState {
  const UserInfoStateLoading();
}

class UserInfoStateLoaded extends UserInfoState {
  final User user;

  const UserInfoStateLoaded({required this.user});

  @override
  List get props => [user];
}

class UserInfoStateError extends UserInfoState {
  const UserInfoStateError();
}
