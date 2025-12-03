import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle headline(BuildContext context) => TextStyle(
    fontSize: AppResponsive.fontSizeClamped(
      context,
      min: 28, // Minimum readable size on mobile
      max: 72, // Maximum size on desktop
    ),
    fontFamily: AppFonts.primaryFont,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );

  static TextStyle heading(BuildContext context) => TextStyle(
    fontSize: AppResponsive.fontSizeClamped(
      context,
      min: 20, // Minimum readable size on mobile
      max: 48, // Maximum size on desktop
    ),
    fontFamily: AppFonts.primaryFont,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );

  static TextStyle bodyText(BuildContext context) => TextStyle(
    fontSize: AppResponsive.fontSizeClamped(
      context,
      min: 14, // Minimum readable size on mobile
      max: 18, // Maximum size on desktop
    ),
    fontFamily: AppFonts.secondaryFont,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );

  static TextStyle hintText(BuildContext context) => TextStyle(
    fontSize: AppResponsive.fontSizeClamped(
      context,
      min: 12, // Minimum readable size on mobile
      max: 16, // Maximum size on desktop
    ),
    fontFamily: AppFonts.secondaryFont,
    color: Theme.of(context).hintColor,
  );

  static TextStyle buttonText(BuildContext context) => TextStyle(
    fontSize: AppResponsive.fontSizeClamped(
      context,
      min: 14, // Minimum readable size on mobile
      max: 18, // Maximum size on desktop
    ),
    fontFamily: AppFonts.secondaryFont,
    color: Colors.white,
  );
}

