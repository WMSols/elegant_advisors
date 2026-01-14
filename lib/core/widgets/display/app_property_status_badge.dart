import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';

/// Reusable status badge widget for properties and cover image status
class AppPropertyStatusBadge extends StatelessWidget {
  final String?
  status; // Property status (available, sold, etc.) or null for custom text
  final String? text; // Custom text (for cover image status)
  final Color? color; // Custom color (for cover image status)
  final IconData? icon; // Optional icon (for cover image status)

  const AppPropertyStatusBadge({
    super.key,
    this.status,
    this.text,
    this.color,
    this.icon,
  }) : assert(
         (status != null && text == null) || (status == null && text != null),
         'Either status or text must be provided, but not both',
       );

  Color _getStatusColor() {
    if (color != null) return color!;
    if (status == null) return AppColors.primary;

    switch (status!) {
      case 'available':
        return Colors.green;
      case 'sold':
        return Colors.red;
      case 'off_market':
        return Colors.orange;
      case 'coming_soon':
        return Colors.blue;
      default:
        return AppColors.primary;
    }
  }

  String _getStatusText() {
    if (text != null) return text!;
    if (status == null) return '';

    switch (status!) {
      case 'available':
        return AppTexts.adminPropertiesStatusAvailable;
      case 'sold':
        return AppTexts.adminPropertiesStatusSold;
      case 'off_market':
        return AppTexts.adminPropertiesStatusOffMarket;
      case 'coming_soon':
        return AppTexts.adminPropertiesStatusComingSoon;
      default:
        return status!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppResponsive.scaleSize(context, 8, min: 6, max: 12),
        vertical: AppResponsive.scaleSize(context, 4, min: 2, max: 6),
      ),
      decoration: BoxDecoration(
        color: _getStatusColor(),
        borderRadius: BorderRadius.circular(
          AppResponsive.radius(context, factor: 3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: AppResponsive.scaleSize(context, 12, min: 10, max: 14),
              color: AppColors.white,
            ),
            SizedBox(
              width: AppResponsive.scaleSize(context, 4, min: 2, max: 6),
            ),
          ],
          Text(
            _getStatusText(),
            style: AppTextStyles.heading(context).copyWith(
              color: AppColors.white,
              fontSize: AppResponsive.fontSizeClamped(
                context,
                min: 10,
                max: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
