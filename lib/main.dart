import 'package:flutter/material.dart';
import 'package:news_app_task/core/routes/app_routes.dart';
import 'package:news_app_task/core/routes/routes_name.dart';
import 'package:news_app_task/core/theme_manager/app_theme_manager.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeManager.light,
      themeMode: ThemeMode.light,
      initialRoute: RoutesName.splash,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
    );
  }
}
