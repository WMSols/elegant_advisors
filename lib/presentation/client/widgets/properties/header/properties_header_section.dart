import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_hero_header_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_hero_header_content.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_properties_controller.dart';

/// Properties page header section
class PropertiesHeaderSection extends StatelessWidget {
  final ClientPropertiesController controller;

  const PropertiesHeaderSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ClientHeroHeaderSection(
      child: ClientHeroHeaderContent(
        title: context.l10n.propertiesTitle,
        description: context.l10n.propertiesDescription,
        textAlign: AppResponsive.isMobile(context)
            ? TextAlign.left
            : TextAlign.center,
        titleFontWeight: FontWeight.w300,
        letterSpacing: 2,
        titleFontSizeMin: AppResponsive.isMobile(context) ? 28 : 36,
        titleFontSizeMax: AppResponsive.isMobile(context) ? 36 : 48,
        actionButton: AppButton(
          text: context.l10n.clientPropertiesViewProperties,
          backgroundColor: AppColors.lightGrey,
          textColor: AppColors.black,
          width: AppResponsive.isMobile(context)
              ? AppResponsive.screenWidth(context) * 0.9
              : null,
          onPressed: () => controller.scrollToListing(),
        ),
      ),
    );
  }
}
