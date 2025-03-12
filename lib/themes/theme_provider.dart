import 'package:flutter/material.dart';
import 'package:minimalist_music_player/themes/dark_theme.dart';
import 'package:minimalist_music_player/themes/light_theme.dart';

class ThemeProvider extends ChangeNotifier {
  // By default, light mode
  ThemeData _themeData = lightMode;

  // Get the current theme
  ThemeData get themeData => _themeData;

  // Get Dark Mode
  bool get isDarkMode => _themeData == darkMode;

  // Set Theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;

    // Update UI
    notifyListeners();
  }

  // Toggle Theme
  void toggleTheme() {
    _themeData = isDarkMode ? lightMode : darkMode;

    // Update UI
    notifyListeners();
  }
}
