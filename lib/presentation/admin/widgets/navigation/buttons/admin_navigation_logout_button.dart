import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';

/// Logout button widget for admin navigation panel
class AdminNavigationLogoutButton extends StatelessWidget {
  final VoidCallback onLogout;

  const AdminNavigationLogoutButton({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final iconSize = AppResponsive.scaleSize(context, 20, min: 18, max: 24);

    return InkWell(
      onTap: onLogout,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppTexts.adminNavLogout,
            style: AppTextStyles.bodyText(context).copyWith(
              color: AppColors.error,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.primaryFont,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.left,
          ),
          SizedBox(width: AppResponsive.scaleSize(context, 4, min: 2, max: 6)),
          Icon(Iconsax.logout_1, color: AppColors.error, size: iconSize),
        ],
      ),
    );
  }
}
