import 'package:dartz/dartz.dart';
import 'package:flutter_project/app/failure/failure.dart';
import 'package:flutter_project/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUserInfo({required String login});
}
