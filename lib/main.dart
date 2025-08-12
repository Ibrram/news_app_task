import 'package:flutter/material.dart';
import 'package:news_app_task/core/routes/app_routes.dart';
import 'package:news_app_task/core/routes/routes_name.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: RoutesName.splash,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
    );
  }
}
