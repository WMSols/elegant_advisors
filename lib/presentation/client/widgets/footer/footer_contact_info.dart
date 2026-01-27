import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/presentation/client/widgets/footer/footer_contact_item.dart';
import 'package:iconsax/iconsax.dart';

class FooterContactInfo extends StatelessWidget {
  const FooterContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.contactTitle,
          style: AppTextStyles.heading(context).copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: AppResponsive.fontSizeClamped(context, min: 16, max: 18),
          ),
        ),
        AppSpacing.vertical(context, 0.015),
        FooterContactItem(
          icon: Iconsax.location5,
          text: context.l10n.contactOfficeAddressValue,
        ),
        AppSpacing.vertical(context, 0.01),
        FooterContactItem(
          icon: Iconsax.call5,
          text: context.l10n.contactOfficePhoneValue,
        ),
        AppSpacing.vertical(context, 0.01),
        FooterContactItem(
          icon: Iconsax.sms5,
          text: context.l10n.contactOfficeEmailValue,
        ),
        AppSpacing.vertical(context, 0.01),
        FooterContactItem(
          icon: Iconsax.clock5,
          text: context.l10n.contactOfficeHoursValue,
        ),
      ],
    );
  }
}
