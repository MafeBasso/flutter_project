import 'package:flutter_project/app/router/app_navigation.dart';
import 'package:flutter_project/data/datasources/user_datasource.dart';
import 'package:flutter_project/domain/repositories/user_repository.dart';
import 'package:flutter_project/domain/usecases/get_user_info.dart';
import 'package:flutter_project/presentation/user/controllers/user_info/user_info_cubit.dart';
import 'package:flutter_project/presentation/user/controllers/user_login/user_login_cubit.dart';
import 'package:flutter_project/services/graphql/graphql_config.dart';
import 'package:flutter_project/services/injectable/injectable.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  setUpAll(() async {
    await graphQLConfig.init();
  });

  group('Service Locator >', () {
    test('When setup dependencies, should check if its registered', () {
      setupDependencies();

      expect(injectable.isRegistered<UserDataSource>(), isTrue);
      expect(injectable.isRegistered<UserRepository>(), isTrue);
      expect(injectable.isRegistered<GetUserInfo>(), isTrue);
      expect(injectable.isRegistered<UserInfoCubit>(), isTrue);
      expect(injectable.isRegistered<UserLoginCubit>(), isTrue);
      expect(injectable.isRegistered<AppNavigation>(), isTrue);
    });
  });
}
