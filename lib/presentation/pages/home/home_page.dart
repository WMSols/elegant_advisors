import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/layout/app_header.dart';
import '../../widgets/home/home_market_educated_section.dart';
import '../../widgets/home/home_top_section.dart';
import '../../controllers/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              children: [
                // Top Section with Background Image
                const HomeTopSection(),
                // Market Educated Section
                const HomeMarketEducatedSection(),
              ],
            ),
          ),
          // Header always visible, background animates on scroll
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Obx(
              () => AppHeader(
                showBackground: controller.showHeader.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
