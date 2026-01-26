import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_screen_layout.dart';
import 'package:elegant_advisors/presentation/client/controllers/our_team/client_our_team_controller.dart';
import 'package:elegant_advisors/presentation/client/widgets/our_team/header/our_team_header_section.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';

class ClientOurTeamScreen extends GetView<ClientOurTeamController> {
  const ClientOurTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ClientScreenLayout(
      scrollController: controller.scrollController,
      scrollViewKey: controller.scrollViewKey,
      showHeader: controller.showHeader,
      children: [
        // Header Section
        OurTeamHeaderSection(controller: controller),
        // Content Section
        Container(
          width: double.infinity,
          padding: AppSpacing.symmetric(context, h: 0.04, v: 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.ourTeamSubtitle,
                style: AppTextStyles.heading(context),
              ),
              AppSpacing.vertical(context, 0.04),
              // Add team members here
            ],
          ),
        ),
      ],
    );
  }
}
