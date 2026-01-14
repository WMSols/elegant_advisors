import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

/// Header widget for admin screens
class AdminHeader extends StatelessWidget {
  final String title;

  const AdminHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.headline(
        context,
      ).copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
    );
  }
}
