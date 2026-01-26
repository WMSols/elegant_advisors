import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_helpers/app_helpers.dart';
import 'package:elegant_advisors/core/widgets/forms/app_dropdown_field.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_action_button.dart';
import 'package:elegant_advisors/domain/models/contact_submission_model.dart';
import 'package:elegant_advisors/presentation/admin/controllers/inquiries/admin_inquiries_controller.dart';
import 'package:elegant_advisors/presentation/admin/widgets/inquiries/detail_dialog/admin_inquiry_detail_dialog.dart';

/// Reusable inquiry card widget displaying inquiry information
class AdminInquiryCard extends StatelessWidget {
  final ContactSubmissionModel inquiry;
  final AdminInquiriesController controller;
  final VoidCallback onReply;
  final VoidCallback onDelete;
  final bool isDeleting;

  const AdminInquiryCard({
    super.key,
    required this.inquiry,
    required this.controller,
    required this.onReply,
    required this.onDelete,
    this.isDeleting = false,
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
    return InkWell(
      onTap: () {
        Get.dialog(
          AdminInquiryDetailDialog(
            inquiry: inquiry,
            onReply: () {
              Get.back();
              onReply();
            },
            onDelete: () {
              Get.back();
              onDelete();
            },
            onViewProperty: inquiry.propertyId != null
                ? () {
                    Get.back();
                    controller.viewProperty(inquiry.propertyId);
                  }
                : null,
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: AppResponsive.scaleSize(context, 8, min: 4, max: 12),
        ),
        color: AppColors.white,
        child: Padding(
          padding: AppSpacing.all(context, factor: 0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Inquiry Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          inquiry.name,
                          style: AppTextStyles.heading(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        AppSpacing.vertical(context, 0.003),
                        Text(
                          inquiry.email,
                          style: AppTextStyles.bodyText(
                            context,
                          ).copyWith(color: AppColors.primary),
                        ),
                        if (inquiry.phone.isNotEmpty)
                          Text(
                            inquiry.phone,
                            style: AppTextStyles.bodyText(
                              context,
                            ).copyWith(color: AppColors.primary),
                          ),
                        AppSpacing.vertical(context, 0.005),
                        // Status Badge
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
                            color: _getStatusColor(inquiry.status),
                            borderRadius: BorderRadius.circular(
                              AppResponsive.radius(context, factor: 3),
                            ),
                          ),
                          child: Text(
                            _getStatusLabel(inquiry.status),
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
                      ],
                    ),
                  ),
                  // Status Dropdown
                  SizedBox(
                    width: AppResponsive.scaleSize(
                      context,
                      140,
                      min: 120,
                      max: 160,
                    ),
                    child: AppDropdownField<String>(
                      value: inquiry.status,
                      items: [
                        DropdownMenuItem(
                          value: 'new',
                          child: Text(AppTexts.adminInquiriesStatusNew),
                        ),
                        DropdownMenuItem(
                          value: 'in_progress',
                          child: Text(AppTexts.adminInquiriesStatusInProgress),
                        ),
                        DropdownMenuItem(
                          value: 'closed',
                          child: Text(AppTexts.adminInquiriesStatusClosed),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null && inquiry.id != null) {
                          controller.updateInquiryStatus(inquiry.id!, value);
                        }
                      },
                      isAdmin: true,
                    ),
                  ),
                ],
              ),
              AppSpacing.vertical(context, 0.01),
              // Subject
              if (inquiry.subject.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppTexts.adminInquiryCardSubject,
                      style: AppTextStyles.bodyText(context).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    AppSpacing.vertical(context, 0.003),
                    Text(
                      inquiry.subject,
                      style: AppTextStyles.bodyText(context),
                    ),
                    AppSpacing.vertical(context, 0.01),
                  ],
                ),
              // Message
              if (inquiry.message.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppTexts.adminInquiryCardMessage,
                      style: AppTextStyles.bodyText(context).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    AppSpacing.vertical(context, 0.003),
                    Text(
                      inquiry.message,
                      style: AppTextStyles.bodyText(context),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppSpacing.vertical(context, 0.01),
                  ],
                ),
              // Property (if available)
              if (inquiry.propertyId != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Iconsax.home,
                          size: AppResponsive.scaleSize(
                            context,
                            14,
                            min: 12,
                            max: 16,
                          ),
                          color: AppColors.primary,
                        ),
                        AppSpacing.horizontal(context, 0.005),
                        Expanded(
                          child: Obx(() {
                            final propertyName = controller.getPropertyName(
                              inquiry.propertyId,
                            );
                            return Text(
                              propertyName ?? inquiry.propertyId ?? '',
                              style: AppTextStyles.bodyText(context).copyWith(
                                color: AppColors.primary,
                                fontSize: AppResponsive.fontSizeClamped(
                                  context,
                                  min: 12,
                                  max: 14,
                                ),
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                    AppSpacing.vertical(context, 0.01),
                  ],
                ),
              // Created Date
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
                      '${AppTexts.adminInquiryCardCreated} ${AppHelpers.formatDateTime(inquiry.createdAt)}',
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
              AppSpacing.vertical(context, 0.01),
              // Action Buttons
              if (isDeleting)
                Padding(
                  padding: EdgeInsets.all(
                    AppResponsive.scaleSize(context, 8, min: 6, max: 12),
                  ),
                  child: AppLoadingIndicator(
                    variant: LoadingIndicatorVariant.primary,
                    size: AppResponsive.scaleSize(
                      context,
                      20,
                      min: 16,
                      max: 24,
                    ),
                  ),
                )
              else
                Wrap(
                  spacing: AppResponsive.scaleSize(context, 8, min: 6, max: 12),
                  runSpacing: AppResponsive.scaleSize(
                    context,
                    4,
                    min: 2,
                    max: 6,
                  ),
                  children: [
                    AppActionButton(
                      label: AppTexts.adminInquiriesViewDetails,
                      onPressed: () {
                        Get.dialog(
                          AdminInquiryDetailDialog(
                            inquiry: inquiry,
                            onReply: () {
                              Get.back();
                              onReply();
                            },
                            onDelete: () {
                              Get.back();
                              onDelete();
                            },
                            onViewProperty: inquiry.propertyId != null
                                ? () {
                                    Get.back();
                                    controller.viewProperty(inquiry.propertyId);
                                  }
                                : null,
                          ),
                        );
                      },
                      backgroundColor: AppColors.primary,
                      icon: Iconsax.eye,
                    ),
                    AppActionButton(
                      label: AppTexts.adminInquiriesReply,
                      onPressed: onReply,
                      backgroundColor: AppColors.information,
                      icon: Iconsax.message,
                    ),
                    if (inquiry.propertyId != null)
                      AppActionButton(
                        label: AppTexts.adminInquiriesViewProperty,
                        onPressed: () =>
                            controller.viewProperty(inquiry.propertyId),
                        backgroundColor: AppColors.primary,
                        icon: Iconsax.home,
                      ),
                    AppActionButton(
                      label: AppTexts.adminInquiriesDelete,
                      onPressed: onDelete,
                      backgroundColor: AppColors.error,
                      icon: Iconsax.trash,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
