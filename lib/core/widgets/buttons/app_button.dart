import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_gradient/app_gradient.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';

/// Primary Button Widget with Gradient Support
class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final bool isAdmin;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.isAdmin = false,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null;

    // Use responsive radius for admin, fixed radius for client
    final borderRadius = widget.isAdmin ? AppResponsive.radius(context) : 0.0;

    // Build decoration
    final baseDecoration = isDisabled
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: AppColors.grey.withValues(alpha: 0.5),
          )
        : widget.backgroundColor != null
        ? BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          )
        : BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ).withAppGradient();

    // Determine text color
    final finalTextColor =
        widget.textColor ??
        (widget.backgroundColor != null ? AppColors.primary : AppColors.white);

    Widget buttonContent = MouseRegion(
      onEnter: isDisabled ? null : (_) => setState(() => _isHovered = true),
      onExit: isDisabled ? null : (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered && !isDisabled ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.isLoading ? null : widget.onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              decoration: baseDecoration.copyWith(
                boxShadow: _isHovered && !isDisabled
                    ? [
                        BoxShadow(
                          color: (widget.backgroundColor ?? AppColors.primary)
                              .withValues(alpha: 0.3),
                          blurRadius: 15,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: AppResponsive.scaleSize(
                  context,
                  24,
                  min: 16,
                  max: 32,
                ),
                vertical: AppResponsive.screenHeight(context) * 0.015,
              ),
              child: Center(
                child: widget.isLoading
                    ? AppLoadingIndicator()
                    : Text(
                        widget.text,
                        style: AppTextStyles.buttonText(
                          context,
                        ).copyWith(color: finalTextColor),
                      ),
              ),
            ),
          ),
        ),
      ),
    );

    // If width is provided, wrap in SizedBox, otherwise use intrinsic width
    if (widget.width != null) {
      return SizedBox(
        width: widget.width,
        height: widget.height ?? AppResponsive.screenHeight(context) * 0.06,
        child: buttonContent,
      );
    } else {
      return IntrinsicWidth(
        child: SizedBox(
          height: widget.height ?? AppResponsive.screenHeight(context) * 0.06,
          child: buttonContent,
        ),
      );
    }
  }
}
