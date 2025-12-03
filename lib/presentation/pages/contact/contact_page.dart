import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_responsive/app_responsive.dart';
import '../../../core/utils/app_spacing/app_spacing.dart';
import '../../../core/utils/app_styles/app_text_styles.dart';
import '../../../core/utils/app_texts/app_texts.dart';
import '../../../core/utils/validators.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';
import '../../widgets/layout/app_footer.dart';
import '../../widgets/layout/app_header.dart';
import '../../controllers/contact/contact_controller.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

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
                    AppTexts.contactTitle,
                    style: AppTextStyles.headline(context),
                  ),
                  AppSpacing.vertical(context, 0.04),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth >= 768) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: _buildContactForm(context),
                            ),
                            AppSpacing.horizontal(context, 0.04),
                            Expanded(
                              flex: 1,
                              child: _buildOfficeDetails(context),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            _buildContactForm(context),
                            AppSpacing.vertical(context, 0.04),
                            _buildOfficeDetails(context),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.contactFormTitle,
            style: AppTextStyles.heading(context),
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.contactFormName,
            controller: controller.nameController,
            validator: Validators.validateName,
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.contactFormEmail,
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: Validators.validateEmail,
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.contactFormPhone,
            controller: controller.phoneController,
            keyboardType: TextInputType.phone,
            validator: (value) => Validators.validateRequired(value, AppTexts.contactFormPhone),
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.contactFormMessage,
            controller: controller.messageController,
            maxLines: 5,
            validator: Validators.validateMessage,
          ),
          AppSpacing.vertical(context, 0.03),
          Obx(
            () => AppButton(
              text: AppTexts.contactFormButton,
              isLoading: controller.isLoading.value,
              onPressed: controller.submitForm,
              width: AppResponsive.screenWidth(context) * 0.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfficeDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTexts.contactOfficeTitle,
          style: AppTextStyles.heading(context),
        ),
        AppSpacing.vertical(context, 0.02),
        _buildInfoItem(
          context,
          icon: Icons.location_on,
          title: AppTexts.contactOfficeAddress,
          value: AppTexts.contactOfficeAddressValue,
        ),
        AppSpacing.vertical(context, 0.02),
        _buildInfoItem(
          context,
          icon: Icons.phone,
          title: AppTexts.contactOfficePhone,
          value: AppTexts.contactOfficePhoneValue,
        ),
        AppSpacing.vertical(context, 0.02),
        _buildInfoItem(
          context,
          icon: Icons.email,
          title: AppTexts.contactOfficeEmail,
          value: AppTexts.contactOfficeEmailValue,
        ),
        AppSpacing.vertical(context, 0.02),
        _buildInfoItem(
          context,
          icon: Icons.access_time,
          title: AppTexts.contactOfficeHours,
          value: AppTexts.contactOfficeHoursValue,
        ),
      ],
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary),
        AppSpacing.horizontal(context, 0.02),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyText(context).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: AppTextStyles.bodyText(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

