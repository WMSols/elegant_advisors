import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/core/widgets/forms/app_dropdown_field.dart';

/// Property type filter dropdown
class ClientPropertyFilterPropertyType extends StatelessWidget {
  final String? value;
  final List<String> availableTypes;
  final Function(String?) onChanged;

  const ClientPropertyFilterPropertyType({
    super.key,
    required this.value,
    required this.availableTypes,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (availableTypes.isEmpty) {
      return const SizedBox.shrink();
    }

    return AppDropdownField<String>(
      label: context.l10n.clientPropertiesFilterPropertyType,
      value: value,
      items: [
        DropdownMenuItem<String>(
          value: null,
          child: Text(context.l10n.clientPropertiesFilterAll),
        ),
        ...availableTypes.map((type) {
          return DropdownMenuItem<String>(value: type, child: Text(type));
        }),
      ],
      onChanged: onChanged,
      borderColor: AppColors.primary.withValues(alpha: 0.5),
    );
  }
}
