import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

class AppServiceCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String description;
  final bool compact;
  final int? maxDescriptionLines;

  const AppServiceCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    this.compact = false,
    this.maxDescriptionLines,
  });

  @override
  State<AppServiceCard> createState() => _AppServiceCardState();
}

class _AppServiceCardState extends State<AppServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cardBorderRadius = AppResponsive.propertyCardBorderRadius(context);
    final imageAspectRatio = widget.compact ? 4 / 3 : 16 / 10;
    final descriptionLines =
        widget.maxDescriptionLines ?? (widget.compact ? 2 : 3);

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
          decoration: BoxDecoration(
            borderRadius: cardBorderRadius,
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary
                  : AppColors.primary.withValues(alpha: 0.12),
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: Offset.zero,
                    ),
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: cardBorderRadius,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: imageAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        widget.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.lightBeige,
                          child: Icon(
                            Icons.image_outlined,
                            color: AppColors.primary.withValues(alpha: 0.4),
                            size: AppResponsive.scaleSize(
                              context,
                              widget.compact ? 36 : 48,
                              min: 28,
                              max: 56,
                            ),
                          ),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.black.withValues(alpha: 0.18),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: AppSpacing.symmetric(
                    context,
                    h: 0.02,
                    v: widget.compact ? 0.025 : 0.03,
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.title,
                        style: AppTextStyles.displayLabel(context).copyWith(
                          color: AppColors.primary,
                          fontSize: AppResponsive.fontSizeClamped(
                            context,
                            min: widget.compact ? 14 : 16,
                            max: widget.compact ? 18 : 22,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      AppSpacing.vertical(context, 0.015),
                      Text(
                        widget.description,
                        style: AppTextStyles.bodyText(context).copyWith(
                          color: AppColors.black.withValues(alpha: 0.7),
                          height: 1.55,
                          fontSize: AppResponsive.fontSizeClamped(
                            context,
                            min: widget.compact ? 12 : 14,
                            max: widget.compact ? 15 : 17,
                          ),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: descriptionLines,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
