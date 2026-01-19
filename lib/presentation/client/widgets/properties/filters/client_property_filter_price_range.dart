import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';

/// Price range filter field
class ClientPropertyFilterPriceRange extends StatelessWidget {
  final double? minPrice;
  final double? maxPrice;
  final double? availableMaxPrice;
  final Function(double?) onMinPriceChanged;
  final Function(double?) onMaxPriceChanged;

  const ClientPropertyFilterPriceRange({
    super.key,
    required this.minPrice,
    required this.maxPrice,
    required this.availableMaxPrice,
    required this.onMinPriceChanged,
    required this.onMaxPriceChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (availableMaxPrice == null || availableMaxPrice! <= 0) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTexts.clientPropertiesFilterPriceRange,
          style: AppTextStyles.bodyText(context).copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.primaryFont,
            color: AppColors.primary,
          ),
        ),
        AppSpacing.vertical(context, 0.01),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Min',
                  prefixText: '€ ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppResponsive.radius(context),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final price = double.tryParse(value);
                  onMinPriceChanged(price);
                },
              ),
            ),
            AppSpacing.horizontal(context, 0.02),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Max',
                  prefixText: '€ ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppResponsive.radius(context),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final price = double.tryParse(value);
                  onMaxPriceChanged(price);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
