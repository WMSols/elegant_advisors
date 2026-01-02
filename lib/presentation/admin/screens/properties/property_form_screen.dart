import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/admin/controllers/properties/property_form_controller.dart';

class PropertyFormScreen extends GetView<PropertyFormController> {
  const PropertyFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.isEditMode.value ? 'Edit Property' : 'Add Property',
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.isEditMode.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TODO: Implement property form
              // - Title field
              // - Slug field (auto-generated from title)
              // - Description fields
              // - Location fields
              // - Price fields
              // - Specs fields
              // - Features list
              // - Status dropdown
              // - Image upload
              // - Featured toggle
              // - Publish toggle
              const Text('Property Form - To be implemented'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // TODO: Validate and save property
                },
                child: const Text('Save Property'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
