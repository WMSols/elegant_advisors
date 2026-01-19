import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/presentation/admin/controllers/properties/admin_property_form_controller.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/form_sections/admin_property_form_section.dart';
import 'package:elegant_advisors/core/widgets/forms/app_text_field.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';

class AdminPropertyBasicInfoSection
    extends GetView<AdminPropertyFormController> {
  const AdminPropertyBasicInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminPropertyFormSection(
      title: AppTexts.adminPropertyFormBasicInfo,
      child: Column(
        children: [
          AppTextField(
            label: AppTexts.adminPropertyFormTitleLabel,
            hint: AppTexts.adminPropertyFormTitleHint,
            controller: controller.titleController,
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Iconsax.home),
            errorTextColor: AppColors.white,
            validator: controller.validateTitle,
            maxLines: 1,
          ),
          AppSpacing.vertical(context, 0.02),
          // Slug is auto-generated from title, not shown in form
          AppTextField(
            label: AppTexts.adminPropertyFormShortDescriptionLabel,
            hint: AppTexts.adminPropertyFormShortDescriptionHint,
            controller: controller.shortDescriptionController,
            textInputAction: TextInputAction.next,
            maxLines: null, // Expandable, starts as 1 line
            minLines: 1,
            prefixIcon: const Icon(Iconsax.document_text),
            errorTextColor: AppColors.white,
            validator: controller.validateShortDescription,
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.adminPropertyFormFullDescriptionLabel,
            hint: AppTexts.adminPropertyFormFullDescriptionHint,
            controller: controller.fullDescriptionController,
            textInputAction: TextInputAction.next,
            maxLines: null, // Expandable, starts as 1 line
            minLines: 1,
            prefixIcon: const Icon(Iconsax.document),
            errorTextColor: AppColors.white,
            validator: controller.validateFullDescription,
          ),
        ],
      ),
    );
  }
}
