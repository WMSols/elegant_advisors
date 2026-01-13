import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

class AppTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool showPasswordToggle;
  final TextInputType? keyboardType;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool enabled;
  final Color? errorTextColor;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.showPasswordToggle = false,
    this.keyboardType,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
    this.enabled = true,
    this.errorTextColor = AppColors.primary,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  // Track key value to force widget recreation when controller changes
  int _keyValue = 0;
  bool _isPasswordVisible = false;

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If controller reference changed, update key to force widget recreation
    // This prevents trying to use a disposed controller during transitions
    if (oldWidget.controller != widget.controller) {
      _keyValue++; // Increment to force new widget instance
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use a key that changes when controller changes to force complete widget recreation
    // This prevents Flutter from trying to update a widget with a disposed controller
    final controllerKey = ValueKey<int>(_keyValue);

    // Determine if we should show password toggle
    final shouldShowPasswordToggle =
        widget.showPasswordToggle && widget.obscureText;

    // Build suffix icon - prioritize custom suffixIcon, then password toggle, then none
    Widget? suffixIconWidget = widget.suffixIcon;
    if (shouldShowPasswordToggle && suffixIconWidget == null) {
      suffixIconWidget = IconButton(
        icon: Icon(
          _isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
          color: AppColors.primary,
        ),
        onPressed: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTextStyles.bodyText(context).copyWith(
              color: AppColors.white,
              fontFamily: AppFonts.primaryFont,
            ),
          ),
          AppSpacing.vertical(context, 0.01),
        ],
        TextFormField(
          key: controllerKey,
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.obscureText && !_isPasswordVisible,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          focusNode: widget.focusNode,
          enabled: widget.enabled,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: AppTextStyles.bodyText(context).copyWith(
            color: widget.enabled ? AppColors.primary : AppColors.grey,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.hintText(context),
            prefixIcon: widget.prefixIcon,
            prefixIconColor: AppColors.primary,
            suffixIcon: suffixIconWidget,
            suffixIconColor: AppColors.primary,
            errorStyle: AppTextStyles.errorText(
              context,
            ).copyWith(color: widget.errorTextColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppResponsive.radius(context),
              ),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppResponsive.radius(context),
              ),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppResponsive.radius(context),
              ),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppResponsive.radius(context),
              ),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            filled: true,
            fillColor: AppColors.white,
          ),
        ),
      ],
    );
  }
}
