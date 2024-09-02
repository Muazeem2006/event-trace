import 'package:event_trace/theme/dark_mode.dart';
import 'package:event_trace/theme/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData == lightMode
        ? themeData = darkMode
        : themeData =
            lightMode; //_themeData == darkMode ? themeData = lightMode : themeData = darkMode;
  }
}
