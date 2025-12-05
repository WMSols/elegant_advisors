import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_images/app_images.dart';
import '../../../core/utils/app_responsive/app_responsive.dart';
import '../../../core/utils/app_styles/app_text_styles.dart';
import '../../../core/utils/app_texts/app_texts.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppConstants.routeHome),
      child: Image.asset(
        AppImages.webLogo,
        height: AppResponsive.scaleSize(context, 30, min: 24, max: 40),
        width: AppResponsive.scaleSize(context, 30, min: 24, max: 40),
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Text(
            AppTexts.webName,
            style: AppTextStyles.bodyText(context).copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w300,
              letterSpacing: 2,
            ),
          );
        },
      ),
    );
  }
}

