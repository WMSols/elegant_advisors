import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

class AppCategoryCard extends StatefulWidget {
  final String title;
  final String description;

  const AppCategoryCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<AppCategoryCard> createState() => _AppCategoryCardState();
}

class _AppCategoryCardState extends State<AppCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: AppSpacing.all(context, factor: 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: AppTextStyles.bodyText(context).copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.primaryFont,
                  fontSize: AppResponsive.fontSizeClamped(context, min: 18, max: 22),
                ),
                textAlign: TextAlign.left,
              ),
              AppSpacing.vertical(context, 0.01),
              Text(
                widget.description,
                style: AppTextStyles.bodyText(context).copyWith(
                  color: AppColors.black.withValues(alpha: 0.7),
                  fontSize: AppResponsive.fontSizeClamped(context, min: 14, max: 18),
                  height: 1.6,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
