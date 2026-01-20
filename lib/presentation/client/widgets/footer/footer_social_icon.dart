import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_texts/footer_texts.dart';

class FooterSocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const FooterSocialIcon({super.key, required this.icon, required this.url});

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
        child: FaIcon(
          icon,
          size: AppResponsive.scaleSize(context, 18, min: 16, max: 20),
          color: AppColors.white,
        ),
      ),
    );
  }
}
