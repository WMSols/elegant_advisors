import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/widgets/layout/app_header.dart';
import 'package:elegant_advisors/presentation/client/widgets/home/home_market_educated_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/home/home_our_discerning_clientele_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/home/home_unparalleled_expertise_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/home/home_privileging_quality_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/home/home_top_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/header/header_mobile_drawer.dart';
import 'package:elegant_advisors/presentation/client/controllers/home/client_home_controller.dart';

class ClientHomeScreen extends GetView<ClientHomeController> {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HeaderMobileDrawer(onClose: () => Navigator.of(context).pop()),
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            key: controller.scrollViewKey,
            controller: controller.scrollController,
            child: Column(
              children: [
                // Top Section with Background Image
                const HomeTopSection(),
                // Market Educated Section
                const HomeMarketEducatedSection(),
                // Our Discerning Clientele Section
                const HomeOurDiscerningClienteleSection(),
                // Privileging Quality Section
                const HomePrivilegingQualitySection(),
                // Unparalleled Expertise Section
                const HomeUnparalleledExpertiseSection(),
              ],
            ),
          ),
          // Header always visible, background animates on scroll
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Obx(
              () => AppHeader(showBackground: controller.showHeader.value),
            ),
          ),
        ],
      ),
    );
  }
}
