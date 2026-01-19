import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';

/// Empty state widget when no properties are found
class ClientPropertiesEmptyState extends StatelessWidget {
  final VoidCallback? onClearFilters;

  const ClientPropertiesEmptyState({super.key, this.onClearFilters});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.all(context, factor: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.search_normal_1,
            size: AppResponsive.scaleSize(context, 80, min: 60, max: 100),
            color: AppColors.grey.withValues(alpha: 0.5),
          ),
          AppSpacing.vertical(context, 0.03),
          Text(
            AppTexts.clientPropertiesNoPropertiesFound,
            style: AppTextStyles.heading(context).copyWith(
              fontSize: AppResponsive.fontSizeClamped(
                context,
                min: 20,
                max: 28,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.vertical(context, 0.02),
          Text(
            AppTexts.clientPropertiesNoPropertiesMessage,
            style: AppTextStyles.bodyText(context).copyWith(
              color: AppColors.grey,
              fontSize: AppResponsive.fontSizeClamped(
                context,
                min: 14,
                max: 16,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          if (onClearFilters != null) ...[
            AppSpacing.vertical(context, 0.03),
            AppButton(
              text: AppTexts.clientPropertiesClearFilters,
              onPressed: onClearFilters,
              backgroundColor: AppColors.primary,
              textColor: AppColors.white,
            ),
          ],
        ],
      ),
    );
  }
}
