import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';

/// Property specifications section widget
class ClientPropertyDetailSpecsSection extends StatelessWidget {
  final PropertyModel property;

  const ClientPropertyDetailSpecsSection({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.all(context, factor: 1.5),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          AppResponsive.radius(context, factor: 1.5),
        ),
        border: Border.all(color: AppColors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.clientPropertyDetailSpecifications,
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
          Wrap(
            spacing: AppResponsive.scaleSize(context, 24, min: 16, max: 32),
            runSpacing: AppResponsive.scaleSize(context, 16, min: 12, max: 20),
            children: [
              if (property.specs.propertyType.isNotEmpty)
                _buildSpecItem(
                  context,
                  Iconsax.home,
                  'Type',
                  property.specs.propertyType,
                ),
              if (property.specs.bedrooms != null)
                _buildSpecItem(
                  context,
                  Iconsax.home,
                  'Bedrooms',
                  '${property.specs.bedrooms}',
                ),
              if (property.specs.bathrooms != null)
                _buildSpecItem(
                  context,
                  Iconsax.drop,
                  'Bathrooms',
                  '${property.specs.bathrooms}',
                ),
              if (property.specs.areaSize != null &&
                  property.specs.areaUnit != null)
                _buildSpecItem(
                  context,
                  Iconsax.ruler,
                  'Area',
                  '${property.specs.areaSize} ${property.specs.areaUnit}',
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: AppResponsive.scaleSize(context, 20, min: 18, max: 24),
          color: AppColors.primary,
        ),
        AppSpacing.horizontal(context, 0.01),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTextStyles.bodyText(context).copyWith(
                color: AppColors.grey,
                fontSize: AppResponsive.fontSizeClamped(
                  context,
                  min: 12,
                  max: 14,
                ),
              ),
            ),
            Text(
              value,
              style: AppTextStyles.heading(context).copyWith(
                fontSize: AppResponsive.fontSizeClamped(
                  context,
                  min: 16,
                  max: 20,
                ),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
