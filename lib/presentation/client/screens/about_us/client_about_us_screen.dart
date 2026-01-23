import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_screen_layout.dart';
import 'package:elegant_advisors/presentation/client/controllers/about_us/client_about_us_controller.dart';
import 'package:elegant_advisors/presentation/client/widgets/about_us/header/about_us_header_section.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';

class ClientAboutUsScreen extends GetView<ClientAboutUsController> {
  const ClientAboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ClientScreenLayout(
      scrollController: controller.scrollController,
      scrollViewKey: controller.scrollViewKey,
      showHeader: controller.showHeader,
      children: [
        // Header Section
        AboutUsHeaderSection(controller: controller),
        // Content Section
        Container(
          width: double.infinity,
          padding: AppSpacing.symmetric(context, h: 0.04, v: 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTexts.aboutUsSubtitle,
                style: AppTextStyles.heading(context),
              ),
              AppSpacing.vertical(context, 0.04),
              // Add about us content here
            ],
          ),
        ),
      ],
    );
  }
}
