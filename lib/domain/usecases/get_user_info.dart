import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/repositories/user_repository.dart';

class GetUserInfo {
  final UserRepository _repository;

  const GetUserInfo({required UserRepository repository})
      : _repository = repository;

  Future<User> call(login) {
    return _repository.getUserInfo(login: login);
  }
}
