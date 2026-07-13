import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle headline(BuildContext context) => TextStyle(
    fontSize: AppResponsive.fontSizeClamped(context, min: 28, max: 40),
    fontFamily: AppFonts.displayFont,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );

  static TextStyle heading(BuildContext context) => TextStyle(
    fontSize: AppResponsive.fontSizeClamped(context, min: 20, max: 30),
    fontFamily: AppFonts.displayFont,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );

  static TextStyle displayTitle(BuildContext context) => TextStyle(
    fontSize: AppResponsive.fontSizeClamped(context, min: 24, max: 30),
    fontFamily: AppFonts.displayFont,
    fontWeight: FontWeight.w600,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );

  static TextStyle displayLabel(BuildContext context) => TextStyle(
    fontSize: AppResponsive.fontSizeClamped(context, min: 16, max: 22),
    fontFamily: AppFonts.displayFont,
    fontWeight: FontWeight.w500,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );

  static TextStyle navLabel(BuildContext context) => TextStyle(
    fontSize: AppResponsive.fontSizeClamped(context, min: 14, max: 16),
    fontFamily: AppFonts.displayFont,
    letterSpacing: 0.5,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );

  static TextStyle tagline(BuildContext context) => TextStyle(
    fontSize: AppResponsive.fontSizeClamped(context, min: 14, max: 18),
    fontFamily: AppFonts.primaryFont,
    fontStyle: FontStyle.italic,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );

  static TextStyle bodyText(BuildContext context) => TextStyle(
    fontSize: AppResponsive.fontSizeClamped(context, min: 14, max: 18),
    fontFamily: AppFonts.secondaryFont,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );

  static TextStyle hintText(BuildContext context) => TextStyle(
    fontSize: AppResponsive.fontSizeClamped(context, min: 12, max: 16),
    fontFamily: AppFonts.secondaryFont,
    color: Theme.of(context).hintColor,
  );

  static TextStyle buttonText(BuildContext context) => TextStyle(
    fontSize: AppResponsive.fontSizeClamped(context, min: 12, max: 16),
    fontFamily: AppFonts.displayFont,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle errorText(BuildContext context) => TextStyle(
    fontSize: AppResponsive.fontSizeClamped(context, min: 11, max: 12),
    fontFamily: AppFonts.secondaryFont,
    color: AppColors.error,
  );
}
