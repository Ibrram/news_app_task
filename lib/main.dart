import 'package:flutter/material.dart';
import 'package:news_app_task/core/providers/app_provider.dart';
import 'package:news_app_task/core/routes/app_routes.dart';
import 'package:news_app_task/core/routes/routes_name.dart';
import 'package:news_app_task/core/theme_manager/app_theme_manager.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return MaterialApp(
      theme: AppThemeManager.light,
      themeMode: provider.theme,
      initialRoute: RoutesName.splash,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: provider.locale,
    );
  }
}
