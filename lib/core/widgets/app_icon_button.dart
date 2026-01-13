import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';

/// Reusable icon button widget with consistent styling
class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color? color;
  final Color? backgroundColor;
  final double? iconSize;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.color,
    this.backgroundColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final finalIconSize =
        iconSize ?? AppResponsive.scaleSize(context, 24, min: 20, max: 28);

    return IconButton(
      icon: Icon(icon),
      iconSize: finalIconSize,
      onPressed: onPressed,
      tooltip: tooltip,
      color: color ?? AppColors.primary,
      style: IconButton.styleFrom(backgroundColor: backgroundColor),
    );
  }
}
