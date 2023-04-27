import 'package:flutter_project/data/datasources/user_datasource.dart';
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _dataSource;

  const UserRepositoryImpl({required UserDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<User> getUserInfo({required String login}) async {
    final User user = await _dataSource.getUserInfo(login: login);
    return user;
  }
}
