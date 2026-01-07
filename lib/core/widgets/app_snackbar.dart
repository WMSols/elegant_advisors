import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:iconsax/iconsax.dart';

/// Reusable snackbar widget matching the design specification
///
/// Supports four types:
/// - success: Green accent with checkmark icon
/// - error: Red accent with X icon
/// - info: Blue accent with 'i' icon
/// - warning: Yellow/orange accent with exclamation icon
class AppSnackbar {
  AppSnackbar._();

  /// Show success snackbar
  static void showSuccess(String message, {String title = 'Success'}) {
    _show(title: title, message: message, type: SnackbarType.success);
  }

  /// Show error snackbar
  static void showError(String message, {String title = 'Error'}) {
    _show(title: title, message: message, type: SnackbarType.error);
  }

  /// Show info snackbar
  static void showInfo(String message, {String title = 'Info'}) {
    _show(title: title, message: message, type: SnackbarType.info);
  }

  /// Show warning snackbar
  static void showWarning(String message, {String title = 'Warning'}) {
    _show(title: title, message: message, type: SnackbarType.warning);
  }

  static void _show({
    required String title,
    required String message,
    required SnackbarType type,
  }) {
    final context = Get.context;
    if (context == null) return;

    final isDesktop = AppResponsive.isDesktop(context);
    final maxWidth = isDesktop ? 500.0 : double.infinity;
    final horizontalMargin = isDesktop
        ? AppResponsive.scaleSize(context, 24, min: 16, max: 32)
        : AppResponsive.scaleSize(context, 16, min: 12, max: 24);

    Get.snackbar(
      '',
      '',
      titleText: const SizedBox.shrink(),
      messageText: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: _SnackbarContent(title: title, message: message, type: type),
        ),
      ),
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(
        left: horizontalMargin,
        right: horizontalMargin,
        bottom: AppResponsive.scaleSize(context, 16, min: 12, max: 24),
      ),
      borderRadius: AppResponsive.radius(context),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      barBlur: 0,
      overlayBlur: 0,
      shouldIconPulse: false,
      maxWidth: double.infinity,
    );
  }
}

/// Snackbar content widget
class _SnackbarContent extends StatelessWidget {
  final String title;
  final String message;
  final SnackbarType type;

  const _SnackbarContent({
    required this.title,
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();
    final radius = AppResponsive.radius(context);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left accent bar - outside the rounded container
          Container(
            width: 10,
            decoration: BoxDecoration(
              color: colors.accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                bottomLeft: Radius.circular(radius),
              ),
            ),
          ),
          // Main content container with rounded right corners
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(radius),
                  bottomRight: Radius.circular(radius),
                ),
              ),
              child: Row(
                children: [
                  // Icon
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppResponsive.scaleSize(
                        context,
                        12,
                        min: 10,
                        max: 14,
                      ),
                      vertical: AppResponsive.scaleSize(
                        context,
                        12,
                        min: 10,
                        max: 14,
                      ),
                    ),
                    child: Icon(
                      colors.icon,
                      color: colors.accentColor,
                      size: AppResponsive.scaleSize(
                        context,
                        32,
                        min: 28,
                        max: 36,
                      ),
                    ),
                  ),
                  // Content
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppResponsive.scaleSize(
                          context,
                          12,
                          min: 10,
                          max: 14,
                        ),
                        horizontal: AppResponsive.scaleSize(
                          context,
                          8,
                          min: 6,
                          max: 10,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title.toUpperCase(),
                            style: AppTextStyles.bodyText(context).copyWith(
                              fontSize: AppResponsive.fontSizeClamped(
                                context,
                                min: 12,
                                max: 14,
                              ),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: AppColors.black.withOpacity(0.85),
                            ),
                          ),
                          Text(
                            message,
                            style: AppTextStyles.bodyText(context).copyWith(
                              fontSize: AppResponsive.fontSizeClamped(
                                context,
                                min: 11,
                                max: 13,
                              ),
                              fontWeight: FontWeight.w500,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Close button
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppResponsive.scaleSize(
                        context,
                        10,
                        min: 8,
                        max: 12,
                      ),
                      vertical: AppResponsive.scaleSize(
                        context,
                        12,
                        min: 10,
                        max: 14,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Iconsax.close_circle,
                        size: AppResponsive.scaleSize(
                          context,
                          18,
                          min: 16,
                          max: 20,
                        ),
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _SnackbarColors _getColors() {
    switch (type) {
      case SnackbarType.success:
        return _SnackbarColors(
          accentColor: AppColors.success,
          icon: Iconsax.tick_circle5,
        );
      case SnackbarType.error:
        return _SnackbarColors(
          accentColor: AppColors.error,
          icon: Iconsax.close_circle5,
        );
      case SnackbarType.info:
        return _SnackbarColors(
          accentColor: AppColors.information,
          icon: Iconsax.info_circle5,
        );
      case SnackbarType.warning:
        return _SnackbarColors(
          accentColor: Colors.orange,
          icon: Iconsax.warning_25,
        );
    }
  }
}

/// Snackbar type enum
enum SnackbarType { success, error, info, warning }

/// Snackbar colors helper
class _SnackbarColors {
  final Color accentColor;
  final IconData icon;

  _SnackbarColors({required this.accentColor, required this.icon});
}
