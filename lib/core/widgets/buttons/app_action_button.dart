import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

/// Reusable action button for dialogs (cancel, delete, etc.)
/// Used in AdminPropertyCard and other admin widgets
class AppActionButton extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final VoidCallback? onPressed;
  final bool isDestructive; // For delete/destructive actions
  final Color? backgroundColor;
  final IconData? icon; // Optional icon

  const AppActionButton({
    super.key,
    required this.label,
    this.labelColor = AppColors.white,
    this.onPressed,
    this.isDestructive = false,
    this.backgroundColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final finalBackgroundColor =
        backgroundColor ?? (isDestructive ? AppColors.error : AppColors.white);

    // Responsive sizing for desktop and mobile
    final isDesktop = AppResponsive.isDesktop(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop
                ? AppResponsive.scaleSize(context, 16, min: 12, max: 20)
                : AppResponsive.scaleSize(context, 12, min: 10, max: 16),
            vertical: isDesktop
                ? AppResponsive.scaleSize(context, 10, min: 8, max: 12)
                : AppResponsive.scaleSize(context, 8, min: 6, max: 10),
          ),
          decoration: BoxDecoration(
            color: finalBackgroundColor,
            borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: AppResponsive.scaleSize(context, 16, min: 14, max: 18),
                  color: AppColors.white,
                ),
                SizedBox(
                  width: AppResponsive.scaleSize(context, 6, min: 4, max: 8),
                ),
              ],
              Text(
                label,
                style: AppTextStyles.bodyText(context).copyWith(
                  color: labelColor,
                  fontSize: AppResponsive.fontSizeClamped(
                    context,
                    min: 12,
                    max: 14,
                  ),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
