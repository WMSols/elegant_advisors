import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_screen_layout.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_off_market_controller.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/header/off_market_header_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/filters/off_market_filters_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/listing/off_market_listing_section.dart';

class ClientOffMarketScreen extends GetView<ClientOffMarketController> {
  const ClientOffMarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listingKey = controller.listingSectionKey;

    return ClientScreenLayout(
      scrollController: controller.scrollController,
      scrollViewKey: controller.scrollViewKey,
      showHeader: controller.showHeader,
      children: [
        // Header Section
        OffMarketHeaderSection(controller: controller),
        // Filters Section
        OffMarketFiltersSection(controller: controller),
        // Properties Listing Section
        OffMarketListingSection(key: listingKey, controller: controller),
      ],
    );
  }
}
