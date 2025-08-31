import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  // lang
  Locale _locale = const Locale('en');
  Locale get locale => _locale;
  // theme
  ThemeMode _theme = ThemeMode.dark;
  ThemeMode get theme => _theme;

  void changeTheme(ThemeMode theme) {
    _theme = theme;
    notifyListeners();
  }

  void changeLang(String lang) {
    _locale = Locale(lang);
    notifyListeners();
  }
}
