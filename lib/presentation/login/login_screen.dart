import 'package:flutter/material.dart';
import 'package:flutter_project/app/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final loginController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final localLogin = prefs.getString(Constants.login);
      if (localLogin != null) loginController.text = localLogin;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: loginController,
                  decoration:
                      const InputDecoration(hintText: 'Enter your login'),
                ),
                TextButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString(Constants.login, loginController.text);
                    },
                    child: const Text('Send')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
