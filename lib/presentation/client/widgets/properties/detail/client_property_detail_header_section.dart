import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_helpers/app_helpers.dart';
import 'package:elegant_advisors/core/widgets/display/app_property_status_badge.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';

/// Property detail header section (title, location, price, status)
class ClientPropertyDetailHeaderSection extends StatelessWidget {
  final PropertyModel property;

  const ClientPropertyDetailHeaderSection({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                property.title,
                style: AppTextStyles.headline(context).copyWith(
                  fontSize: AppResponsive.fontSizeClamped(
                    context,
                    min: 28,
                    max: 36,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSpacing.vertical(context, 0.01),
              // Location
              Text(
                AppHelpers.formatPropertyLocationFull(
                  property.location.country,
                  property.location.city,
                  property.location.area,
                  property.location.address,
                ),
                style: AppTextStyles.bodyText(context).copyWith(
                  color: AppColors.primary,
                  fontSize: AppResponsive.fontSizeClamped(
                    context,
                    min: 16,
                    max: 20,
                  ),
                ),
              ),
              AppSpacing.vertical(context, 0.01),
              // Price
              Text(
                property.price.isOnRequest
                    ? AppTexts.clientPropertiesPriceOnRequest
                    : property.price.amount == null
                        ? AppTexts.clientPropertiesPriceOnRequest
                        : AppHelpers.formatCurrency(
                            property.price.amount!,
                            property.price.currency,
                          ),
                style: AppTextStyles.heading(context).copyWith(
                  color: AppColors.primary,
                  fontSize: AppResponsive.fontSizeClamped(
                    context,
                    min: 24,
                    max: 32,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // Status Badge
        AppPropertyStatusBadge(status: property.status),
      ],
    );
  }
}
