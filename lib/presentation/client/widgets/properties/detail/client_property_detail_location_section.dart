import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_helpers/app_helpers.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';

/// Property location section widget
class ClientPropertyDetailLocationSection extends StatelessWidget {
  final PropertyModel property;

  const ClientPropertyDetailLocationSection({
    super.key,
    required this.property,
  });

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
          Row(
            children: [
              Icon(
                Iconsax.location,
                size: AppResponsive.scaleSize(context, 24, min: 20, max: 28),
                color: AppColors.primary,
              ),
              AppSpacing.horizontal(context, 0.01),
              Text(
                AppTexts.clientPropertyDetailLocation,
                style: AppTextStyles.heading(context).copyWith(
                  fontSize: AppResponsive.fontSizeClamped(
                    context,
                    min: 20,
                    max: 26,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          AppSpacing.vertical(context, 0.02),
          Text(
            AppHelpers.formatPropertyLocationFull(
              property.location.country,
              property.location.city,
              property.location.area,
              property.location.address,
            ),
            style: AppTextStyles.bodyText(context).copyWith(
              fontSize: AppResponsive.fontSizeClamped(
                context,
                min: 16,
                max: 18,
              ),
            ),
          ),
          // Map placeholder - can be replaced with actual map widget
          if (property.location.lat != null &&
              property.location.lng != null) ...[
            AppSpacing.vertical(context, 0.02),
            Container(
              height: AppResponsive.screenHeight(context) * 0.3,
              decoration: BoxDecoration(
                color: AppColors.grey.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(
                  AppResponsive.radius(context),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.map,
                      size: AppResponsive.scaleSize(
                        context,
                        48,
                        min: 40,
                        max: 56,
                      ),
                      color: AppColors.primary,
                    ),
                    AppSpacing.vertical(context, 0.01),
                    Text(
                      'Map View',
                      style: AppTextStyles.bodyText(
                        context,
                      ).copyWith(color: AppColors.grey),
                    ),
                    Text(
                      'Lat: ${property.location.lat}, Lng: ${property.location.lng}',
                      style: AppTextStyles.bodyText(context).copyWith(
                        color: AppColors.grey,
                        fontSize: AppResponsive.fontSizeClamped(
                          context,
                          min: 12,
                          max: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
