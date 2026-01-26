import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_hero_header_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_hero_header_content.dart';
import 'package:elegant_advisors/presentation/client/controllers/about_us/client_about_us_controller.dart';

/// About Us page header section
class AboutUsHeaderSection extends StatelessWidget {
  final ClientAboutUsController controller;

  const AboutUsHeaderSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ClientHeroHeaderSection(
      child: ClientHeroHeaderContent(
        title: context.l10n.aboutUsTitle,
        description: context.l10n.aboutUsDescription,
        textAlign: AppResponsive.isMobile(context)
            ? TextAlign.left
            : TextAlign.center,
        titleFontWeight: FontWeight.w300,
        letterSpacing: 2,
        titleFontSizeMin: AppResponsive.isMobile(context) ? 28 : 36,
        titleFontSizeMax: AppResponsive.isMobile(context) ? 36 : 48,
      ),
    );
  }
}
