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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state.user.avatarUrl != null ? Image.network(
                      state.user.avatarUrl!,
                    ) : const Text('No avatar URL'),
                    Text(
                      state.user.bio ?? 'No bio',
                    ),
                    if (state.user.repositories != null)
                      Expanded(
                        child: ListView.builder(
                            itemCount: state.user.repositories!.length,
                            itemBuilder: (context, index) {
                              return Text(state.user.repositories![index].name,);
                            }),
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
