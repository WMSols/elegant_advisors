import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_hero_header_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_hero_header_content.dart';
import 'package:elegant_advisors/presentation/client/controllers/home/client_home_controller.dart';

/// Home page header section
class HomeHeaderSection extends StatelessWidget {
  final ClientHomeController controller;

  const HomeHeaderSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ClientHeroHeaderSection(
      child: ClientHeroHeaderContent(
        title: AppTexts.homeTitle,
        description: AppTexts.homeSubtitle,
        textAlign: AppResponsive.isMobile(context)
            ? TextAlign.left
            : TextAlign.center,
        titleFontWeight: FontWeight.w300,
        letterSpacing: 2,
        titleFontSizeMin: AppResponsive.isMobile(context) ? 28 : 36,
        titleFontSizeMax: AppResponsive.isMobile(context) ? 36 : 48,
        actionButton: AppButton(
          text: AppTexts.homeButtonConsultation,
          backgroundColor: AppColors.lightGrey,
          textColor: AppColors.black,
          width: AppResponsive.isMobile(context)
              ? AppResponsive.screenWidth(context) * 0.9
              : null,
          onPressed: () => Get.toNamed(ClientConstants.routeClientContact),
        ),
      ),
    );
  }
}
