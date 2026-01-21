import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

/// Reusable hero header content widget
/// Displays title, subtitle, description, and optional action button
class ClientHeroHeaderContent extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? description;
  final Widget? actionButton;
  final TextAlign textAlign;
  final double? titleFontSizeMin;
  final double? titleFontSizeMax;
  final FontWeight? titleFontWeight;
  final double? letterSpacing;

  const ClientHeroHeaderContent({
    super.key,
    required this.title,
    this.subtitle,
    this.description,
    this.actionButton,
    this.textAlign = TextAlign.center,
    this.titleFontSizeMin,
    this.titleFontSizeMax,
    this.titleFontWeight,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = AppResponsive.isMobile(context);

    if (isMobile && textAlign == TextAlign.left) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main Headline
          Text(
            title,
            style: AppTextStyles.headline(context).copyWith(
              color: AppColors.white,
              fontWeight: titleFontWeight ?? FontWeight.w300,
              letterSpacing: letterSpacing ?? 2,
              fontSize: AppResponsive.fontSizeClamped(
                context,
                min: titleFontSizeMin ?? 28,
                max: titleFontSizeMax ?? 36,
              ),
            ),
            textAlign: TextAlign.left,
          ),
          if (subtitle != null) ...[
            AppSpacing.vertical(context, 0.04),
            Text(
              subtitle!,
              style: AppTextStyles.heading(context).copyWith(
                color: AppColors.white.withValues(alpha: 0.9),
                fontSize: AppResponsive.fontSizeClamped(
                  context,
                  min: 18,
                  max: 24,
                ),
              ),
              textAlign: TextAlign.left,
            ),
          ],
          if (description != null) ...[
            AppSpacing.vertical(context, 0.04),
            Text(
              description!,
              style: AppTextStyles.bodyText(context).copyWith(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: AppResponsive.fontSizeClamped(
                  context,
                  min: 14,
                  max: 18,
                ),
              ),
              textAlign: TextAlign.left,
            ),
          ],
          if (actionButton != null) ...[
            AppSpacing.vertical(context, 0.06),
            actionButton!,
          ],
        ],
      );
    }

    // Desktop or centered mobile
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: AppResponsive.screenWidth(context) * 0.9,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Main Headline
            Text(
              title,
              style: AppTextStyles.headline(context).copyWith(
                color: AppColors.white,
                fontWeight: titleFontWeight ?? FontWeight.w300,
                letterSpacing: letterSpacing ?? 2,
                fontSize: AppResponsive.fontSizeClamped(
                  context,
                  min: titleFontSizeMin ?? 32,
                  max: titleFontSizeMax ?? 56,
                ),
              ),
              textAlign: textAlign,
            ),
            if (subtitle != null) ...[
              AppSpacing.vertical(context, 0.02),
              Text(
                subtitle!,
                style: AppTextStyles.heading(context).copyWith(
                  color: AppColors.white.withValues(alpha: 0.9),
                  fontSize: AppResponsive.fontSizeClamped(
                    context,
                    min: 18,
                    max: 24,
                  ),
                ),
                textAlign: textAlign,
              ),
            ],
            if (description != null) ...[
              AppSpacing.vertical(context, 0.02),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: AppResponsive.screenWidth(context) * 0.6,
                ),
                child: Text(
                  description!,
                  style: AppTextStyles.bodyText(context).copyWith(
                    color: AppColors.white.withValues(alpha: 0.8),
                    fontSize: AppResponsive.fontSizeClamped(
                      context,
                      min: 14,
                      max: 18,
                    ),
                  ),
                  textAlign: textAlign,
                ),
              ),
            ],
            if (actionButton != null) ...[
              AppSpacing.vertical(context, 0.06),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: AppResponsive.screenWidth(context) * 0.2,
                ),
                child: actionButton!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
