import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const BilliardCostApp());
}

class BilliardCostApp extends StatelessWidget {
  const BilliardCostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.blanco,
        primaryColor: AppColors.azulTorneo,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.blanco,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.azulTorneo),
          titleTextStyle: TextStyle(
            color: AppColors.azulTorneo,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.azulTorneo,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          prefixIconColor: AppColors.azulTorneo,
          suffixIconColor: AppColors.azulTorneo,
          labelStyle: TextStyle(color: AppColors.verdeCarruaje),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.azulTorneo, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.maderaCaoba, width: 1),
          ),
        ),
      ),
      home: const BilliardCostScreen(),
    );
  }
}
