import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/app_constants.dart';
import 'screens/home_screen.dart';
import 'theme/app_themes.dart';

const String _darkModePreferenceKey = 'isDarkMode';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final initialIsDarkMode = await _loadInitialThemePreference();
  final appVersionLabel = await _loadAppVersionLabel();

  runApp(
    BilliardCostApp(
      initialIsDarkMode: initialIsDarkMode,
      appVersionLabel: appVersionLabel,
    ),
  );
}

Future<bool> _loadInitialThemePreference() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_darkModePreferenceKey) ?? true;
}

Future<String> _loadAppVersionLabel() async {
  final packageInfo = await PackageInfo.fromPlatform();
  return AppConstants.formatVersionLabel(
    version: packageInfo.version,
  );
}

class BilliardCostApp extends StatefulWidget {
  const BilliardCostApp({
    super.key,
    required this.initialIsDarkMode,
    required this.appVersionLabel,
  });

  final bool initialIsDarkMode;
  final String appVersionLabel;

  @override
  State<BilliardCostApp> createState() => _BilliardCostAppState();
}

class _BilliardCostAppState extends State<BilliardCostApp> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.initialIsDarkMode;
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
        appVersionLabel: widget.appVersionLabel,
        onThemeModeChanged: _setDarkMode,
      ),
    );
  }
}
