import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/app/router/app_navigation.dart';
import 'package:flutter_project/app/router/routes.dart';
import 'package:flutter_project/presentation/user/controllers/controllers.dart';
import 'package:flutter_project/services/injectable/injectable.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userLoginCubit = injectable.get<UserLoginCubit>();

  @override
  void initState() {
    _userLoginCubit.initLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<UserLoginCubit, UserLoginState>(
            bloc: _userLoginCubit,
            builder: (context, state) {
              if (state is UserLoginStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserLoginStateError) {
                return Column(
                  children: const [
                    Text(
                        'Sorry, an error occurred trying to recover login from cache'),
                  ],
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _userLoginCubit.loginController,
                        decoration:
                            const InputDecoration(hintText: 'Enter your login'),
                        validator: (value) {
                          return value != '' ? null : 'Login cannot be empty';
                        },
                      ),
                      TextButton(
                          onPressed: () =>
                              send(_userLoginCubit.loginController.text),
                          child: const Text('Send')),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future<void> send(String? login) async {
    if (_formKey.currentState!.validate()) {
      final isUpdated = await _userLoginCubit.updateUserLogin(login!);
      isUpdated
          ? AppNavigation.pushNamed(context, routeName: Routes.userInfo)
          : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Could not update cache login'),
            ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Login cannot be empty'),
      ));
    }
  }
}
