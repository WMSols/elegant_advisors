import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_action_button.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';

/// Header section for property detail dialog with title and action buttons
class AdminPropertyDetailHeader extends StatelessWidget {
  final PropertyModel property;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTogglePublish;

  const AdminPropertyDetailHeader({
    super.key,
    required this.property,
    required this.onEdit,
    required this.onDelete,
    required this.onTogglePublish,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.all(context, factor: 0.8),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppResponsive.radius(context)),
          topRight: Radius.circular(AppResponsive.radius(context)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              property.title,
              style: AppTextStyles.heading(
                context,
              ).copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          AppSpacing.horizontal(context, 0.02),
          AppActionButton(
            label: property.isPublished
                ? AppTexts.adminPropertiesUnpublished
                : AppTexts.adminPropertiesPublished,
            onPressed: onTogglePublish,
            backgroundColor: property.isPublished
                ? AppColors.warning
                : AppColors.success,
            icon: property.isPublished ? Iconsax.eye_slash : Iconsax.eye,
          ),
          AppSpacing.horizontal(context, 0.01),
          AppActionButton(
            label: AppTexts.adminPropertiesEdit,
            onPressed: onEdit,
            backgroundColor: AppColors.information,
            icon: Iconsax.edit,
          ),
          AppSpacing.horizontal(context, 0.01),
          AppActionButton(
            label: AppTexts.adminPropertiesDelete,
            onPressed: onDelete,
            isDestructive: true,
            icon: Iconsax.trash,
          ),
        ],
      ),
    );
  }
}
