import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/presentation/client/controllers/contact/my_contacts/client_my_contacts_controller.dart';

/// Filter chips widget for filtering my contacts by status
class ClientMyContactsFilterChips extends StatelessWidget {
  const ClientMyContactsFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClientMyContactsController>();

    return Obx(
      () => Wrap(
        spacing: AppResponsive.scaleSize(context, 8, min: 6, max: 12),
        runSpacing: AppResponsive.scaleSize(context, 8, min: 6, max: 12),
        children: [
          _buildFilterChip(
            context,
            controller,
            label: AppTexts.myContactsFilterAll,
            value: 'all',
            isSelected: controller.selectedStatus.value == 'all',
          ),
          _buildFilterChip(
            context,
            controller,
            label: AppTexts.myContactsFilterNew,
            value: 'new',
            isSelected: controller.selectedStatus.value == 'new',
          ),
          _buildFilterChip(
            context,
            controller,
            label: AppTexts.myContactsFilterInProgress,
            value: 'in_progress',
            isSelected: controller.selectedStatus.value == 'in_progress',
          ),
          _buildFilterChip(
            context,
            controller,
            label: AppTexts.myContactsFilterClosed,
            value: 'closed',
            isSelected: controller.selectedStatus.value == 'closed',
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    ClientMyContactsController controller, {
    required String label,
    required String value,
    required bool isSelected,
  }) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          controller.filterByStatus(value);
        }
      },
      selectedColor: AppColors.primary,
      checkmarkColor: AppColors.white,
      labelStyle: AppTextStyles.bodyText(context).copyWith(
        color: isSelected ? AppColors.white : AppColors.black,
        fontSize: AppResponsive.fontSizeClamped(
          context,
          min: 12,
          max: 14,
        ),
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppResponsive.scaleSize(context, 12, min: 8, max: 16),
        vertical: AppResponsive.scaleSize(context, 8, min: 6, max: 10),
      ),
      side: BorderSide(
        color: isSelected ? AppColors.primary : AppColors.grey.withValues(alpha: 0.3),
        width: 1,
      ),
    );
  }
}
