import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';

/// Responsive header content widget (replaces desktop/mobile duplicates)
class PropertiesHeaderContent extends StatelessWidget {
  final VoidCallback? onButtonPressed;

  const PropertiesHeaderContent({
    super.key,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = AppResponsive.isMobile(context);

    if (isMobile) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main Headline
          Text(
            AppTexts.propertiesTitle,
            style: AppTextStyles.headline(context).copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w300,
              letterSpacing: 2,
              fontSize: AppResponsive.fontSizeClamped(context, min: 28, max: 36),
            ),
            textAlign: TextAlign.left,
          ),
          AppSpacing.vertical(context, 0.04),
          // Description
          Text(
            AppTexts.propertiesDescription,
            style: AppTextStyles.bodyText(context).copyWith(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: AppResponsive.fontSizeClamped(context, min: 14, max: 18),
            ),
            textAlign: TextAlign.left,
          ),
          AppSpacing.vertical(context, 0.06),
          // CTA Button
          AppButton(
            text: 'View Properties',
            backgroundColor: AppColors.lightGrey,
            textColor: AppColors.black,
            width: AppResponsive.screenWidth(context) * 0.9,
            onPressed: onButtonPressed,
          ),
        ],
      );
    }

    // Desktop
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: AppResponsive.screenWidth(context) * 0.9,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Main Headline
            Text(
              AppTexts.propertiesTitle,
              style: AppTextStyles.headline(context).copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w300,
                letterSpacing: 2,
                fontSize: AppResponsive.fontSizeClamped(
                  context,
                  min: 36,
                  max: 48,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.vertical(context, 0.04),
            // Description
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: AppResponsive.screenWidth(context) * 0.6,
              ),
              child: Text(
                AppTexts.propertiesDescription,
                style: AppTextStyles.bodyText(context).copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: AppResponsive.fontSizeClamped(
                    context,
                    min: 16,
                    max: 20,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            AppSpacing.vertical(context, 0.06),
            // CTA Button
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: AppResponsive.screenWidth(context) * 0.2,
              ),
              child: AppButton(
                text: 'View Properties',
                backgroundColor: AppColors.lightGrey,
                textColor: AppColors.black,
                onPressed: onButtonPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
