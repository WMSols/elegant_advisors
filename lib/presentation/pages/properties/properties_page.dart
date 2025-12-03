import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_spacing/app_spacing.dart';
import '../../../core/utils/app_styles/app_text_styles.dart';
import '../../../core/utils/app_texts/app_texts.dart';
import '../../widgets/layout/app_footer.dart';
import '../../widgets/layout/app_header.dart';
import '../../controllers/properties/properties_controller.dart';

class PropertiesPage extends GetView<PropertiesController> {
  const PropertiesPage({super.key});

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
                    AppTexts.propertiesTitle,
                    style: AppTextStyles.headline(context),
                  ),
                  AppSpacing.vertical(context, 0.04),
                  Text(
                    AppTexts.propertiesSubtitle,
                    style: AppTextStyles.heading(context),
                  ),
                  AppSpacing.vertical(context, 0.04),
                  // Add property types and investment properties here
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

