import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,
      fontFamily: AppFonts.primaryFont,
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: AppFonts.displayFont),
        displayMedium: TextStyle(fontFamily: AppFonts.displayFont),
        displaySmall: TextStyle(fontFamily: AppFonts.displayFont),
        headlineLarge: TextStyle(fontFamily: AppFonts.displayFont),
        headlineMedium: TextStyle(fontFamily: AppFonts.displayFont),
        headlineSmall: TextStyle(fontFamily: AppFonts.displayFont),
        titleLarge: TextStyle(fontFamily: AppFonts.displayFont),
        titleMedium: TextStyle(fontFamily: AppFonts.displayFont),
        bodyLarge: TextStyle(fontFamily: AppFonts.primaryFont),
        bodyMedium: TextStyle(fontFamily: AppFonts.primaryFont),
        bodySmall: TextStyle(fontFamily: AppFonts.primaryFont),
        labelLarge: TextStyle(fontFamily: AppFonts.displayFont),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
