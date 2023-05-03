import 'package:flutter_project/app/router/app_navigation.dart';
import 'package:flutter_project/domain/usecases/get_user_info.dart';
import 'package:flutter_project/presentation/user/controllers/user_info/user_info_cubit.dart';
import 'package:flutter_project/presentation/user/controllers/user_login/user_login_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../app/router/mock_app_navigation.dart';
import '../../domain/usecases/mock_get_user_info.dart';
import '../../presentation/user/controllers/user_info/mock_user_info_cubit.dart';
import '../../presentation/user/controllers/user_login/mock_user_login_cubit.dart';

final injectable = GetIt.instance;

void setupTestServices() {
  //USECASES
  injectable.registerFactory<GetUserInfo>(() => MockGetUserInfo());

  //CUBITS
  injectable.registerSingleton<UserInfoCubit>(MockUserInfoCubit());
  injectable.registerSingleton<UserLoginCubit>(MockUserLoginCubit());
  injectable.registerSingleton<AppNavigation>(MockAppNavigation());
}
