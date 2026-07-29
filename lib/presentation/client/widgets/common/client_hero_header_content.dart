import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/widgets/text/app_text.dart';

/// Reusable hero header content widget
/// Displays title, tagline, subtitle, description, and optional action button
class ClientHeroHeaderContent extends StatelessWidget {
  final String title;
  final String? tagline;
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
    this.tagline,
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
    final align = isMobile && textAlign == TextAlign.left
        ? TextAlign.left
        : textAlign;
    final crossAlign = align == TextAlign.left
        ? CrossAxisAlignment.start
        : CrossAxisAlignment.center;

    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: crossAlign,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(
          title,
          style: AppTextStyles.headline(context).copyWith(
            color: AppColors.white,
            fontWeight: titleFontWeight ?? FontWeight.w300,
            letterSpacing: letterSpacing ?? 2,
            fontSize: AppResponsive.fontSizeClamped(
              context,
              min: titleFontSizeMin ?? (isMobile ? 28 : 32),
              max: titleFontSizeMax ?? (isMobile ? 36 : 56),
            ),
          ),
          textAlign: align,
        ),
        if (tagline != null) ...[
          AppSpacing.vertical(context, 0.025),
          AppText(
            tagline!,
            style: AppTextStyles.tagline(context).copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: AppResponsive.fontSizeClamped(
                context,
                min: 14,
                max: 18,
              ),
            ),
            textAlign: align,
          ),
        ],
        if (subtitle != null) ...[
          AppSpacing.vertical(context, 0.03),
          AppText(
            subtitle!,
            style: AppTextStyles.heading(context).copyWith(
              color: AppColors.white.withValues(alpha: 0.9),
              fontSize: AppResponsive.fontSizeClamped(
                context,
                min: 18,
                max: 24,
              ),
            ),
            textAlign: align,
          ),
        ],
        if (description != null) ...[
          AppSpacing.vertical(context, 0.03),
          AppText(
            description!,
            style: AppTextStyles.bodyText(context).copyWith(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: AppResponsive.fontSizeClamped(
                context,
                min: 14,
                max: 18,
              ),
            ),
            textAlign: align,
          ),
        ],
        if (actionButton != null) ...[
          AppSpacing.vertical(context, 0.06),
          actionButton!,
        ],
      ],
    );

    if (isMobile && textAlign == TextAlign.left) {
      return content;
    }

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: AppResponsive.screenWidth(context) * 0.9,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [content]),
      ),
    );
  }
}
