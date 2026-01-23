import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_helpers/app_helpers.dart';
import 'package:elegant_advisors/domain/models/contact_submission_model.dart';
import 'package:elegant_advisors/presentation/admin/widgets/inquiries/detail_dialog/admin_inquiry_detail_section.dart';
import 'package:elegant_advisors/presentation/admin/controllers/inquiries/admin_inquiries_controller.dart';

/// Content section for inquiry detail dialog
class AdminInquiryDetailContent extends StatelessWidget {
  final ContactSubmissionModel inquiry;

  const AdminInquiryDetailContent({super.key, required this.inquiry});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.all(context, factor: 0.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contact Information
          AdminInquiryDetailSection(
            label: AppTexts.adminInquiryDetailName,
            icon: Iconsax.user,
            value: inquiry.name,
          ),
          AppSpacing.vertical(context, 0.02),
          AdminInquiryDetailSection(
            label: AppTexts.adminInquiryDetailEmail,
            icon: Iconsax.sms,
            value: inquiry.email,
          ),
          if (inquiry.phone.isNotEmpty) ...[
            AppSpacing.vertical(context, 0.02),
            AdminInquiryDetailSection(
              label: AppTexts.adminInquiryDetailPhone,
              icon: Iconsax.call,
              value: inquiry.phone,
            ),
          ],
          AppSpacing.vertical(context, 0.02),
          // Subject
          AdminInquiryDetailSection(
            label: AppTexts.adminInquiryCardSubject,
            icon: Iconsax.document_text,
            value: inquiry.subject,
          ),
          AppSpacing.vertical(context, 0.02),
          // Message
          AdminInquiryDetailSection(
            label: AppTexts.adminInquiryCardMessage,
            icon: Iconsax.document,
            value: inquiry.message,
          ),
          AppSpacing.vertical(context, 0.02),
          // Property (if available)
          if (inquiry.propertyId != null)
            GetBuilder<AdminInquiriesController>(
              builder: (controller) {
                final propertyName = controller.getPropertyName(
                  inquiry.propertyId,
                );
                return AdminInquiryDetailSection(
                  label: AppTexts.adminInquiryCardProperty,
                  icon: Iconsax.home,
                  value: propertyName ?? inquiry.propertyId ?? '',
                );
              },
            ),
          if (inquiry.propertyId != null) AppSpacing.vertical(context, 0.02),
          // IP Address (if available)
          if (inquiry.ipAddress != null)
            AdminInquiryDetailSection(
              label: AppTexts.adminInquiryDetailIpAddress,
              icon: Iconsax.global,
              value: inquiry.ipAddress ?? '',
            ),
          if (inquiry.ipAddress != null) AppSpacing.vertical(context, 0.02),
          // Created Date
          AdminInquiryDetailSection(
            label: AppTexts.adminInquiryCardCreated,
            icon: Iconsax.calendar,
            value: AppHelpers.formatDateTime(inquiry.createdAt),
          ),
        ],
      ),
    );
  }
}
