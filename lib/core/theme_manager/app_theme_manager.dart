import 'package:flutter/material.dart';
import 'package:news_app_task/core/theme_manager/colors_palette.dart';

class AppThemeManager {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: ColorsPalette.scaffoldBackground,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      scrolledUnderElevation: 0,
      backgroundColor: ColorsPalette.scaffoldBackground,
      foregroundColor: ColorsPalette.primaryBlackColor,
      actionsPadding: const EdgeInsets.all(16),
      actionsIconTheme: const IconThemeData(
        color: ColorsPalette.primaryBlackColor,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: ColorsPalette.primaryBlackColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: ColorsPalette.primaryBlackColor,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: ColorsPalette.primaryBlackColor,
      ),
      displayMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: ColorsPalette.primaryBlackColor,
      ),
      displaySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: ColorsPalette.hintBlackColor,
      ),
    ),
  );
}
