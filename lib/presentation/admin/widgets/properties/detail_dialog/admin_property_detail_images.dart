import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';
import 'package:elegant_advisors/core/widgets/images/app_network_image.dart';
import 'package:elegant_advisors/core/widgets/display/app_property_status_badge.dart';

/// Images section for property detail dialog
class AdminPropertyDetailImages extends StatelessWidget {
  final List<String> images;
  final String? coverImage;

  const AdminPropertyDetailImages({
    super.key,
    required this.images,
    this.coverImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTexts.adminPropertyDetailImages,
          style: AppTextStyles.heading(
            context,
          ).copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        AppSpacing.vertical(context, 0.01),
        SizedBox(
          height: AppResponsive.scaleSize(context, 200, min: 150, max: 250),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              final imageUrl = images[index];
              final isCover = coverImage == imageUrl;
              return Container(
                width: AppResponsive.scaleSize(
                  context,
                  200,
                  min: 150,
                  max: 250,
                ),
                margin: EdgeInsets.only(
                  right: AppResponsive.scaleSize(context, 8, min: 4, max: 12),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppResponsive.radius(context),
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AppNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      loadingVariant: LoadingIndicatorVariant.white,
                      maxWidthDiskCache: 1000,
                      maxHeightDiskCache: 1000,
                      borderRadius: AppResponsive.radius(context),
                      backgroundColor: AppColors.grey.withValues(alpha: 0.2),
                      iconColor: AppColors.white,
                    ),
                    if (isCover)
                      Positioned(
                        top: AppResponsive.scaleSize(
                          context,
                          8,
                          min: 4,
                          max: 12,
                        ),
                        left: AppResponsive.scaleSize(
                          context,
                          8,
                          min: 4,
                          max: 12,
                        ),
                        child: AppPropertyStatusBadge(
                          text: AppTexts.adminPropertyDetailCover,
                          color: AppColors.warning,
                          icon: Iconsax.star,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        AppSpacing.vertical(context, 0.02),
      ],
    );
  }
}
