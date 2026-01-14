import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/presentation/admin/controllers/properties/admin_property_form_controller.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/form_sections/admin_property_form_section.dart';
import 'package:elegant_advisors/core/widgets/forms/app_text_field.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

class AdminPropertyFeaturesSection extends GetView<AdminPropertyFormController> {
  const AdminPropertyFeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminPropertyFormSection(
      title: AppTexts.adminPropertyFormFeatures,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: AppTexts.adminPropertyFormFeatureLabel,
                  hint: AppTexts.adminPropertyFormFeatureHint,
                  controller: controller.featureController,
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(Iconsax.star),
                  errorTextColor: AppColors.white,
                  onFieldSubmitted: (_) => controller.addFeature(),
                  maxLines: 1,
                ),
              ),
              AppSpacing.horizontal(context, 0.01),
              AppButton(
                text: AppTexts.adminPropertyFormAddFeature,
                onPressed: controller.addFeature,
                backgroundColor: AppColors.white,
              ),
            ],
          ),
          AppSpacing.vertical(context, 0.02),
          Obx(
            () => controller.features.isEmpty
                ? Text(
                    AppTexts.adminPropertyFormNoFeaturesAdded,
                    style: AppTextStyles.bodyText(context).copyWith(
                      color: AppColors.white.withValues(alpha: 0.7),
                    ),
                  )
                : Wrap(
                    spacing: AppResponsive.scaleSize(context, 8, min: 6, max: 12),
                    runSpacing: AppResponsive.scaleSize(context, 8, min: 6, max: 12),
                    children: controller.features.map((feature) {
                      return Chip(
                        label: Text(feature),
                        onDeleted: () => controller.removeFeature(feature),
                        deleteIcon: const Icon(Iconsax.close_circle, size: 18),
                        backgroundColor: AppColors.white,
                        labelStyle: AppTextStyles.bodyText(context).copyWith(
                          color: AppColors.primary,
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
