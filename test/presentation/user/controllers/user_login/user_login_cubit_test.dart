import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_project/presentation/user/controllers/user_login/user_login.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  UserLoginCubit sut() => UserLoginCubit();

  group('UserLoginCubit', () {
    test('UserLoginCubit init state should be no UserLoginStateLoading', () {
      expect(sut().state, const UserLoginStateLoading());
    });

    group('initLogin', () {
      blocTest<UserLoginCubit, UserLoginState>(
        'Emits UserLoginStateLoading and UserLoginStateLoaded on success',
        build: sut,
        act: (cubit) => cubit.initLogin(),
        expect: () =>
            [const UserLoginStateLoading(), const UserLoginStateLoaded()],
      );
    });

    group('updateUserLogin', () {
      const String login = 'login';

      blocTest<UserLoginCubit, UserLoginState>(
        'Emits nothing',
        build: sut,
        act: (cubit) => cubit.updateUserLogin(login),
        expect: () => [],
      );

      test('Should return true on success', () async {
        final bool result = await sut().updateUserLogin(login);
        expect(result, true);
      });
    });
  });
}
