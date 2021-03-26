import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//CLARO
ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFF1F1F9),
    accentColor: Color(0xFF808184),
    scaffoldBackgroundColor: Color(0xFFF1F1F9),
    cardTheme: CardTheme(
      color: Color(0xFFF5F5FE),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFFF9F9FF),
    ),
    bottomAppBarColor: Color(0xFFE6E6EF),
    bottomSheetTheme:
        BottomSheetThemeData(modalBackgroundColor: Color(0xFFE6E6EF)));

//ESCURO
ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF202124),
    accentColor: Color(0xFF3A3B3E),//404144
    scaffoldBackgroundColor: Color(0xFF202124),
    cardTheme: CardTheme(
      color: Color(0xFF202124),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFF202124),
    ),
    bottomAppBarColor: Color(0xFF1B1C1F),
    bottomSheetTheme:
        BottomSheetThemeData(modalBackgroundColor: Color(0xFF1B1C1F)));

class ThemeNotifier extends ChangeNotifier {
  final String key = 'valorTema';
  SharedPreferences prefs;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    prefs.setBool(key, _darkTheme);
  }
}
