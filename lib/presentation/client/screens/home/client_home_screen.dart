import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_screen_layout.dart';
import 'package:elegant_advisors/presentation/client/widgets/home/home_market_educated_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/home/home_our_discerning_clientele_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/home/home_unparalleled_expertise_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/home/home_privileging_quality_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/home/header/home_header_section.dart';
import 'package:elegant_advisors/presentation/client/controllers/home/client_home_controller.dart';

class ClientHomeScreen extends GetView<ClientHomeController> {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ClientScreenLayout(
      scrollController: controller.scrollController,
      scrollViewKey: controller.scrollViewKey,
      showHeader: controller.showHeader,
      includeFooter: true,
      children: [
        // Header Section
        HomeHeaderSection(controller: controller),
        // Market Educated Section
        const HomeMarketEducatedSection(),
        // Our Discerning Clientele Section
        const HomeOurDiscerningClienteleSection(),
        // Privileging Quality Section
        const HomePrivilegingQualitySection(),
        // Unparalleled Expertise Section
        const HomeUnparalleledExpertiseSection(),
      ],
    );
  }
}
