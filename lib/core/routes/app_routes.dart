import 'package:flutter/material.dart';
import 'package:news_app_task/core/routes/routes_name.dart';
import 'package:news_app_task/modules/splash/splash_screen.dart';

abstract class AppRoutes {
  static Route<dynamic> onGenerateRoutes(RouteSettings setting) {
    switch (setting.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: setting,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: setting,
        );
    }
  }
}
