import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  static ThemeData get whiteTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.whiteBackground,
      primaryColor: AppColors.whiteAccent,
      colorScheme: const ColorScheme.light(
        primary: AppColors.whiteAccent,
        secondary: AppColors.whiteStrong,
        tertiary: AppColors.whiteAccent,
        surface: AppColors.whiteSurface,
        onPrimary: AppColors.whiteBackground,
        onSecondary: AppColors.whiteBackground,
        onSurface: AppColors.whiteText,
        outline: AppColors.whiteBorder,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.whiteBackground,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.whiteAccent),
        titleTextStyle: TextStyle(
          color: AppColors.whiteAccent,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.whiteBackground,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.whiteAccent,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.whiteStrong;
          }
          return Colors.grey.shade100;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.whiteStrong.withValues(alpha: 0.35);
          }
          return Colors.grey.shade400;
        }),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.whiteCard,
        prefixIconColor: AppColors.whiteAccent,
        suffixIconColor: AppColors.whiteAccent,
        labelStyle: TextStyle(color: AppColors.whiteAccent),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.whiteAccent, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.whiteBorder, width: 1),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      primaryColor: AppColors.darkAccent,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkAccent,
        secondary: AppColors.darkStrong,
        tertiary: AppColors.darkAccent,
        surface: AppColors.darkSurface,
        onPrimary: AppColors.darkBackground,
        onSecondary: AppColors.darkText,
        onSurface: AppColors.darkText,
        outline: AppColors.darkBorder,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.darkText),
        titleTextStyle: TextStyle(
          color: AppColors.darkText,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.darkSurface,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.darkAccent,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.darkAccent;
          }
          return Colors.grey.shade500;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.darkStrong.withValues(alpha: 0.45);
          }
          return Colors.grey.shade700;
        }),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkCard.withValues(alpha: 0.72),
        prefixIconColor: AppColors.darkAccent,
        suffixIconColor: AppColors.darkAccent,
        labelStyle: const TextStyle(color: AppColors.darkAccent),
        hintStyle: const TextStyle(color: Colors.white70),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkAccent, width: 2),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkBorder, width: 1),
        ),
      ),
    );
  }
}
