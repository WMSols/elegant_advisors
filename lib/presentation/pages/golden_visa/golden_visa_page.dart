import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_spacing/app_spacing.dart';
import '../../../core/utils/app_styles/app_text_styles.dart';
import '../../../core/utils/app_texts/app_texts.dart';
import '../../widgets/layout/app_footer.dart';
import '../../widgets/layout/app_header.dart';
import '../../controllers/golden_visa/golden_visa_controller.dart';

class GoldenVisaPage extends GetView<GoldenVisaController> {
  const GoldenVisaPage({super.key});

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
                    AppTexts.goldenVisaTitle,
                    style: AppTextStyles.headline(context),
                  ),
                  AppSpacing.vertical(context, 0.04),
                  Text(
                    AppTexts.goldenVisaSubtitle,
                    style: AppTextStyles.heading(context),
                  ),
                  AppSpacing.vertical(context, 0.02),
                  Text(
                    AppTexts.goldenVisaDescription,
                    style: AppTextStyles.bodyText(context),
                  ),
                  AppSpacing.vertical(context, 0.04),
                  // Add Golden Visa guide content here
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

