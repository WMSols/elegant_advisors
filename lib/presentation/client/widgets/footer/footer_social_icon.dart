import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const FooterSocialIcon({super.key, required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
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
