import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeModeProvider extends ChangeNotifier {
  ThemeMode _currentThemeMode = ThemeMode.light;

  ThemeMode get currentThemeMode => _currentThemeMode;

  void toggleThemeMode() {
    _currentThemeMode = _currentThemeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }
}
