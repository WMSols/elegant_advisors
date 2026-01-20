import 'package:flutter/material.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTexts.clientPropertyDetailSpecifications,
          style: AppTextStyles.heading(context).copyWith(
            fontSize: AppResponsive.fontSizeClamped(context, min: 24, max: 30),
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        AppSpacing.vertical(context, 0.03),
        Column(
          children: [
            if (property.specs.propertyType.isNotEmpty)
              _buildSpecItem(context, 'Type:', property.specs.propertyType),
            if (property.specs.bedrooms != null) ...[
              AppSpacing.vertical(context, 0.02),
              _buildSpecItem(
                context,
                'Bedrooms:',
                '${property.specs.bedrooms}',
              ),
            ],
            if (property.specs.bathrooms != null) ...[
              AppSpacing.vertical(context, 0.02),
              _buildSpecItem(
                context,
                'Bathrooms:',
                '${property.specs.bathrooms}',
              ),
            ],
            if (property.specs.areaSize != null &&
                property.specs.areaUnit != null) ...[
              AppSpacing.vertical(context, 0.02),
              _buildSpecItem(
                context,
                'Area:',
                '${property.specs.areaSize} ${property.specs.areaUnit}',
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildSpecItem(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppSpacing.vertical(context, 0.015),
        Text(
          label,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.white,
            fontSize: AppResponsive.fontSizeClamped(context, min: 14, max: 16),
          ),
          textAlign: TextAlign.center,
        ),
        AppSpacing.horizontal(context, 0.005),
        Text(
          value,
          style: AppTextStyles.heading(context).copyWith(
            fontSize: AppResponsive.fontSizeClamped(context, min: 14, max: 16),
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
