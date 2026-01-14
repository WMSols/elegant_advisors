import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/presentation/admin/controllers/properties/admin_property_form_controller.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/form_sections/admin_property_form_section.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';
import 'package:elegant_advisors/core/widgets/images/app_network_image.dart';
import 'package:elegant_advisors/core/widgets/display/app_property_status_badge.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_icon_button.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

class AdminPropertyImagesSection extends GetView<AdminPropertyFormController> {
  const AdminPropertyImagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminPropertyFormSection(
      title: AppTexts.adminPropertyFormImages,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(
            () => Text(
              '${controller.images.length + controller.imageFiles.length} / ${AdminPropertyFormController.maxImages} ${AppTexts.adminPropertyFormMaxImages}',
              style: AppTextStyles.bodyText(context).copyWith(
                color: AppColors.white,
              ),
            ),
          ),
          AppSpacing.vertical(context, 0.02),
          Obx(
            () => (controller.images.isEmpty && controller.imageFiles.isEmpty)
                ? Container(
                    height: AppResponsive.scaleSize(context, 200, min: 150, max: 250),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(
                        AppResponsive.radius(context),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.image,
                            size: AppResponsive.scaleSize(context, 48, min: 40, max: 56),
                            color: AppColors.white.withValues(alpha: 0.5),
                          ),
                          AppSpacing.vertical(context, 0.01),
                          Text(
                            AppTexts.adminPropertyFormNoImagesAdded,
                            style: AppTextStyles.bodyText(context).copyWith(
                              color: AppColors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: AppResponsive.scaleSize(context, 8, min: 4, max: 12),
                      mainAxisSpacing: AppResponsive.scaleSize(context, 8, min: 4, max: 12),
                      childAspectRatio: 1,
                    ),
                    itemCount: controller.images.length + controller.imageFiles.length,
                    itemBuilder: (context, index) {
                      final isUploadedImage = index < controller.images.length;
                      return Obx(
                        () {
                          // Rebuild when coverImageIndex changes
                          final currentIsCover = controller.coverImageIndex.value == index;
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              isUploadedImage
                                  ? AppNetworkImage(
                                      imageUrl: controller.images[index],
                                      fit: BoxFit.cover,
                                      loadingVariant: LoadingIndicatorVariant.white,
                                      maxWidthDiskCache: 800,
                                      maxHeightDiskCache: 800,
                                      borderRadius: AppResponsive.radius(context),
                                      backgroundColor: AppColors.grey.withValues(alpha: 0.2),
                                      iconColor: AppColors.white,
                                      enableDebugLogging: true,
                                    )
                                  : FutureBuilder<Uint8List>(
                                      future: controller.imageFiles[index - controller.images.length].readAsBytes(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              AppResponsive.radius(context),
                                            ),
                                            child: Image.memory(
                                              snapshot.data!,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        }
                                        return Container(
                                          color: AppColors.grey.withValues(alpha: 0.2),
                                          child: Center(
                                            child: AppLoadingIndicator(
                                              variant: LoadingIndicatorVariant.white,
                                              size: AppResponsive.scaleSize(context, 40, min: 30, max: 50),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                              if (currentIsCover)
                                Positioned(
                                  top: AppResponsive.scaleSize(context, 4, min: 2, max: 8),
                                  left: AppResponsive.scaleSize(context, 4, min: 2, max: 8),
                                  child: AppPropertyStatusBadge(
                                    text: AppTexts.adminPropertyFormCoverImage,
                                    color: AppColors.warning,
                                    icon: Iconsax.star,
                                  ),
                                ),
                              Positioned(
                                top: AppResponsive.scaleSize(context, 4, min: 2, max: 8),
                                right: AppResponsive.scaleSize(context, 4, min: 2, max: 8),
                                child: AppIconButton(
                                  icon: Iconsax.trash,
                                  color: AppColors.error,
                                  onPressed: () => controller.removeImage(index),
                                  iconSize: AppResponsive.scaleSize(context, 20, min: 18, max: 24),
                                  tooltip: 'Remove image',
                                ),
                              ),
                              // Show star button to make image cover
                              Positioned(
                                bottom: AppResponsive.scaleSize(context, 4, min: 2, max: 8),
                                left: AppResponsive.scaleSize(context, 4, min: 2, max: 8),
                                child: AppIconButton(
                                  icon: Iconsax.star,
                                  color: currentIsCover ? AppColors.warning : AppColors.white,
                                  backgroundColor: currentIsCover
                                      ? AppColors.warning.withValues(alpha: 0.2)
                                      : AppColors.black.withValues(alpha: 0.3),
                                  onPressed: () => controller.setCoverImage(index),
                                  iconSize: AppResponsive.scaleSize(context, 20, min: 18, max: 24),
                                  tooltip: currentIsCover
                                      ? 'Cover image'
                                      : 'Set as cover image',
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
          ),
          AppSpacing.vertical(context, 0.02),
          Obx(
            () => AppButton(
              text: AppTexts.adminPropertyFormAddImage,
              onPressed: (controller.images.length + controller.imageFiles.length >= AdminPropertyFormController.maxImages)
                  ? null
                  : controller.pickImages,
              backgroundColor: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
