import 'package:dartz/dartz.dart';
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/repositories/user_repository.dart';
import 'package:flutter_project/app/failure/failure.dart';

class GetUserInfo {
  final UserRepository _repository;

  const GetUserInfo({required UserRepository repository})
      : _repository = repository;

  Future<Either<Failure, User>> call(login) async {
    return await _repository.getUserInfo(login: login);
  }
}
