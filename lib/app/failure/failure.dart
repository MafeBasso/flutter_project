import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure() : super();

  @override
  List<Object?> get props => [];
}

class GetUserInfoFailure extends Failure {}
