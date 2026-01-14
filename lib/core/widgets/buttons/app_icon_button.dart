import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';

/// Reusable icon button widget with consistent styling and background color support
class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color? color;
  final Color? backgroundColor;
  final double? iconSize;
  final double? buttonSize;
  final EdgeInsetsGeometry? padding;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.color,
    this.backgroundColor,
    this.iconSize,
    this.buttonSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    // Responsive sizing for desktop and mobile
    final isDesktop = AppResponsive.isDesktop(context);
    final finalIconSize = iconSize ??
        (isDesktop
            ? AppResponsive.scaleSize(context, 24, min: 20, max: 28)
            : AppResponsive.scaleSize(context, 20, min: 18, max: 24));
    final finalButtonSize = buttonSize ??
        (isDesktop
            ? AppResponsive.scaleSize(context, 48, min: 40, max: 56)
            : AppResponsive.scaleSize(context, 40, min: 36, max: 48));
    final finalPadding = padding ??
        EdgeInsets.all(
          isDesktop
              ? AppResponsive.scaleSize(context, 12, min: 10, max: 14)
              : AppResponsive.scaleSize(context, 10, min: 8, max: 12),
        );

    final finalColor = color ?? AppColors.primary;
    final finalBackgroundColor = backgroundColor;

    Widget button = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
        child: Container(
          width: finalButtonSize,
          height: finalButtonSize,
          padding: finalPadding,
          decoration: BoxDecoration(
            color: finalBackgroundColor,
            borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
          ),
          child: Icon(
            icon,
            size: finalIconSize,
            color: onPressed == null
                ? finalColor.withValues(alpha: 0.5)
                : finalColor,
          ),
        ),
      ),
    );

    // Wrap with Tooltip if tooltip text is provided
    if (tooltip != null && tooltip!.isNotEmpty) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}
