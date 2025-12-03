import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_spacing/app_spacing.dart';
import '../../../core/utils/app_styles/app_text_styles.dart';
import '../../../core/utils/app_texts/app_texts.dart';
import '../../widgets/layout/app_footer.dart';
import '../../widgets/layout/app_header.dart';
import '../../controllers/how_we_do_it/how_we_do_it_controller.dart';

class HowWeDoItPage extends GetView<HowWeDoItController> {
  const HowWeDoItPage({super.key});

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
                    AppTexts.howWeDoItTitle,
                    style: AppTextStyles.headline(context),
                  ),
                  AppSpacing.vertical(context, 0.04),
                  Text(
                    AppTexts.howWeDoItSubtitle,
                    style: AppTextStyles.heading(context),
                  ),
                  AppSpacing.vertical(context, 0.04),
                  // Add step-by-step process here
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

