import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_hero_header_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_hero_header_content.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_off_market_controller.dart';

/// Off Market page header section
class OffMarketHeaderSection extends StatelessWidget {
  final ClientOffMarketController controller;

  const OffMarketHeaderSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ClientHeroHeaderSection(
      child: ClientHeroHeaderContent(
        title: context.l10n.offMarketTitle,
        description: context.l10n.offMarketDescription,
        textAlign: AppResponsive.isMobile(context)
            ? TextAlign.left
            : TextAlign.center,
        titleFontWeight: FontWeight.w300,
        letterSpacing: 2,
        titleFontSizeMin: AppResponsive.isMobile(context) ? 28 : 36,
        titleFontSizeMax: AppResponsive.isMobile(context) ? 36 : 48,
        actionButton: AppButton(
          text: context.l10n.offMarketViewProperties,
          backgroundColor: AppColors.lightGrey,
          textColor: AppColors.black,
          width: AppResponsive.isMobile(context)
              ? AppResponsive.screenWidth(context) * 0.9
              : null,
          onPressed: () => controller.scrollToForm(),
        ),
      ),
    );
  }
}
