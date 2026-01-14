import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_images/app_images.dart';

/// Background widget for all admin screens
class AdminBackground extends StatelessWidget {
  const AdminBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary, // Fallback color
        image: const DecorationImage(
          image: AssetImage(AppImages.homeBackground),
          fit: BoxFit.cover,
          onError: null,
        ),
      ),
    );
  }
}
