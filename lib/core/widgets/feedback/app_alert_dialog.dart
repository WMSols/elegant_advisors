import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/widgets/display/app_logo.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_action_button.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_images/app_images.dart';

/// Reusable alert dialog with AdminBackground, AppLogo, title, subtitle, and action buttons
class AppAlertDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String cancelText;
  final String? confirmText;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final bool isDestructive;

  const AppAlertDialog({
    super.key,
    required this.title,
    required this.subtitle,
    this.cancelText = 'Cancel',
    this.confirmText,
    this.onCancel,
    this.onConfirm,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = AppResponsive.isMobile(context);
    final screenWidth = AppResponsive.screenWidth(context);

    // Calculate dialog width based on screen size
    // Mobile: 90% of screen width with min padding
    // Desktop: Fixed max width (500px) so it doesn't take full screen
    final dialogWidth = isMobile
        ? screenWidth * 0.9
        : AppResponsive.scaleSize(context, 500, min: 400, max: 600);

    // Calculate horizontal padding for mobile
    final horizontalPadding = isMobile
        ? AppResponsive.scaleSize(context, 16, min: 12, max: 24)
        : AppResponsive.scaleSize(context, 24, min: 16, max: 32);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: AppResponsive.scaleSize(context, 24, min: 16, max: 32),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: dialogWidth,
          minWidth: isMobile ? 280 : 350,
        ),
        child: IntrinsicHeight(
          child: IntrinsicWidth(
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                // Background - fits content size
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      image: const DecorationImage(
                        image: AssetImage(AppImages.homeBackground),
                        fit: BoxFit.cover,
                        onError: null,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppResponsive.radius(context),
                      ),
                    ),
                  ),
                ),
                // Content
                Container(
                  padding: AppSpacing.all(context, factor: 1.5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo
                      AppLogo(color: AppColors.white),
                      AppSpacing.vertical(context, 0.04),
                      // Title
                      Text(
                        title,
                        style: AppTextStyles.heading(context).copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      AppSpacing.vertical(context, 0.02),
                      // Subtitle
                      Text(
                        subtitle,
                        style: AppTextStyles.bodyText(
                          context,
                        ).copyWith(color: AppColors.white),
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      AppSpacing.vertical(context, 0.04),
                      // Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Cancel Button
                          Flexible(
                            child: AppActionButton(
                              label: cancelText,
                              onPressed:
                                  onCancel ?? () => Get.back(result: false),
                              backgroundColor: AppColors.white,
                            ),
                          ),
                          if (confirmText != null) ...[
                            AppSpacing.horizontal(context, 0.02),
                            // Confirm Button
                            Flexible(
                              child: AppActionButton(
                                label: confirmText!,
                                onPressed:
                                    onConfirm ?? () => Get.back(result: true),
                                isDestructive: isDestructive,
                                icon: isDestructive
                                    ? Iconsax.trash
                                    : Iconsax.tick_circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Show the alert dialog and return the result
  static Future<bool?> show({
    required String title,
    required String subtitle,
    String cancelText = 'Cancel',
    String? confirmText,
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    bool isDestructive = false,
  }) {
    return Get.dialog<bool>(
      AppAlertDialog(
        title: title,
        subtitle: subtitle,
        cancelText: cancelText,
        confirmText: confirmText,
        onCancel: onCancel,
        onConfirm: onConfirm,
        isDestructive: isDestructive,
      ),
      barrierDismissible: false,
    );
  }
}
