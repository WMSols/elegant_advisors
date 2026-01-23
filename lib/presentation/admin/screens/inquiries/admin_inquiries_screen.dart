import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/presentation/admin/controllers/inquiries/admin_inquiries_controller.dart';
import 'package:elegant_advisors/presentation/admin/widgets/layout/admin_layout.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_empty_state.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_icon_button.dart';
import 'package:elegant_advisors/presentation/admin/widgets/inquiries/filters/admin_inquiry_filters.dart';
import 'package:elegant_advisors/presentation/admin/widgets/inquiries/cards/admin_inquiry_card.dart';
import 'package:elegant_advisors/core/widgets/forms/app_search_field.dart';

class AdminInquiriesScreen extends GetView<AdminInquiriesController> {
  const AdminInquiriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      title: AppTexts.adminNavInquiries,
      child: Padding(
        padding: AppSpacing.all(context, factor: 1.2),
        child: Obx(() {
          if (controller.isLoading.value && controller.inquiries.isEmpty) {
            return const Center(
              child: AppLoadingIndicator(
                variant: LoadingIndicatorVariant.white,
              ),
            );
          }

          final filteredInquiries = controller.filteredInquiries;

          if (controller.inquiries.isEmpty) {
            return AppEmptyState(
              message: AppTexts.adminInquiriesNoInquiriesFound,
              messageColor: AppColors.white,
              showImage: false,
              centerContent: true,
            );
          }

          return Column(
            children: [
              // Search Field (Static)
              AppSearchField(
                controller: controller.searchController,
                hint: AppTexts.adminInquiriesSearchHint,
                onFieldSubmitted: controller.updateSearchQuery,
              ),
              AppSpacing.vertical(context, 0.02),
              // Scrollable Content: Filters, Button, and Cards
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Filters Section
                      const AdminInquiryFilters(),
                      AppSpacing.vertical(context, 0.02),
                      // Export Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppIconButton(
                          icon: Iconsax.document_download,
                          backgroundColor: AppColors.white,
                          onPressed: controller.exportInquiries,
                          tooltip: AppTexts.adminInquiriesExport,
                        ),
                      ),
                      AppSpacing.vertical(context, 0.02),
                      // Inquiries List
                      filteredInquiries.isEmpty
                          ? AppEmptyState(
                              message: AppTexts.adminInquiriesNoMatchFound,
                              messageColor: AppColors.white,
                              showImage: false,
                              centerContent: true,
                            )
                          : Column(
                              children: filteredInquiries.map((inquiry) {
                                final isDeleting = controller.isDeleting(
                                  inquiry.id ?? '',
                                );
                                return AdminInquiryCard(
                                  inquiry: inquiry,
                                  controller: controller,
                                  onReply: () =>
                                      controller.replyToInquiry(inquiry),
                                  onDelete: () {
                                    if (inquiry.id != null) {
                                      controller.deleteInquiry(inquiry.id!);
                                    }
                                  },
                                  isDeleting: isDeleting,
                                );
                              }).toList(),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
