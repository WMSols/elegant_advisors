import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_screen_layout.dart';
import 'package:elegant_advisors/presentation/client/widgets/home/home_our_approach_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/home/home_our_philosophy_mission_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/home/home_what_we_specialize_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/home/home_our_portfolio_section.dart';
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
        // Our Approach Section
        const HomeOurApproachSection(),
        // What We Specialize In Section
        const HomeWhatWeSpecializeSection(),
        // Our Philosophy & Mission Section
        const HomeOurPhilosophyMissionSection(),
        // Our Portfolio Section
        const HomeOurPortfolioSection(),
      ],
    );
  }
}
