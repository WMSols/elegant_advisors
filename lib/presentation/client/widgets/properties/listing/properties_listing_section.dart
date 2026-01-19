import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/listing/properties_listing_content.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_properties_controller.dart';

/// Properties listing section with grid and pagination
class PropertiesListingSection extends StatelessWidget {
  final GlobalKey? sectionKey;
  final ClientPropertiesController controller;

  const PropertiesListingSection({
    super.key,
    this.sectionKey,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // PropertiesListingContent already handles reactivity with its own Obx
    return Container(
      key: sectionKey,
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: AppResponsive.screenHeight(context) * 0.5,
      ),
      color: AppColors.white,
      padding: AppSpacing.symmetric(context, h: 0.1, v: 0.06),
      child: PropertiesListingContent(controller: controller),
    );
  }
}
