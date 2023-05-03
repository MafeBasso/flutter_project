import 'package:flutter/material.dart';
import 'package:flutter_project/app/router/app_navigation.dart';
import 'package:flutter_project/app/router/routes.dart';
import 'package:flutter_project/services/injectable/injectable.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        const Duration(milliseconds: 300),
        () => injectable
            .get<AppNavigation>()
            .pushNamedAndRemoveAll(context, routeName: Routes.login));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Icon(
        Icons.coffee,
        size: 70,
      ),
    );
  }
}
