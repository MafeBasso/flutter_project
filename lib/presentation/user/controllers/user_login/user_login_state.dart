import 'package:equatable/equatable.dart';
import 'package:flutter_project/domain/entities/user.dart';

class UserLoginState extends Equatable {
  const UserLoginState();

  @override
  List get props => [];
}

class UserLoginStateLoading extends UserLoginState {
  const UserLoginStateLoading();
}

class UserLoginStateLoaded extends UserLoginState {
  const UserLoginStateLoaded();
}

class UserLoginStateError extends UserLoginState {
  final Object error;

  const UserLoginStateError({required this.error});

  @override
  List get props => [error];
}