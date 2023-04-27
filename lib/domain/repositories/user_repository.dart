import 'package:flutter_project/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> getUserInfo({required String login});
}
