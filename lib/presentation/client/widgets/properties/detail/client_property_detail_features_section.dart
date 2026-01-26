import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.clientPropertyDetailFeatures,
          style: AppTextStyles.heading(context).copyWith(
            fontSize: AppResponsive.fontSizeClamped(context, min: 24, max: 30),
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        AppSpacing.vertical(context, 0.03),
        Wrap(
          spacing: AppResponsive.scaleSize(context, 16, min: 12, max: 20),
          runSpacing: AppResponsive.scaleSize(context, 16, min: 12, max: 20),
          children: property.features.map((feature) {
            return Text(
              feature,
              style: AppTextStyles.bodyText(context).copyWith(
                color: AppColors.white,
                fontSize: AppResponsive.fontSizeClamped(
                  context,
                  min: 15,
                  max: 17,
                ),
                fontWeight: FontWeight.w600,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
