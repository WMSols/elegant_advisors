import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/presentation/client/widgets/layout/app_footer.dart';
import 'package:elegant_advisors/presentation/client/widgets/layout/app_header.dart';
import 'package:elegant_advisors/presentation/client/controllers/our_team/our_team_controller.dart';

class OurTeamScreen extends GetView<OurTeamController> {
  const OurTeamScreen({super.key});

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
                    AppTexts.ourTeamTitle,
                    style: AppTextStyles.headline(context),
                  ),
                  AppSpacing.vertical(context, 0.04),
                  Text(
                    AppTexts.ourTeamSubtitle,
                    style: AppTextStyles.heading(context),
                  ),
                  AppSpacing.vertical(context, 0.04),
                  Text(
                    AppTexts.ourTeamDescription,
                    style: AppTextStyles.bodyText(context),
                  ),
                  AppSpacing.vertical(context, 0.04),
                  // Add team members here
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
