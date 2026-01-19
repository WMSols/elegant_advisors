import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/cards/client_property_card.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTexts.clientPropertyDetailRelatedProperties,
          style: AppTextStyles.heading(context).copyWith(
            fontSize: AppResponsive.fontSizeClamped(context, min: 24, max: 32),
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.vertical(context, 0.03),
        // Grid of related properties
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = AppResponsive.isMobile(context)
                ? 1
                : AppResponsive.isTablet(context)
                ? 2
                : 3;

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
                childAspectRatio: 0.85,
              ),
              itemCount: relatedProperties.length,
              itemBuilder: (context, index) {
                final property = relatedProperties[index];
                return ClientPropertyCard(
                  property: property,
                  index: index,
                  onTap: () {
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
        ),
      ],
    );
  }
}
