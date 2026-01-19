import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/footer_texts.dart';
import 'package:elegant_advisors/presentation/client/widgets/footer/footer_social_icon.dart';

class FooterSocialMedia extends StatelessWidget {
  const FooterSocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          FooterTexts.socialTitle,
          style: AppTextStyles.heading(context).copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: AppResponsive.fontSizeClamped(
              context,
              min: 16,
              max: 18,
            ),
          ),
        ),
        AppSpacing.vertical(context, 0.015),
        Row(
          children: [
            FooterSocialIcon(
              icon: FontAwesomeIcons.facebook,
              url: FooterTexts.socialFacebookUrl,
            ),
            AppSpacing.horizontal(context, 0.015),
            FooterSocialIcon(
              icon: FontAwesomeIcons.instagram,
              url: FooterTexts.socialInstagramUrl,
            ),
            AppSpacing.horizontal(context, 0.015),
            FooterSocialIcon(
              icon: FontAwesomeIcons.linkedin,
              url: FooterTexts.socialLinkedInUrl,
            ),
            AppSpacing.horizontal(context, 0.015),
            FooterSocialIcon(
              icon: FontAwesomeIcons.twitter,
              url: FooterTexts.socialTwitterUrl,
            ),
          ],
        ),
      ],
    );
  }
}
