import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';

/// Property description section widget
class ClientPropertyDetailDescriptionSection extends StatelessWidget {
  final PropertyModel property;

  const ClientPropertyDetailDescriptionSection({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpacing.horizontal(context, 0.02),
        Text(
          AppTexts.clientPropertyDetailDescription,
          style: AppTextStyles.heading(context).copyWith(
            fontSize: AppResponsive.fontSizeClamped(context, min: 24, max: 30),
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        AppSpacing.vertical(context, 0.03),
        Text(
          property.fullDescription.isNotEmpty
              ? property.fullDescription
              : property.shortDescription,
          style: AppTextStyles.bodyText(context).copyWith(
            fontSize: AppResponsive.fontSizeClamped(context, min: 16, max: 18),
            height: 1.8,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
