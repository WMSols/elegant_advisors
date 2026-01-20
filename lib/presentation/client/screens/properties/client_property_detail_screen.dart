import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_images/app_images.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_property_detail_controller.dart';
import 'package:elegant_advisors/presentation/client/widgets/layout/app_header.dart';
import 'package:elegant_advisors/presentation/client/widgets/layout/app_footer.dart';
import 'package:elegant_advisors/presentation/client/widgets/header/header_mobile_drawer.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';
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
    return Scaffold(
      drawer: HeaderMobileDrawer(onClose: () => Navigator.of(context).pop()),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: AppLoadingIndicator(variant: LoadingIndicatorVariant.white),
          );
        }

        if (controller.property.value == null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppTexts.clientPropertyDetailNotFound,
                    style: AppTextStyles.heading(context),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            ),
          );
        }

        final property = controller.property.value!;
        final relatedProperties = controller.relatedProperties;

        return Stack(
          children: [
            // Main scrollable content
            SingleChildScrollView(
              key: controller.scrollViewKey,
              controller: controller.scrollController,
              child: Column(
                children: [
                  // Spacer to account for fixed header and breadcrumbs height
                  SizedBox(
                    height: AppResponsive.scaleSize(
                      context,
                      100,
                      min: 70,
                      max: 130,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: AppSpacing.symmetric(context, h: 0.04, v: 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Breadcrumbs positioned under header with background
                        Obx(
                          () => controller.property.value != null
                              ? ClientPropertyDetailBreadcrumbs(
                                  propertyTitle:
                                      controller.property.value!.title,
                                )
                              : const SizedBox.shrink(),
                        ),
                        AppSpacing.vertical(context, 0.02),
                        // Image Gallery
                        ClientPropertyDetailImageGallery(
                          images: property.images.isNotEmpty
                              ? property.images
                              : [],
                          height: AppResponsive.screenHeight(context) * 0.75,
                        ),
                      ],
                    ),
                  ),
                  // Sections with background (full width)
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary, // Fallback color
                      image: const DecorationImage(
                        image: AssetImage(AppImages.homeBackground),
                        fit: BoxFit.cover,
                        onError: null,
                      ),
                    ),
                    padding: AppSpacing.symmetric(context, h: 0.04, v: 0.04),
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
                        ClientPropertyDetailDescriptionSection(
                          property: property,
                        ),
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
                  Container(
                    width: double.infinity,
                    padding: AppSpacing.symmetric(context, h: 0.04, v: 0.04),
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
                  // Footer
                  const AppFooter(),
                ],
              ),
            ),
            // Header always visible with primary color background
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Obx(
                () => AppHeader(showBackground: controller.showHeader.value),
              ),
            ),
          ],
        );
      }),
    );
  }
}
