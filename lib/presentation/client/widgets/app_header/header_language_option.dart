import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors/app_colors.dart';
import '../../../../core/utils/app_responsive/app_responsive.dart';

class HeaderLanguageOption extends StatelessWidget {
  final String flagImage;
  final bool isSelected;
  final VoidCallback onTap;

  const HeaderLanguageOption({
    super.key,
    required this.flagImage,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppResponsive.scaleSize(context, 12, min: 8, max: 16),
          vertical: AppResponsive.scaleSize(context, 8, min: 6, max: 10),
        ),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.primary.withValues(alpha: 0.3)
              : Colors.transparent,
        ),
        child: Container(
          width: AppResponsive.scaleSize(context, 24, min: 20, max: 25),
          height: AppResponsive.scaleSize(context, 18, min: 15, max: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
              color: AppColors.white.withValues(alpha:0.3),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Image.asset(
              flagImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.grey.withValues(alpha:0.3),
                  child: Icon(
                    Icons.flag,
                    size: AppResponsive.scaleSize(context, 12, min: 10, max: 16),
                    color: AppColors.white,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

