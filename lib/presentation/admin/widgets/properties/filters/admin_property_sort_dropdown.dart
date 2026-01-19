import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

/// Reusable sort dropdown widget for property management
class AdminPropertySortDropdown extends StatelessWidget {
  final String value;
  final void Function(String) onChanged;
  final List<String> options;
  final String label;

  const AdminPropertySortDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.options,
    required this.label,
  });

  String _getDisplayText(String option) {
    switch (option) {
      case 'title':
        return AppTexts.adminPropertiesSortByTitle;
      case 'createdAt':
        return AppTexts.adminPropertiesSortByCreatedDate;
      case 'updatedAt':
        return AppTexts.adminPropertiesSortByUpdatedDate;
      case 'price':
        return AppTexts.adminPropertiesSortByPrice;
      case 'status':
        return AppTexts.adminPropertiesSortByStatus;
      default:
        return option;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.bodyText(context),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        filled: true,
        fillColor: AppColors.white,
      ),
      style: AppTextStyles.bodyText(context).copyWith(color: AppColors.primary),
      items: options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(_getDisplayText(option)),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}
