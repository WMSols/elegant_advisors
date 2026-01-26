import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_hero_header_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_hero_header_content.dart';
import 'package:elegant_advisors/presentation/client/controllers/our_team/client_our_team_controller.dart';

/// Our Team page header section
class OurTeamHeaderSection extends StatelessWidget {
  final ClientOurTeamController controller;

  const OurTeamHeaderSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ClientHeroHeaderSection(
      child: ClientHeroHeaderContent(
        title: context.l10n.ourTeamTitle,
        description: context.l10n.ourTeamDescription,
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
