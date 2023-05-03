import 'package:flutter_project/app/router/app_navigation.dart';
import 'package:flutter_project/data/datasources/user_datasource.dart';
import 'package:flutter_project/data/repositories/user_repository.dart';
import 'package:flutter_project/domain/repositories/user_repository.dart';
import 'package:flutter_project/domain/usecases/get_user_info.dart';
import 'package:flutter_project/presentation/presentation.dart';
import 'package:get_it/get_it.dart';

final injectable = GetIt.instance;

void setupDependencies() {
  //DATASOURCES
  injectable.registerFactory<UserDataSource>(() => UserDataSourceImpl());

  //REPOSITORIES
  injectable.registerFactory<UserRepository>(
    () => UserRepositoryImpl(
      dataSource: injectable.get<UserDataSource>(),
    ),
  );

  //USECASES
  injectable.registerFactory<GetUserInfo>(
    () => GetUserInfo(
      repository: injectable.get<UserRepository>(),
    ),
  );

  //CUBITS
  injectable.registerSingleton<UserInfoCubit>(
    UserInfoCubit(
      getUserInfo: injectable.get<GetUserInfo>(),
    ),
  );
  injectable.registerSingleton<UserLoginCubit>(
    UserLoginCubit(),
  );

  injectable.registerLazySingleton<AppNavigation>(() => AppNavigation());
}
