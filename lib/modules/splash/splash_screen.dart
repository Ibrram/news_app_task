import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app_task/core/constants/app_assets.dart';
import 'package:news_app_task/core/providers/app_provider.dart';
import 'package:news_app_task/core/routes/routes_name.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
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
                (provider.theme == ThemeMode.light)
                    ? AppAssets.micImg
                    : AppAssets.micImgDark,
                height: 298,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Image.asset(
            (provider.theme == ThemeMode.light)
                ? AppAssets.routeLogoImg
                : AppAssets.routeLogoImgDark,
            height: 86,
          ),
        ],
      ),
    );
  }
}
