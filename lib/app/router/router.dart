import 'package:flutter/material.dart';
import 'package:flutter_project/app/router/routes.dart';

import 'package:flutter_project/presentation/presentation.dart';

final routes = <String, Widget Function(BuildContext)>{
  Routes.splash: (context) => const SplashScreen(),
  Routes.login: (context) => const UserLoginScreen(),
  Routes.userInfo: (context) => const UserInfoScreen(),
};
