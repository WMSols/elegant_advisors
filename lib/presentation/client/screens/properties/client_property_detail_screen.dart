import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_property_detail_controller.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_screen_layout.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_background_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_content_container.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_empty_state.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/detail/client_property_detail_breadcrumbs.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/detail/client_property_detail_image_gallery.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/detail/client_property_detail_specs_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/detail/client_property_detail_features_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/detail/client_property_detail_location_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/detail/client_property_detail_related_properties.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/detail/client_property_inquiry_button.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/detail/client_property_detail_header_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/detail/client_property_detail_description_section.dart';

class ClientPropertyDetailScreen
    extends GetView<ClientPropertyDetailController> {
  const ClientPropertyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Scaffold(
          body: const Center(
            child: AppLoadingIndicator(variant: LoadingIndicatorVariant.white),
          ),
        );
      }

      if (controller.property.value == null) {
        return Scaffold(
          body: AppEmptyState(
            title: AppTexts.clientPropertyDetailNotFound,
            message: AppTexts.clientPropertyDetailNotFoundMessage,
            buttonText: AppTexts.commonGoBack,
            onButtonPressed: () => Get.back(),
            centerContent: true,
          ),
        );
      }

      final property = controller.property.value!;
      final relatedProperties = controller.relatedProperties;

      return ClientScreenLayout(
        scrollController: controller.scrollController,
        scrollViewKey: controller.scrollViewKey,
        showHeader: controller.showHeader,
        children: [
          // Spacer to account for fixed header and breadcrumbs height
          SizedBox(
            height: AppResponsive.scaleSize(context, 100, min: 70, max: 130),
          ),
          ClientContentContainer(
            horizontalPadding: 0.04,
            verticalPadding: 0.04,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Breadcrumbs positioned under header with background
                Obx(
                  () => controller.property.value != null
                      ? ClientPropertyDetailBreadcrumbs(
                          propertyTitle: controller.property.value!.title,
                        )
                      : const SizedBox.shrink(),
                ),
                AppSpacing.vertical(context, 0.02),
                // Image Gallery
                ClientPropertyDetailImageGallery(
                  images: property.images.isNotEmpty ? property.images : [],
                  height: AppResponsive.screenHeight(context) * 0.75,
                ),
              ],
            ),
          ),
          // Sections with background (full width)
          ClientBackgroundSection(
            horizontalPadding: 0.04,
            verticalPadding: 0.04,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Property Header
                ClientPropertyDetailHeaderSection(property: property),
                AppSpacing.vertical(context, 0.04),
                // Specifications
                ClientPropertyDetailSpecsSection(property: property),
                AppSpacing.vertical(context, 0.03),
                // Description
                ClientPropertyDetailDescriptionSection(property: property),
                AppSpacing.vertical(context, 0.03),
                // Features
                ClientPropertyDetailFeaturesSection(property: property),
                AppSpacing.vertical(context, 0.03),
                // Location
                ClientPropertyDetailLocationSection(property: property),
              ],
            ),
          ),
          // Inquiry Button and Related Properties
          ClientContentContainer(
            horizontalPadding: 0.04,
            verticalPadding: 0.04,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Inquiry Button
                ClientPropertyInquiryButton(propertyId: property.id),
                AppSpacing.vertical(context, 0.04),
                // Related Properties
                ClientPropertyDetailRelatedProperties(
                  relatedProperties: relatedProperties,
                  currentPropertyId: property.id ?? '',
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
