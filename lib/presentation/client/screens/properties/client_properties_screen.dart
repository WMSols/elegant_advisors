import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_screen_layout.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_properties_controller.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/header/properties_header_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/filters/properties_filters_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/listing/properties_listing_section.dart';

class ClientPropertiesScreen extends GetView<ClientPropertiesController> {
  const ClientPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listingKey = controller.listingSectionKey;

    return ClientScreenLayout(
      scrollController: controller.scrollController,
      scrollViewKey: controller.scrollViewKey,
      showHeader: controller.showHeader,
      children: [
        // Header Section
        PropertiesHeaderSection(controller: controller),
        // Filters Section
        PropertiesFiltersSection(controller: controller),
        // Properties Listing Section
        PropertiesListingSection(key: listingKey, controller: controller),
      ],
    );
  }
}
