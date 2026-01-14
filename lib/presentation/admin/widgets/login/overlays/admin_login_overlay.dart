import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/presentation/admin/widgets/login/forms/admin_login_form.dart';
import 'package:elegant_advisors/presentation/admin/widgets/login/illustrations/admin_login_illustration.dart';

/// White overlay container for admin login content
class AdminLoginOverlay extends StatelessWidget {
  const AdminLoginOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = AppResponsive.isMobile(context);
          final screenWidth = AppResponsive.screenWidth(context);
          final screenHeight = AppResponsive.screenHeight(context);

          return Container(
            width: isMobile ? screenWidth * 0.9 : screenWidth * 0.6,
            height: isMobile ? screenHeight * 0.85 : screenHeight * 0.75,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(
                AppResponsive.radius(context, factor: 1.5),
              ),
            ),
            child: isMobile
                ? const AdminLoginMobileLayout()
                : const AdminLoginDesktopLayout(),
          );
        },
      ),
    );
  }
}

/// Mobile layout for admin login
class AdminLoginMobileLayout extends StatelessWidget {
  const AdminLoginMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.symmetric(context, h: 0.06, v: 0.04),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AdminLoginIllustration(),
          AppSpacing.vertical(context, 0.04),
          AdminLoginForm(),
        ],
      ),
    );
  }
}

/// Desktop layout for admin login
class AdminLoginDesktopLayout extends StatelessWidget {
  const AdminLoginDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.03),
      child: Row(
        children: [
          Expanded(flex: 1, child: Center(child: AdminLoginForm())),
          AppSpacing.horizontal(context, 0.04),
          Expanded(
            flex: 1,
            child: Center(child: const AdminLoginIllustration()),
          ),
        ],
      ),
    );
  }
}
