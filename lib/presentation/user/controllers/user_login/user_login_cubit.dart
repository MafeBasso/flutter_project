import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/app/constants/constants.dart';
import 'package:flutter_project/presentation/user/controllers/user_login/user_login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit() : super(const UserLoginStateLoading());

  late TextEditingController _loginController;

  TextEditingController get loginController => _loginController;

  Future<void> initLogin() async {
    emit(const UserLoginStateLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final localLogin = prefs.getString(Constants.login);
      _loginController = TextEditingController(text: localLogin);
      emit(const UserLoginStateLoaded());
    } catch (error) {
      emit(UserLoginStateError(error: error));
    }
  }

  Future<bool> updateUserLogin(String login) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final loginIsSet = await prefs.setString(Constants.login, login);
      if (loginIsSet) _loginController = TextEditingController(text: login);
      return loginIsSet;
    } catch (error) {
      return false;
    }
  }
}
