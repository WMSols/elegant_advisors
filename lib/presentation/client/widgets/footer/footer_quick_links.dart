import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/footer_texts.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/presentation/client/widgets/footer/footer_link.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_properties_controller.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_property_detail_controller.dart';

class FooterQuickLinks extends StatelessWidget {
  const FooterQuickLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          FooterTexts.quickLinksTitle,
          style: AppTextStyles.heading(context).copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: AppResponsive.fontSizeClamped(context, min: 16, max: 18),
          ),
        ),
        AppSpacing.vertical(context, 0.015),
        FooterLink(
          text: FooterTexts.linkHome,
          onTap: () {
            if (FooterTexts.onHomeTap != null) {
              FooterTexts.onHomeTap!();
            } else {
              Get.toNamed(ClientConstants.routeClientHome);
            }
          },
        ),
        FooterLink(
          text: FooterTexts.linkProperties,
          onTap: () {
            if (FooterTexts.onPropertiesTap != null) {
              FooterTexts.onPropertiesTap!();
            } else {
              // Delete both controllers to ensure clean state
              if (Get.isRegistered<ClientPropertyDetailController>()) {
                Get.delete<ClientPropertyDetailController>(force: true);
              }
              if (Get.isRegistered<ClientPropertiesController>()) {
                Get.delete<ClientPropertiesController>(force: true);
              }
              // Use offNamed to replace current route, ensuring old route is fully removed
              // This prevents both widget trees from existing simultaneously
              Get.offNamed(ClientConstants.routeClientProperties);
            }
          },
        ),
        FooterLink(
          text: FooterTexts.linkOurTeam,
          onTap: () {
            if (FooterTexts.onOurTeamTap != null) {
              FooterTexts.onOurTeamTap!();
            } else {
              Get.toNamed(ClientConstants.routeClientOurTeam);
            }
          },
        ),
        FooterLink(
          text: FooterTexts.linkAboutUs,
          onTap: () {
            if (FooterTexts.onAboutUsTap != null) {
              FooterTexts.onAboutUsTap!();
            } else {
              Get.toNamed(ClientConstants.routeClientAboutUs);
            }
          },
        ),
        FooterLink(
          text: FooterTexts.linkContact,
          onTap: () {
            if (FooterTexts.onContactTap != null) {
              FooterTexts.onContactTap!();
            } else {
              Get.toNamed(ClientConstants.routeClientContact);
            }
          },
        ),
        AppSpacing.vertical(context, 0.01),
        Divider(color: AppColors.white.withValues(alpha: 0.2), thickness: 1),
        AppSpacing.vertical(context, 0.01),
        FooterLink(
          text: FooterTexts.linkPrivacyPolicy,
          onTap: () {
            if (FooterTexts.onPrivacyPolicyTap != null) {
              FooterTexts.onPrivacyPolicyTap!();
            } else {
              // TODO: Navigate to Privacy Policy page
              // Get.toNamed('/privacy-policy');
            }
          },
        ),
        FooterLink(
          text: FooterTexts.linkTermsOfService,
          onTap: () {
            if (FooterTexts.onTermsOfServiceTap != null) {
              FooterTexts.onTermsOfServiceTap!();
            } else {
              // TODO: Navigate to Terms of Service page
              // Get.toNamed('/terms-of-service');
            }
          },
        ),
      ],
    );
  }
}
