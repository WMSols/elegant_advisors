import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_texts/footer_texts.dart';

class FooterSocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const FooterSocialIcon({
    super.key,
    required this.icon,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (FooterTexts.onSocialMediaTap != null) {
            FooterTexts.onSocialMediaTap!(url);
          } else {
            // TODO: Launch URL using url_launcher
            // launchUrl(Uri.parse(url));
          }
        },
        child: Container(
          padding: EdgeInsets.all(
            AppResponsive.scaleSize(context, 10, min: 8, max: 12),
          ),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(
              AppResponsive.radius(context, factor: 0.5),
            ),
            border: Border.all(
              color: AppColors.white.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: FaIcon(
            icon,
            size: AppResponsive.scaleSize(context, 18, min: 16, max: 20),
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
