import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/widgets/layout/app_footer.dart';
import 'package:elegant_advisors/presentation/client/widgets/layout/app_header.dart';
import 'package:elegant_advisors/presentation/client/widgets/header/header_mobile_drawer.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_properties_controller.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/header/properties_header_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/filters/properties_filters_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/listing/properties_listing_section.dart';

class ClientPropertiesScreen extends GetView<ClientPropertiesController> {
  const ClientPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HeaderMobileDrawer(onClose: () => Navigator.of(context).pop()),
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              children: [
                // Header Section
                PropertiesHeaderSection(controller: controller),
                // Filters Section
                PropertiesFiltersSection(controller: controller),
                // Properties Listing Section
                PropertiesListingSection(
                  sectionKey: controller.listingSectionKey,
                  controller: controller,
                ),
                // Footer
                const AppFooter(),
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
