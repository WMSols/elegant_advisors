import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/property_detail_controller.dart';
import 'package:elegant_advisors/presentation/client/widgets/layout/app_header.dart';
import 'package:elegant_advisors/presentation/client/widgets/layout/app_footer.dart';

class PropertyDetailScreen extends GetView<PropertyDetailController> {
  const PropertyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.property.value == null) {
          return const Center(child: Text('Property not found'));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              const AppHeader(),
              // TODO: Implement property detail UI
              // - Image gallery/slider
              // - Property specifications
              // - Description
              // - Features
              // - Location map
              // - Inquiry CTA
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.property.value!.title,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      controller.property.value!.shortDescription,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    // Image gallery placeholder
                    Container(
                      height: 400,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Text('Image Gallery - To be implemented'),
                      ),
                    ),
                    // Property specs placeholder
                    const SizedBox(height: 16),
                    const Text('Property Specifications - To be implemented'),
                    // Inquiry CTA placeholder
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: controller.openInquiryForm,
                      child: const Text('Inquire About This Property'),
                    ),
                  ],
                ),
              ),
              const AppFooter(),
            ],
          ),
        );
      }),
    );
  }
}
