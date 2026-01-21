import 'package:flutter/material.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_listing_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/listing/properties_listing_content.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_properties_controller.dart';

/// Properties listing section with grid and pagination
class PropertiesListingSection extends StatelessWidget {
  final ClientPropertiesController controller;

  const PropertiesListingSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // PropertiesListingContent already handles reactivity with its own Obx
    return ClientListingSection(
      horizontalPadding: 0.1,
      verticalPadding: 0.06,
      child: PropertiesListingContent(controller: controller),
    );
  }
}
