import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_property_detail_controller.dart';
import 'package:elegant_advisors/presentation/client/widgets/layout/app_header.dart';
import 'package:elegant_advisors/presentation/client/widgets/layout/app_footer.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/detail/client_property_detail_breadcrumbs.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/detail/client_property_detail_image_gallery.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/detail/client_property_detail_specs_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/detail/client_property_detail_features_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/detail/client_property_detail_location_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/detail/client_property_detail_related_properties.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/detail/client_property_inquiry_button.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/detail/client_property_detail_header_section.dart';

class ClientPropertyDetailScreen
    extends GetView<ClientPropertyDetailController> {
  const ClientPropertyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

        return SingleChildScrollView(
          child: Column(
            children: [
              const AppHeader(),
              Container(
                width: double.infinity,
                padding: AppSpacing.symmetric(context, h: 0.04, v: 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Breadcrumbs
                    ClientPropertyDetailBreadcrumbs(
                      propertyTitle: property.title,
                    ),
                    AppSpacing.vertical(context, 0.03),
                    // Image Gallery
                    ClientPropertyDetailImageGallery(
                      images: property.images.isNotEmpty
                          ? property.images
                          : [],
                      height: AppResponsive.screenHeight(context) * 0.5,
                    ),
                    AppSpacing.vertical(context, 0.04),
                    // Property Header
                    ClientPropertyDetailHeaderSection(property: property),
                    AppSpacing.vertical(context, 0.04),
                    // Specifications
                    ClientPropertyDetailSpecsSection(property: property),
                    AppSpacing.vertical(context, 0.03),
                    // Description
                    Container(
                      padding: AppSpacing.all(context, factor: 1.5),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(
                          AppResponsive.radius(context, factor: 1.5),
                        ),
                        border: Border.all(
                          color: AppColors.grey.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppTexts.clientPropertyDetailDescription,
                            style: AppTextStyles.heading(context).copyWith(
                              fontSize: AppResponsive.fontSizeClamped(
                                context,
                                min: 20,
                                max: 26,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AppSpacing.vertical(context, 0.02),
                          Text(
                            property.fullDescription.isNotEmpty
                                ? property.fullDescription
                                : property.shortDescription,
                            style: AppTextStyles.bodyText(context).copyWith(
                              fontSize: AppResponsive.fontSizeClamped(
                                context,
                                min: 16,
                                max: 18,
                              ),
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.vertical(context, 0.03),
                    // Features
                    ClientPropertyDetailFeaturesSection(property: property),
                    AppSpacing.vertical(context, 0.03),
                    // Location
                    ClientPropertyDetailLocationSection(property: property),
                    AppSpacing.vertical(context, 0.04),
                    // Inquiry Button
                    Center(
                      child: ClientPropertyInquiryButton(
                        propertyId: property.id,
                      ),
                    ),
                    AppSpacing.vertical(context, 0.04),
                    // Related Properties
                    ClientPropertyDetailRelatedProperties(
                      relatedProperties: relatedProperties,
                      currentPropertyId: property.id ?? '',
                    ),
                  ],
                ),
              ),
              const AppFooter(),
            ],
          ),
        );
      }),
    );
  }
}
