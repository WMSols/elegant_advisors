import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/presentation/client/widgets/layout/app_footer.dart';
import 'package:elegant_advisors/presentation/client/widgets/layout/app_header.dart';
import 'package:elegant_advisors/presentation/client/controllers/about_us/about_us_controller.dart';

class AboutUsScreen extends GetView<AboutUsController> {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeader(),
            Container(
              width: double.infinity,
              padding: AppSpacing.symmetric(context, h: 0.04, v: 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTexts.aboutUsTitle,
                    style: AppTextStyles.headline(context),
                  ),
                  AppSpacing.vertical(context, 0.04),
                  Text(
                    AppTexts.aboutUsSubtitle,
                    style: AppTextStyles.heading(context),
                  ),
                  AppSpacing.vertical(context, 0.04),
                  Text(
                    AppTexts.aboutUsDescription,
                    style: AppTextStyles.bodyText(context),
                  ),
                  AppSpacing.vertical(context, 0.04),
                  // Add about us content here
                ],
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
