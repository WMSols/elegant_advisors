import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/widgets/text/app_text.dart';

class AppCategoryCard extends StatefulWidget {
  final String title;
  final String description;
  final bool centerAligned;

  const AppCategoryCard({
    super.key,
    required this.title,
    required this.description,
    this.centerAligned = false,
  });

  @override
  State<AppCategoryCard> createState() => _AppCategoryCardState();
}

class _AppCategoryCardState extends State<AppCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final alignment = widget.centerAligned
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = widget.centerAligned ? TextAlign.center : TextAlign.left;

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
            crossAxisAlignment: alignment,
            children: [
              AppText(
                widget.title,
                style: AppTextStyles.displayLabel(context).copyWith(
                  color: AppColors.primary,
                  fontSize: AppResponsive.fontSizeClamped(
                    context,
                    min: 18,
                    max: 22,
                  ),
                ),
                textAlign: textAlign,
              ),
              AppSpacing.vertical(context, 0.01),
              AppText(
                widget.description,
                style: AppTextStyles.bodyText(context).copyWith(
                  color: AppColors.black.withValues(alpha: 0.7),
                  fontSize: AppResponsive.fontSizeClamped(
                    context,
                    min: 14,
                    max: 18,
                  ),
                  height: 1.6,
                ),
                textAlign: textAlign,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
