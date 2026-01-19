import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';

/// Property features section widget
class ClientPropertyDetailFeaturesSection extends StatelessWidget {
  final PropertyModel property;

  const ClientPropertyDetailFeaturesSection({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    if (property.features.isEmpty) {
      return const SizedBox.shrink();
    }

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
            AppTexts.clientPropertyDetailFeatures,
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
            spacing: AppResponsive.scaleSize(context, 16, min: 12, max: 20),
            runSpacing: AppResponsive.scaleSize(context, 12, min: 8, max: 16),
            children: property.features.map((feature) {
              return _buildFeatureChip(context, feature);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(BuildContext context, String feature) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppResponsive.scaleSize(context, 16, min: 12, max: 20),
        vertical: AppResponsive.scaleSize(context, 10, min: 8, max: 12),
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(
          AppResponsive.radius(context, factor: 1.5),
        ),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Iconsax.tick_circle,
            size: AppResponsive.scaleSize(context, 16, min: 14, max: 18),
            color: AppColors.primary,
          ),
          AppSpacing.horizontal(context, 0.01),
          Text(
            feature,
            style: AppTextStyles.bodyText(context).copyWith(
              color: AppColors.primary,
              fontSize: AppResponsive.fontSizeClamped(
                context,
                min: 14,
                max: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
