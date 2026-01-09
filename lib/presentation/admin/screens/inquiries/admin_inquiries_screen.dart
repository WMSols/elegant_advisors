import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/presentation/admin/controllers/inquiries/admin_inquiries_controller.dart';
import 'package:elegant_advisors/presentation/admin/widgets/layout/admin_layout.dart';
import 'package:elegant_advisors/core/widgets/app_loading_indicator.dart';
import 'package:elegant_advisors/core/widgets/app_button.dart';

class AdminInquiriesScreen extends GetView<AdminInquiriesController> {
  const AdminInquiriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      title: AppTexts.adminNavInquiries,
      child: Column(
        children: [
          // Filters
          Container(
            padding: EdgeInsets.all(
              AppResponsive.scaleSize(context, 16, min: 12, max: 20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                    () => DropdownButton<String>(
                      value: controller.selectedStatus.value,
                      items: const [
                        DropdownMenuItem(
                          value: 'all',
                          child: Text('All Status'),
                        ),
                        DropdownMenuItem(value: 'new', child: Text('New')),
                        DropdownMenuItem(
                          value: 'in_progress',
                          child: Text('In Progress'),
                        ),
                        DropdownMenuItem(
                          value: 'closed',
                          child: Text('Closed'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) controller.filterByStatus(value);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: AppResponsive.scaleSize(context, 16, min: 12, max: 20),
                ),
                Expanded(
                  child: AppButton(
                    text: 'Clear Filters',
                    onPressed: controller.clearFilters,
                    backgroundColor: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: AppResponsive.scaleSize(context, 16, min: 12, max: 20),
                ),
                IconButton(
                  icon: const Icon(Iconsax.document_download),
                  onPressed: controller.exportInquiries,
                  tooltip: 'Export Inquiries',
                ),
              ],
            ),
          ),
          // Inquiries List
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppResponsive.scaleSize(
                  context,
                  16,
                  min: 12,
                  max: 20,
                ),
              ),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: AppLoadingIndicator());
                }

                if (controller.inquiries.isEmpty) {
                  return const Center(child: Text('No inquiries found'));
                }

                return ListView.builder(
                  itemCount: controller.inquiries.length,
                  itemBuilder: (context, index) {
                    final inquiry = controller.inquiries[index];
                    return Card(
                      margin: EdgeInsets.symmetric(
                        vertical: AppResponsive.scaleSize(
                          context,
                          8,
                          min: 4,
                          max: 12,
                        ),
                      ),
                      child: ListTile(
                        title: Text(inquiry.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email: ${inquiry.email}'),
                            Text('Subject: ${inquiry.subject}'),
                            Text('Status: ${inquiry.status}'),
                            if (inquiry.propertyId != null)
                              Text('Property ID: ${inquiry.propertyId}'),
                            Text(
                              'Date: ${inquiry.createdAt.toLocal().toString()}',
                            ),
                          ],
                        ),
                        trailing: DropdownButton<String>(
                          value: inquiry.status,
                          items: const [
                            DropdownMenuItem(value: 'new', child: Text('New')),
                            DropdownMenuItem(
                              value: 'in_progress',
                              child: Text('In Progress'),
                            ),
                            DropdownMenuItem(
                              value: 'closed',
                              child: Text('Closed'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null && inquiry.id != null) {
                              controller.updateInquiryStatus(
                                inquiry.id!,
                                value,
                              );
                            }
                          },
                        ),
                        isThreeLine: true,
                        onTap: () {
                          // TODO: Show inquiry details dialog
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
