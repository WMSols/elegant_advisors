import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/presentation/admin/controllers/admins/admin_create_edit_admin_controller.dart';
import 'package:elegant_advisors/presentation/admin/widgets/layout/admin_layout.dart';
import 'package:elegant_advisors/core/widgets/app_loading_indicator.dart';
import 'package:elegant_advisors/core/widgets/app_text_field.dart';
import 'package:elegant_advisors/core/widgets/app_button.dart';

class AdminCreateEditAdminScreen
    extends GetView<AdminCreateEditAdminController> {
  const AdminCreateEditAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AdminLayout(
        title: controller.isEditMode.value
            ? AppTexts.adminEditAdminTitle
            : AppTexts.adminCreateAdminTitle,
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
                    // Admin Name Field
                    AppTextField(
                      label: AppTexts.adminCreateAdminNameLabel,
                      hint: AppTexts.adminCreateAdminNameHint,
                      controller: controller.nameController,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Iconsax.user),
                      errorTextColor: AppColors.white,
                      validator: controller.validateName,
                    ),
                    AppSpacing.vertical(context, 0.02),
                    // Email Field
                    Obx(
                      () => AppTextField(
                        label: AppTexts.adminCreateAdminEmailLabel,
                        hint: AppTexts.adminCreateAdminEmailHint,
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        prefixIcon: const Icon(Iconsax.sms),
                        errorTextColor: AppColors.white,
                        validator: controller.isEditMode.value
                            ? null
                            : controller.validateEmail,
                        enabled: !controller.isEditMode.value,
                      ),
                    ),
                    AppSpacing.vertical(context, 0.02),
                    // Password Field
                    Obx(
                      () => AppTextField(
                        label: controller.isEditMode.value
                            ? AppTexts.adminEditAdminPasswordLabel
                            : AppTexts.adminCreateAdminPasswordLabel,
                        hint: AppTexts.adminCreateAdminPasswordHint,
                        controller: controller.passwordController,
                        obscureText: true,
                        showPasswordToggle: true,
                        textInputAction: TextInputAction.done,
                        prefixIcon: const Icon(Iconsax.lock),
                        errorTextColor: AppColors.white,
                        validator: controller.isEditMode.value
                            ? null
                            : controller.validatePassword,
                        enabled: !controller.isEditMode.value,
                        onFieldSubmitted: (_) {
                          if (!controller.isLoading.value) {
                            controller.saveAdmin();
                          }
                        },
                      ),
                    ),
                    AppSpacing.vertical(context, 0.04),
                    // Save Button
                    Obx(
                      () => AppButton(
                        text: controller.isEditMode.value
                            ? AppTexts.adminUpdateAdminButton
                            : AppTexts.adminCreateAdminButton,
                        isLoading: controller.isLoading.value,
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.saveAdmin,
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
