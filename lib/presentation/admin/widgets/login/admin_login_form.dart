import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_validators/app_validators.dart';
import 'package:elegant_advisors/presentation/admin/controllers/login/admin_login_controller.dart';
import 'package:elegant_advisors/core/widgets/app_dotted_border_container.dart';
import 'package:elegant_advisors/core/widgets/app_text_field.dart';
import 'package:elegant_advisors/core/widgets/app_button.dart';
import 'package:elegant_advisors/core/widgets/app_logo.dart';

/// Admin login form widget with logo, fields, and button
class AdminLoginForm extends GetView<AdminLoginController> {
  const AdminLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppResponsive.isMobile(context);

    return AppDottedBorderContainer(
      borderColor: AppColors.primary,
      borderRadius: AppResponsive.radius(context),
      child: Container(
        padding: AppSpacing.symmetric(
          context,
          h: isMobile ? 0.06 : 0.02,
          v: isMobile ? 0.05 : 0.04,
        ),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: const AppLogo()),
              AppSpacing.vertical(context, 0.04),
              Center(
                child: Text(
                  AppTexts.adminLoginTitle,
                  style: AppTextStyles.heading(context).copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              AppSpacing.vertical(context, 0.02),
              AppTextField(
                hint: AppTexts.adminLoginEmailHint,
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Iconsax.sms),
                validator: (value) {
                  return AppValidators.validateEmail(value);
                },
              ),
              AppSpacing.vertical(context, 0.02),
              AppTextField(
                hint: AppTexts.adminLoginPasswordHint,
                controller: controller.passwordController,
                obscureText: true,
                showPasswordToggle: true,
                textInputAction: TextInputAction.done,
                prefixIcon: const Icon(Iconsax.lock),
                validator: (value) {
                  return AppValidators.validateAdminPassword(value);
                },
                onFieldSubmitted: (_) {
                  // Trigger login when Enter is pressed on password field
                  if (!controller.isLoading.value) {
                    controller.login();
                  }
                },
              ),
              AppSpacing.vertical(context, 0.04),
              Obx(
                () => AppButton(
                  text: AppTexts.adminLoginButton,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.login,
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.white,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
