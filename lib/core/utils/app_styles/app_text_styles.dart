import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle _pf(
    BuildContext context, {
    required double min,
    required double max,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: AppFonts.primaryFont,
      fontSize: AppResponsive.fontSizeClamped(context, min: min, max: max),
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle headline(BuildContext context) =>
      _pf(context, min: 28, max: 40);

  static TextStyle heading(BuildContext context) =>
      _pf(context, min: 20, max: 30);

  static TextStyle displayTitle(BuildContext context) =>
      _pf(context, min: 24, max: 30, fontWeight: FontWeight.w600);

  static TextStyle displayLabel(BuildContext context) =>
      _pf(context, min: 16, max: 22, fontWeight: FontWeight.w500);

  static TextStyle navLabel(BuildContext context) =>
      _pf(context, min: 14, max: 16, letterSpacing: 0.5);

  static TextStyle tagline(BuildContext context) =>
      _pf(context, min: 14, max: 18, fontStyle: FontStyle.italic);

  static TextStyle bodyText(BuildContext context) =>
      _pf(context, min: 14, max: 18);

  static TextStyle hintText(BuildContext context) =>
      _pf(context, min: 12, max: 16, color: Theme.of(context).hintColor);

  static TextStyle buttonText(BuildContext context) => _pf(
    context,
    min: 12,
    max: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle errorText(BuildContext context) =>
      _pf(context, min: 11, max: 12, color: AppColors.error);
}
