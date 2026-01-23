import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';

/// Stat card widget for admin dashboard
class AdminDashboardStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? color;

  const AdminDashboardStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = AppResponsive.isMobile(context);
    final cardColor = color ?? AppColors.primary;

    final padding = isMobile
        ? AppResponsive.scaleSize(context, 16, min: 12, max: 20)
        : AppResponsive.scaleSize(context, 20, min: 16, max: 24);

    final spacing = AppResponsive.scaleSize(context, 12, min: 8, max: 16);
    final borderRadius = AppResponsive.radius(context);
    final iconBorderRadius = AppResponsive.radius(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Recalculate isMobile inside LayoutBuilder to ensure it updates
          // when screen size changes
          final currentIsMobile = AppResponsive.isMobile(context);

          // Calculate responsive icon sizes based on screen size
          // These will update when screen size changes
          final baseIconContainerSize = currentIsMobile
              ? AppResponsive.scaleSize(context, 48, min: 40, max: 56)
              : AppResponsive.scaleSize(context, 56, min: 48, max: 64);

          final baseIconSize = currentIsMobile
              ? AppResponsive.scaleSize(context, 24, min: 20, max: 28)
              : AppResponsive.scaleSize(context, 28, min: 24, max: 32);

          // Scale icon based on available space if card is very small
          final cardWidth = constraints.maxWidth;
          final scaleFactor = cardWidth > 0
              ? (cardWidth / 200).clamp(0.7, 1.0)
              : 1.0;

          final iconContainerSize = baseIconContainerSize * scaleFactor;
          final iconSize = baseIconSize * scaleFactor;

          // Calculate available width for spacing to prevent overflow
          final availableWidth = constraints.maxWidth - iconContainerSize;
          final actualSpacing = availableWidth > spacing
              ? spacing
              : (availableWidth * 0.3).clamp(4.0, spacing);

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: iconContainerSize,
                height: iconContainerSize,
                decoration: BoxDecoration(
                  color: cardColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(iconBorderRadius),
                ),
                child: Icon(icon, color: cardColor, size: iconSize),
              ),

              SizedBox(width: actualSpacing),

              // Title and Value
              Expanded(
                child: LayoutBuilder(
                  builder: (context, textConstraints) {
                    final maxHeight = textConstraints.maxHeight.isFinite
                        ? textConstraints.maxHeight
                        : double.infinity;

                    // Calculate adaptive spacing based on available height
                    // Reduce spacing when height is constrained to prevent overflow
                    final baseSpacing = AppResponsive.scaleSize(
                      context,
                      4,
                      min: 2,
                      max: 6,
                    );
                    final adaptiveSpacing = maxHeight.isFinite && maxHeight < 50
                        ? 0.0
                        : maxHeight.isFinite && maxHeight < 100
                        ? (baseSpacing * 0.3).clamp(0.0, baseSpacing)
                        : baseSpacing;

                    // Add small buffer to account for rounding errors
                    // Only apply buffer if maxHeight is large enough to prevent negative values
                    final safeMaxHeight = maxHeight.isFinite
                        ? (maxHeight > 1.0 ? maxHeight - 0.5 : maxHeight)
                        : maxHeight;

                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: safeMaxHeight,
                        minHeight: 0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              value,
                              style: AppTextStyles.headline(context).copyWith(
                                color: cardColor,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                            ),
                          ),
                          if (adaptiveSpacing > 0)
                            SizedBox(height: adaptiveSpacing),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              title,
                              style: AppTextStyles.headline(context).copyWith(
                                fontSize: AppResponsive.scaleSize(
                                  context,
                                  14,
                                  min: 12,
                                  max: 18,
                                ),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
