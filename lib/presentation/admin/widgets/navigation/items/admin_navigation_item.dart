import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/constants/admin_constants.dart';

/// Navigation item widget for admin navigation panel
class AdminNavigationItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  final String currentRoute;
  final List<String>? relatedRoutes;
  final VoidCallback? onTap;

  const AdminNavigationItem({
    super.key,
    required this.icon,
    required this.label,
    required this.route,
    required this.currentRoute,
    this.relatedRoutes,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Check if current route matches the main route or any related routes
    bool isActive = currentRoute == route && route.isNotEmpty;

    if (!isActive && relatedRoutes != null) {
      // Check if current route matches any related route pattern
      for (final relatedRoute in relatedRoutes!) {
        // Remove parameter placeholders (e.g., ':id') for matching
        final routePattern = relatedRoute.split(':').first;
        // Check if current route starts with the route pattern
        if (currentRoute.startsWith(routePattern)) {
          isActive = true;
          break;
        }
      }
    }
    final iconSize = AppResponsive.scaleSize(context, 20, min: 18, max: 24);
    final spacing = AppResponsive.scaleSize(context, 12, min: 8, max: 16);
    final padding = AppResponsive.scaleSize(context, 12, min: 8, max: 16);
    final borderRadius = AppResponsive.scaleSize(context, 12, min: 8, max: 16);

    return InkWell(
      onTap:
          onTap ??
          (route.isNotEmpty
              ? () {
                  // Replace current admin route with new one to keep layout consistent
                  // Use smooth transition for navigation
                  Get.offNamedUntil(
                    route,
                    (route) =>
                        route.settings.name == AdminConstants.routeAdminLogin ||
                        route.settings.name == null,
                    arguments: Get.arguments,
                    // Transition is handled by route configuration
                  );
                }
              : null),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: AppResponsive.scaleSize(context, 4, min: 2, max: 6),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: padding * 0.75,
        ),
        decoration: BoxDecoration(
          // Active items show background image, inactive are transparent
          // image: isActive
          //     ? const DecorationImage(
          //         image: AssetImage(AppImages.homeBackground),
          //         fit: BoxFit.cover,
          //       )
          //     : null,
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: isActive
              ? BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  bottomLeft: Radius.circular(borderRadius),
                )
              : BorderRadius.zero,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.white : AppColors.primary,
              size: iconSize,
            ),
            SizedBox(width: spacing),
            Flexible(
              child: Text(
                label,
                style: AppTextStyles.bodyText(context).copyWith(
                  color: isActive ? AppColors.white : AppColors.primary,
                  fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                  fontFamily: AppFonts.primaryFont,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
