import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/presentation/client/widgets/footer/footer_link.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_properties_controller.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_property_detail_controller.dart';
import 'package:elegant_advisors/presentation/client/controllers/contact/client_contact_controller.dart';
import 'package:elegant_advisors/presentation/client/controllers/contact/my_contacts/client_my_contacts_controller.dart';
import 'package:elegant_advisors/presentation/client/controllers/home/client_home_controller.dart';
import 'package:elegant_advisors/presentation/client/controllers/our_team/client_our_team_controller.dart';
import 'package:elegant_advisors/presentation/client/controllers/about_us/client_about_us_controller.dart';

class FooterQuickLinks extends StatelessWidget {
  const FooterQuickLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.footerQuickLinksTitle,
          style: AppTextStyles.heading(context).copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: AppResponsive.fontSizeClamped(context, min: 16, max: 18),
          ),
        ),
        AppSpacing.vertical(context, 0.015),
        FooterLink(
          text: context.l10n.navHome,
          onTap: () {
            // Delete home controller to ensure clean state
            if (Get.isRegistered<ClientHomeController>()) {
              Get.delete<ClientHomeController>(force: true);
            }
            Get.offNamed(ClientConstants.routeClientHome);
          },
        ),
        FooterLink(
          text: context.l10n.navProperties,
          onTap: () {
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
          },
        ),
        FooterLink(
          text: context.l10n.navOurTeam,
          onTap: () {
            // Delete our team controller to ensure clean state
            if (Get.isRegistered<ClientOurTeamController>()) {
              Get.delete<ClientOurTeamController>(force: true);
            }
            Get.offNamed(ClientConstants.routeClientOurTeam);
          },
        ),
        FooterLink(
          text: context.l10n.navAboutUs,
          onTap: () {
            // Delete about us controller to ensure clean state
            if (Get.isRegistered<ClientAboutUsController>()) {
              Get.delete<ClientAboutUsController>(force: true);
            }
            Get.offNamed(ClientConstants.routeClientAboutUs);
          },
        ),
        FooterLink(
          text: context.l10n.navContact,
          onTap: () {
            // Delete both contact controllers to ensure clean state and prevent GlobalKey conflicts
            if (Get.isRegistered<ClientMyContactsController>()) {
              Get.delete<ClientMyContactsController>(force: true);
            }
            if (Get.isRegistered<ClientContactController>()) {
              Get.delete<ClientContactController>(force: true);
            }
            // Use offNamed to replace current route, ensuring old route is fully removed
            Get.offNamed(ClientConstants.routeClientContact);
          },
        ),
        FooterLink(
          text: context.l10n.footerLinkMyContacts,
          onTap: () {
            Get.toNamed(ClientConstants.routeClientContacts);
          },
        ),
        AppSpacing.vertical(context, 0.01),
        Divider(color: AppColors.white.withValues(alpha: 0.2), thickness: 1),
        AppSpacing.vertical(context, 0.01),
        FooterLink(
          text: context.l10n.footerLinkPrivacyPolicy,
          onTap: () {
            // TODO: Navigate to Privacy Policy page
            // Get.toNamed('/privacy-policy');
          },
        ),
        FooterLink(
          text: context.l10n.footerLinkTermsOfService,
          onTap: () {
            // TODO: Navigate to Terms of Service page
            // Get.toNamed('/terms-of-service');
          },
        ),
      ],
    );
  }
}
