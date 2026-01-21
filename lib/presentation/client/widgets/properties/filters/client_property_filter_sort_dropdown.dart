import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/client_property_filters.dart';
import 'package:elegant_advisors/core/widgets/forms/app_dropdown_field.dart';

/// Sort dropdown filter field
class ClientPropertyFilterSortDropdown extends StatelessWidget {
  final PropertySortOption? value;
  final Function(PropertySortOption?) onChanged;

  const ClientPropertyFilterSortDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppDropdownField<PropertySortOption>(
      label: AppTexts.clientPropertiesSortBy,
      value: value,
      items: [
        DropdownMenuItem<PropertySortOption>(
          value: null,
          child: Text(AppTexts.clientPropertiesFilterAll),
        ),
        ...PropertySortOption.values.map((option) {
          return DropdownMenuItem<PropertySortOption>(
            value: option,
            child: Text(option.displayName),
          );
        }),
      ],
      onChanged: onChanged,
      borderColor: AppColors.primary.withValues(alpha: 0.5),
    );
  }
}
