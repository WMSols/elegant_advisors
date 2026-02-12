import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/cards/client_property_card.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_property_detail_controller.dart';

/// Related properties section widget
class ClientPropertyDetailRelatedProperties extends StatelessWidget {
  final List<PropertyModel> relatedProperties;
  final String currentPropertyId;

  const ClientPropertyDetailRelatedProperties({
    super.key,
    required this.relatedProperties,
    required this.currentPropertyId,
  });

  @override
  Widget build(BuildContext context) {
    if (relatedProperties.isEmpty) {
      return const SizedBox.shrink();
    }

    final isDesktop =
        !AppResponsive.isMobile(context) && !AppResponsive.isTablet(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.clientPropertyDetailRelatedProperties,
          style: AppTextStyles.heading(context).copyWith(
            fontSize: AppResponsive.fontSizeClamped(context, min: 24, max: 32),
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.vertical(context, 0.03),
        // Desktop: Horizontal scroll with 2 cards visible, Mobile/Tablet: Vertical grid
        isDesktop
            ? _buildDesktopHorizontalScroll(context)
            : _buildMobileTabletGrid(context),
      ],
    );
  }

  Widget _buildDesktopHorizontalScroll(BuildContext context) {
    // Fixed height for all cards to ensure consistency
    final cardHeight = AppResponsive.screenHeight(context) * 0.75;
    final spacing = AppResponsive.scaleSize(context, 24, min: 20, max: 32);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate card width to show 2 cards (with spacing)
        final availableWidth = constraints.maxWidth;
        final cardWidth = (availableWidth - spacing) / 2;

        return SizedBox(
          height: cardHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: relatedProperties.length,
            separatorBuilder: (context, index) => SizedBox(width: spacing),
            itemBuilder: (context, index) {
              final property = relatedProperties[index];
              final isOffMarket = property.status == 'off_market';
              return SizedBox(
                width: cardWidth,
                height: cardHeight,
                child: ClientPropertyCard(
                  property: property,
                  index: index,
                  isRelatedProperty: true,
                  fixedHeight: cardHeight,
                  isInquireOnly: isOffMarket,
                  onTap: isOffMarket && property.id != null
                      ? () {
                          Get.toNamed(
                            ClientConstants.routeClientContact,
                            arguments: property.id,
                          );
                        }
                      : () {
                          if (Get.isRegistered<
                            ClientPropertyDetailController
                          >()) {
                            Get.delete<ClientPropertyDetailController>();
                          }
                          Get.toNamed(
                            ClientConstants.routeClientPropertyDetail
                                .replaceAll(':slug', property.slug),
                          );
                        },
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildMobileTabletGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = AppResponsive.isMobile(context) ? 1 : 2;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppResponsive.scaleSize(
              context,
              24,
              min: 16,
              max: 32,
            ),
            mainAxisSpacing: AppResponsive.scaleSize(
              context,
              24,
              min: 16,
              max: 32,
            ),
            childAspectRatio: 0.75,
          ),
          itemCount: relatedProperties.length,
          itemBuilder: (context, index) {
            final property = relatedProperties[index];
            final isOffMarket = property.status == 'off_market';
            return ClientPropertyCard(
              property: property,
              index: index,
              isRelatedProperty: true,
              isInquireOnly: isOffMarket,
              onTap: isOffMarket && property.id != null
                  ? () {
                      Get.toNamed(
                        ClientConstants.routeClientContact,
                        arguments: property.id,
                      );
                    }
                  : () {
                      if (Get.isRegistered<ClientPropertyDetailController>()) {
                        Get.delete<ClientPropertyDetailController>();
                      }
                      Get.toNamed(
                        ClientConstants.routeClientPropertyDetail.replaceAll(
                          ':slug',
                          property.slug,
                        ),
                      );
                    },
            );
          },
        );
      },
    );
  }
}
