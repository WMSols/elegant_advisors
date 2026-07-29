import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    final baseTextTheme = GoogleFonts.playfairDisplayTextTheme();
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        surface: AppColors.lightBackground,
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,
      fontFamily: GoogleFonts.playfairDisplay().fontFamily,
      textTheme: baseTextTheme.copyWith(
        displayLarge: baseTextTheme.displayLarge,
        displayMedium: baseTextTheme.displayMedium,
        displaySmall: baseTextTheme.displaySmall,
        headlineLarge: baseTextTheme.headlineLarge,
        headlineMedium: baseTextTheme.headlineMedium,
        headlineSmall: baseTextTheme.headlineSmall,
        titleLarge: baseTextTheme.titleLarge,
        titleMedium: baseTextTheme.titleMedium,
        bodyLarge: baseTextTheme.bodyLarge,
        bodyMedium: baseTextTheme.bodyMedium,
        bodySmall: baseTextTheme.bodySmall,
        labelLarge: baseTextTheme.labelLarge,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      cardColor: AppColors.lightBackground,
      canvasColor: AppColors.lightBackground,
    );
  }
}
