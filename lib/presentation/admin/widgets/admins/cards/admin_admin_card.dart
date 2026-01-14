import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_helpers/app_helpers.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_icon_button.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';
import 'package:elegant_advisors/domain/models/admin_user_model.dart';

/// Reusable admin card widget displaying admin information
class AdminAdminCard extends StatelessWidget {
  final AdminUserModel admin;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isDeleting;

  const AdminAdminCard({
    super.key,
    required this.admin,
    required this.onEdit,
    required this.onDelete,
    this.isDeleting = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: AppResponsive.scaleSize(context, 8, min: 4, max: 12),
      ),
      color: AppColors.white,
      child: Padding(
        padding: AppSpacing.all(context, factor: 0.5),
        child: Row(
          children: [
            // Admin Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    admin.name,
                    style: AppTextStyles.heading(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    admin.email,
                    style: AppTextStyles.bodyText(
                      context,
                    ).copyWith(color: AppColors.primary),
                  ),
                  AppSpacing.vertical(context, 0.005),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppResponsive.scaleSize(
                        context,
                        8,
                        min: 6,
                        max: 12,
                      ),
                      vertical: AppResponsive.scaleSize(
                        context,
                        4,
                        min: 2,
                        max: 6,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(
                        AppResponsive.radius(context, factor: 3),
                      ),
                    ),
                    child: Text(
                      AppTexts.adminManageAdminsRole,
                      style: AppTextStyles.heading(context).copyWith(
                        color: AppColors.white,
                        fontSize: AppResponsive.fontSizeClamped(
                          context,
                          min: 10,
                          max: 12,
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.vertical(context, 0.005),
                  Row(
                    children: [
                      Icon(
                        Iconsax.calendar,
                        size: AppResponsive.scaleSize(
                          context,
                          14,
                          min: 12,
                          max: 16,
                        ),
                        color: AppColors.primary,
                      ),
                      AppSpacing.horizontal(context, 0.005),
                      Flexible(
                        child: Text(
                          'Created ${AppHelpers.formatDateTime(admin.createdAt)}',
                          style: AppTextStyles.bodyText(context).copyWith(
                            color: AppColors.primary,
                            fontSize: AppResponsive.fontSizeClamped(
                              context,
                              min: 11,
                              max: 13,
                            ),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Actions
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIconButton(
                  icon: Iconsax.edit,
                  onPressed: isDeleting ? null : onEdit,
                  tooltip: AppTexts.adminManageAdminsEdit,
                ),
                isDeleting
                    ? Padding(
                        padding: EdgeInsets.all(
                          AppResponsive.scaleSize(context, 8, min: 6, max: 12),
                        ),
                        child: AppLoadingIndicator(
                          variant: LoadingIndicatorVariant.primary,
                          size: AppResponsive.scaleSize(
                            context,
                            24,
                            min: 20,
                            max: 28,
                          ),
                        ),
                      )
                    : AppIconButton(
                        icon: Iconsax.trash,
                        onPressed: onDelete,
                        tooltip: AppTexts.adminManageAdminsDelete,
                        color: AppColors.error,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
