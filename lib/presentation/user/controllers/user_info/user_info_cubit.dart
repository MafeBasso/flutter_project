import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/app/constants/constants.dart';
import 'package:flutter_project/domain/usecases/get_user_info.dart';
import 'package:flutter_project/presentation/user/controllers/user_info/user_info_state.dart';
import 'package:flutter_project/services/injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit({
    GetUserInfo? getUserInfo,
  })  : _getUserInfo = getUserInfo ?? injectable.get<GetUserInfo>(),
        super(const UserInfoStateLoading());

  static const className = 'UserInfoCubit';

  final GetUserInfo _getUserInfo;

  Future<void> loadUserInfo() async {
    emit(const UserInfoStateLoading());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final localLogin = prefs.getString(Constants.login);

    if (localLogin != null) {
      final result = await _getUserInfo(localLogin);

      result.fold((l) => emit(const UserInfoStateError()),
          (user) => emit(UserInfoStateLoaded(user: user)));
    } else {
      emit(const UserInfoStateError());
    }
  }
}
