import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/core/utils/app_texts/footer_texts.dart';
import 'package:elegant_advisors/presentation/client/widgets/contact/contact_info_item.dart';

/// Contact office details section
class ContactOfficeDetailsSection extends StatelessWidget {
  const ContactOfficeDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.contactOfficeTitle,
          style: AppTextStyles.heading(
            context,
          ).copyWith(color: AppColors.white),
        ),
        AppSpacing.vertical(context, 0.02),
        ContactInfoItem(
          icon: Iconsax.location,
          title: context.l10n.contactOfficeAddress,
          value: FooterTexts.contactAddress,
        ),
        AppSpacing.vertical(context, 0.02),
        ContactInfoItem(
          icon: Iconsax.call,
          title: context.l10n.contactOfficePhone,
          value: FooterTexts.contactPhone,
        ),
        AppSpacing.vertical(context, 0.02),
        ContactInfoItem(
          icon: Iconsax.sms,
          title: context.l10n.contactOfficeEmail,
          value: FooterTexts.contactEmail,
        ),
        AppSpacing.vertical(context, 0.02),
        ContactInfoItem(
          icon: Iconsax.clock,
          title: context.l10n.contactOfficeHours,
          value: FooterTexts.contactWorkingHours,
        ),
      ],
    );
  }
}
