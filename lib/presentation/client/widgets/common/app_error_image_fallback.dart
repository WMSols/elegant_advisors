import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors/app_colors.dart';
import '../../../../core/utils/app_responsive/app_responsive.dart';

class AppErrorImageFallback extends StatelessWidget {
  final double? iconSize;
  final Color? backgroundColor;
  final Color? iconColor;

  const AppErrorImageFallback({
    super.key,
    this.iconSize,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final defaultIconSize = iconSize ?? 
        AppResponsive.fontSizeClamped(context, min: 30, max: 80);
    final bgColor = backgroundColor ?? AppColors.grey.withValues(alpha:0.1);
    final iconColorValue = iconColor ?? AppColors.grey.withValues(alpha:0.5);

    return Container(
      decoration: BoxDecoration(color: bgColor),
      child: Center(
        child: Icon(
          Icons.image,
          size: defaultIconSize,
          color: iconColorValue,
        ),
      ),
    );
  }
}

