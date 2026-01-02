import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/admin/controllers/inquiries/inquiries_controller.dart';

class AdminInquiriesScreen extends GetView<AdminInquiriesController> {
  const AdminInquiriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inquiries Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: controller.exportInquiries,
            tooltip: 'Export Inquiries',
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: controller.selectedStatus.value,
                    items: const [
                      DropdownMenuItem(value: 'all', child: Text('All Status')),
                      DropdownMenuItem(value: 'new', child: Text('New')),
                      DropdownMenuItem(
                        value: 'in_progress',
                        child: Text('In Progress'),
                      ),
                      DropdownMenuItem(value: 'closed', child: Text('Closed')),
                    ],
                    onChanged: (value) {
                      if (value != null) controller.filterByStatus(value);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextButton(
                    onPressed: controller.clearFilters,
                    child: const Text('Clear Filters'),
                  ),
                ),
              ],
            ),
          ),
          // Inquiries List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.inquiries.isEmpty) {
                return const Center(child: Text('No inquiries found'));
              }

              return ListView.builder(
                itemCount: controller.inquiries.length,
                itemBuilder: (context, index) {
                  final inquiry = controller.inquiries[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
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
                            controller.updateInquiryStatus(inquiry.id!, value);
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
        ],
      ),
    );
  }
}
