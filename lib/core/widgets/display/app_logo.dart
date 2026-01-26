import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

/// Reusable logo widget displaying "ELEGANT" title and "REAL ESTATE" subtitle
class AppLogo extends StatelessWidget {
  final double? titleFontSize;
  final double? subtitleFontSize;
  final Color? color;
  final TextAlign textAlign;

  const AppLogo({
    super.key,
    this.titleFontSize,
    this.subtitleFontSize,
    this.color,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    final logoColor = color ?? AppColors.primary;

    // Use provided font sizes or default to responsive heading size
    final titleSize =
        titleFontSize ??
        AppResponsive.fontSizeClamped(context, min: 20, max: 30);

    // Subtitle is 60% of title size if not provided
    final subtitleSize = subtitleFontSize ?? (titleSize * 0.5);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppTexts.logoTitle,
          style: AppTextStyles.heading(context).copyWith(
            fontFamily: AppFonts.logoFont,
            color: logoColor,
            fontSize: titleSize,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
            height: 1.0,
          ),
          textAlign: textAlign,
        ),
        Text(
          AppTexts.logoSubtitle,
          style: AppTextStyles.heading(context).copyWith(
            fontFamily: AppFonts.logoFont,
            color: logoColor,
            fontSize: subtitleSize,
            fontWeight: FontWeight.w300,
            letterSpacing: 1.0,
            height: 1.0,
          ),
          textAlign: textAlign,
        ),
      ],
    );
  }
}
