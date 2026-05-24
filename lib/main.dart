import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home_screen.dart';
import 'theme/app_themes.dart';

void main() {
  runApp(const BilliardCostApp());
}

class BilliardCostApp extends StatefulWidget {
  const BilliardCostApp({super.key});

  @override
  State<BilliardCostApp> createState() => _BilliardCostAppState();
}

class _BilliardCostAppState extends State<BilliardCostApp> {
  static const String _darkModePreferenceKey = 'isDarkMode';

  bool _isDarkMode = true;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDarkMode = prefs.getBool(_darkModePreferenceKey);

    if (!mounted) return;

    setState(() {
      _isDarkMode = savedDarkMode ?? true;
    });
  }

  Future<void> _setDarkMode(bool value) async {
    setState(() {
      _isDarkMode = value;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModePreferenceKey, value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.whiteTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: BilliardCostScreen(
        isDarkMode: _isDarkMode,
        onThemeModeChanged: _setDarkMode,
      ),
    );
  }
}
