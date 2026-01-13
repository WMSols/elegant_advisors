import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

/// Reusable action button for dialogs (cancel, delete, etc.)
class AppActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isDestructive; // For delete/destructive actions
  final Color? backgroundColor;
  final Color? textColor;

  const AppActionButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isDestructive = false,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final finalBackgroundColor = backgroundColor ??
        (isDestructive ? AppColors.error : AppColors.white);
    final finalTextColor = textColor ??
        (isDestructive ? AppColors.white : AppColors.primary);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppResponsive.scaleSize(context, 24, min: 16, max: 32),
            vertical: AppResponsive.screenHeight(context) * 0.015,
          ),
          decoration: BoxDecoration(
            color: finalBackgroundColor,
            borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
            border: isDestructive
                ? null
                : Border.all(
                    color: AppColors.primary,
                    width: 1,
                  ),
          ),
          child: Center(
            child: Text(
              text,
              style: AppTextStyles.buttonText(context).copyWith(
                color: finalTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
