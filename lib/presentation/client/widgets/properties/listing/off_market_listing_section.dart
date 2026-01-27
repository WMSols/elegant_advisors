import 'package:flutter/material.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_listing_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/listing/off_market_listing_content.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_off_market_controller.dart';

/// Off Market listing section with grid and pagination
class OffMarketListingSection extends StatelessWidget {
  final ClientOffMarketController controller;

  const OffMarketListingSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // OffMarketListingContent already handles reactivity with its own Obx
    return ClientListingSection(
      horizontalPadding: 0.1,
      verticalPadding: 0.06,
      child: OffMarketListingContent(controller: controller),
    );
  }
}
