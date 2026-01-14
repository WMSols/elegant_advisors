import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';

/// Reusable empty state widget for admin management
class AdminEmptyState extends StatelessWidget {
  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const AdminEmptyState({
    super.key,
    required this.message,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: AppTextStyles.bodyText(
              context,
            ).copyWith(color: AppColors.white),
          ),
          AppSpacing.vertical(context, 0.02),
          AppButton(
            text: buttonText,
            onPressed: onButtonPressed,
            backgroundColor: AppColors.white,
          ),
        ],
      ),
    );
  }
}
