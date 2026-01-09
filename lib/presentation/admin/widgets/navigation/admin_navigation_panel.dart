import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/presentation/admin/widgets/navigation/admin_navigation_content.dart';

/// Navigation panel for admin screens
class AdminNavigationPanel extends StatelessWidget {
  final String currentRoute;
  final String adminName;
  final VoidCallback onLogout;

  const AdminNavigationPanel({
    super.key,
    required this.currentRoute,
    required this.adminName,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = AppResponsive.isMobile(context);

    if (isMobile) {
      // Mobile: Drawer
      return Drawer(
        backgroundColor: AppColors.white,
        child: AdminNavigationContent(
          currentRoute: currentRoute,
          adminName: adminName,
          onLogout: onLogout,
        ),
      );
    }

    // Desktop: Sidebar
    final sidebarWidth = AppResponsive.scaleSize(
      context,
      280,
      min: 240,
      max: 320,
    );
    final borderRadius = AppResponsive.scaleSize(context, 16, min: 12, max: 20);

    return Container(
      width: sidebarWidth,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight),
            child: AdminNavigationContent(
              currentRoute: currentRoute,
              adminName: adminName,
              onLogout: onLogout,
            ),
          );
        },
      ),
    );
  }
}
