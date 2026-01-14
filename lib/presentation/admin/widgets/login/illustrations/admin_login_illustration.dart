import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_images/app_images.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/widgets/images/app_error_image_fallback.dart';

/// Admin login illustration widget
class AdminLoginIllustration extends StatelessWidget {
  const AdminLoginIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: AppResponsive.screenHeight(context) * 0.6,
        maxWidth: AppResponsive.screenWidth(context) * 0.4,
      ),
      child: Image.asset(
        AppImages.adminLogin,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return AppErrorImageFallback(
            iconSize: AppResponsive.iconSize(context),
          );
        },
      ),
    );
  }
}
