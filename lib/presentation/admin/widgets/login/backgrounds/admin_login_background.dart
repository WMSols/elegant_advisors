import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';

/// Background widget for admin login screen
class AdminLoginBackground extends StatelessWidget {
  const AdminLoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary, // Fallback color
        // image: const DecorationImage(
        //   image: AssetImage(AppImages.homeBackground),
        //   fit: BoxFit.cover,
        //   onError: null,
        // ),
      ),
    );
  }
}
