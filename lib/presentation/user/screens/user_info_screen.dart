import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/services/injectable/injectable.dart';
import 'package:flutter_project/presentation/user/controllers/user_info/user_info.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _userInfoCubit = injectable.get<UserInfoCubit>();

  @override
  void initState() {
    _userInfoCubit.loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<UserInfoCubit, UserInfoState>(
            bloc: _userInfoCubit,
            builder: (context, state) {
              if (state is UserInfoStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserInfoStateLoaded) {
                return Column(
                  children: [
                    Text(
                      state.user.avatarUrl ?? 'No avatar URL',
                    ),
                    Text(
                      state.user.bio ?? 'No bio',
                    ),
                  ],
                );
              }
              return Column(
                children: const [
                  Text(
                      'Sorry, an error occurred trying to get user information by login'),
                ],
              );
            }),
      ),
    );
  }
}
