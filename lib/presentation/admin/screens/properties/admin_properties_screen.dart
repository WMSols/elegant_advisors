import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/presentation/admin/controllers/properties/admin_properties_controller.dart';
import 'package:elegant_advisors/presentation/admin/widgets/layout/admin_layout.dart';
import 'package:elegant_advisors/core/widgets/app_loading_indicator.dart';
import 'package:elegant_advisors/core/widgets/app_button.dart';

class AdminPropertiesScreen extends GetView<AdminPropertiesController> {
  const AdminPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      title: AppTexts.adminNavProperties,
      child: Padding(
        padding: EdgeInsets.all(
          AppResponsive.scaleSize(context, 24, min: 16, max: 32),
        ),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: AppLoadingIndicator(
                variant: LoadingIndicatorVariant.white,
              ),
            );
          }

          if (controller.properties.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No properties found',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: AppResponsive.scaleSize(
                      context,
                      16,
                      min: 12,
                      max: 20,
                    ),
                  ),
                  AppButton(
                    text: 'Add First Property',
                    onPressed: controller.navigateToAddProperty,
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Add Property Button
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: AppResponsive.scaleSize(
                      context,
                      16,
                      min: 12,
                      max: 20,
                    ),
                  ),
                  child: AppButton(
                    text: 'Add Property',
                    onPressed: controller.navigateToAddProperty,
                  ),
                ),
              ),
              // Properties List
              Expanded(
                child: ListView.builder(
                  itemCount: controller.properties.length,
                  itemBuilder: (context, index) {
                    final property = controller.properties[index];
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
                        title: Text(property.title),
                        subtitle: Text('Status: ${property.status}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                property.isPublished
                                    ? Iconsax.eye
                                    : Iconsax.eye_slash,
                              ),
                              onPressed: () => controller.togglePropertyStatus(
                                property.id!,
                                property.isPublished,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Iconsax.edit),
                              onPressed: () => controller
                                  .navigateToEditProperty(property.id!),
                            ),
                            IconButton(
                              icon: const Icon(Iconsax.trash),
                              onPressed: () =>
                                  controller.deleteProperty(property.id!),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
