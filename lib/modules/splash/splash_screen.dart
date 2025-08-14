import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app_task/core/constants/app_assets.dart';
import 'package:news_app_task/core/routes/routes_name.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      Navigator.pushReplacementNamed(context, RoutesName.home);
    });
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                AppAssets.micImg,
                height: 298,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Image.asset(AppAssets.routeLogoImg, height: 86),
        ],
      ),
    );
  }
}
