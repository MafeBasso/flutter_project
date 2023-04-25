import 'package:flutter/material.dart';
import 'package:flutter_project/app/router/routes.dart';
import 'package:flutter_project/presentation/login/login_screen.dart';
import 'package:flutter_project/presentation/splash/splash_screen.dart';

final routes = <String, Widget Function(BuildContext)>{
  Routes.splash: (context) => const SplashScreen(),
  Routes.login: (context) => const LoginScreen(),
};

// extension<T> on BuildContext {
//   T get args => ModalRoute.of(this)!.settings.arguments as T;
// }
