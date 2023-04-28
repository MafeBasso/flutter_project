import 'package:dartz/dartz.dart';
import 'package:flutter_project/app/failure/failure.dart';
import 'package:flutter_project/data/datasources/user_datasource.dart';
import 'package:flutter_project/domain/entities/user/user_entity.dart';
import 'package:flutter_project/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _dataSource;

  const UserRepositoryImpl({required UserDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Either<Failure, User>> getUserInfo(
      {required String login, required int maxRepositories}) async {
    return await _dataSource.getUserInfo(
        login: login, maxRepositories: maxRepositories);
  }
}
