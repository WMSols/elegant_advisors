import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

/// Reusable validation errors display widget
/// Shows a list of validation errors in a styled container
class AppValidationErrorsDisplay extends StatelessWidget {
  /// List of error messages to display
  final List<String> errors;

  /// Optional header text (default: "Please fix the following errors:")
  final String? headerText;

  /// Optional custom header widget
  final Widget? header;

  /// Whether to show the widget when errors list is empty
  final bool showWhenEmpty;

  const AppValidationErrorsDisplay({
    super.key,
    required this.errors,
    this.headerText,
    this.header,
    this.showWhenEmpty = false,
  });

  @override
  Widget build(BuildContext context) {
    // Don't show if errors list is empty and showWhenEmpty is false
    if (errors.isEmpty && !showWhenEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: AppSpacing.all(context, factor: 0.5),
      margin: EdgeInsets.only(
        bottom: AppResponsive.scaleSize(context, 16, min: 12, max: 20),
      ),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
        border: Border.all(color: AppColors.error, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          if (header != null)
            header!
          else
            Row(
              children: [
                Icon(
                  Iconsax.warning_2,
                  color: AppColors.error,
                  size: AppResponsive.scaleSize(context, 20, min: 18, max: 22),
                ),
                AppSpacing.horizontal(context, 0.01),
                Expanded(
                  child: Text(
                    headerText ?? 'Please fix the following errors:',
                    style: AppTextStyles.heading(context).copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          if (errors.isNotEmpty) ...[
            AppSpacing.vertical(context, 0.01),
            // Error List
            ...errors.map(
              (error) => Padding(
                padding: EdgeInsets.only(
                  bottom: AppResponsive.scaleSize(context, 4, min: 2, max: 6),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• ',
                      style: AppTextStyles.bodyText(context).copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        error,
                        style: AppTextStyles.bodyText(
                          context,
                        ).copyWith(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
