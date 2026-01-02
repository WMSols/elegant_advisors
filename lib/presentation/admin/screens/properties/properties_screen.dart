import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/admin/controllers/properties/properties_controller.dart';

class AdminPropertiesScreen extends GetView<AdminPropertiesController> {
  const AdminPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Properties Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: controller.navigateToAddProperty,
            tooltip: 'Add Property',
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.properties.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('No properties found'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.navigateToAddProperty,
                  child: const Text('Add First Property'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.properties.length,
          itemBuilder: (context, index) {
            final property = controller.properties[index];
            return ListTile(
              title: Text(property.title),
              subtitle: Text('Status: ${property.status}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      property.isPublished
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () => controller.togglePropertyStatus(
                      property.id!,
                      property.isPublished,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () =>
                        controller.navigateToEditProperty(property.id!),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => controller.deleteProperty(property.id!),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
