import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/admin/controllers/properties/admin_property_form_controller.dart';
import 'package:elegant_advisors/presentation/admin/widgets/layout/admin_layout.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/form_sections/admin_property_basic_info_section.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/form_sections/admin_property_location_section.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/form_sections/admin_property_price_section.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/form_sections/admin_property_specs_section.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/form_sections/admin_property_features_section.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/form_sections/admin_property_images_section.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/form_sections/admin_property_status_section.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_validation_errors_display.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';

class AdminPropertyFormScreen extends GetView<AdminPropertyFormController> {
  const AdminPropertyFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AdminLayout(
        title: controller.isEditMode.value
            ? AppTexts.adminPropertyFormEditTitle
            : AppTexts.adminPropertyFormCreateTitle,
        child: Padding(
          padding: AppSpacing.all(context, factor: 1.2),
          child: Obx(() {
            if (controller.isLoading.value && controller.isEditMode.value) {
              return const Center(
                child: AppLoadingIndicator(
                  variant: LoadingIndicatorVariant.white,
                ),
              );
            }

            return SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Basic Information Section
                    const AdminPropertyBasicInfoSection(),

                    // Location Section
                    const AdminPropertyLocationSection(),

                    // Price Section
                    const AdminPropertyPriceSection(),

                    // Specifications Section
                    const AdminPropertySpecsSection(),

                    // Features Section
                    const AdminPropertyFeaturesSection(),

                    // Images Section
                    const AdminPropertyImagesSection(),

                    // Status & Settings Section
                    const AdminPropertyStatusSection(),

                    AppSpacing.vertical(context, 0.02),
                    // Validation Errors Display
                    Obx(
                      () => AppValidationErrorsDisplay(
                        errors: controller.formValidationErrors.toList(),
                      ),
                    ),

                    AppSpacing.vertical(context, 0.02),
                    // Save Button
                    Obx(
                      () => AppButton(
                        text: controller.isEditMode.value
                            ? AppTexts.adminPropertyFormUpdateButton
                            : AppTexts.adminPropertyFormSaveButton,
                        isLoading: controller.isLoading.value,
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.saveProperty,
                        width: double.infinity,
                        backgroundColor: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
