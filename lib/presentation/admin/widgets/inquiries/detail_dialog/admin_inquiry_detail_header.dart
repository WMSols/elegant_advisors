import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_action_button.dart';
import 'package:elegant_advisors/domain/models/contact_submission_model.dart';

/// Header section for inquiry detail dialog with action buttons
class AdminInquiryDetailHeader extends StatelessWidget {
  final ContactSubmissionModel inquiry;
  final VoidCallback onReply;
  final VoidCallback onDelete;
  final VoidCallback? onViewProperty;

  const AdminInquiryDetailHeader({
    super.key,
    required this.inquiry,
    required this.onReply,
    required this.onDelete,
    this.onViewProperty,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'new':
        return AppColors.information;
      case 'in_progress':
        return AppColors.warning;
      case 'closed':
        return AppColors.success;
      default:
        return AppColors.primary;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'new':
        return AppTexts.adminInquiriesStatusNew;
      case 'in_progress':
        return AppTexts.adminInquiriesStatusInProgress;
      case 'closed':
        return AppTexts.adminInquiriesStatusClosed;
      default:
        return status;
    }
  }

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      inquiry.name,
                      style: AppTextStyles.heading(
                        context,
                      ).copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppSpacing.vertical(context, 0.005),
                    Text(
                      inquiry.email,
                      style: AppTextStyles.bodyText(
                        context,
                      ).copyWith(color: AppColors.white.withValues(alpha: 0.9)),
                    ),
                  ],
                ),
              ),
              AppSpacing.horizontal(context, 0.02),
              // Status Badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppResponsive.scaleSize(
                    context,
                    12,
                    min: 8,
                    max: 16,
                  ),
                  vertical: AppResponsive.scaleSize(
                    context,
                    6,
                    min: 4,
                    max: 8,
                  ),
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(inquiry.status),
                  borderRadius: BorderRadius.circular(
                    AppResponsive.radius(context, factor: 3),
                  ),
                ),
                child: Text(
                  _getStatusLabel(inquiry.status),
                  style: AppTextStyles.bodyText(context).copyWith(
                    color: AppColors.white,
                    fontSize: AppResponsive.fontSizeClamped(
                      context,
                      min: 12,
                      max: 14,
                    ),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.vertical(context, 0.02),
          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppActionButton(
                label: AppTexts.adminInquiriesReply,
                onPressed: onReply,
                backgroundColor: AppColors.information,
                icon: Iconsax.message,
              ),
              if (onViewProperty != null) ...[
                AppSpacing.horizontal(context, 0.01),
                AppActionButton(
                  label: AppTexts.adminInquiriesViewProperty,
                  onPressed: onViewProperty!,
                  backgroundColor: AppColors.primary,
                  icon: Iconsax.home,
                ),
              ],
              AppSpacing.horizontal(context, 0.01),
              AppActionButton(
                label: AppTexts.adminInquiriesDelete,
                onPressed: onDelete,
                isDestructive: true,
                icon: Iconsax.trash,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
