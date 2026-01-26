import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';

/// Bedrooms filter field (Min/Max)
class ClientPropertyFilterBedrooms extends StatelessWidget {
  final int? minBedrooms;
  final int? maxBedrooms;
  final Function(int?) onMinBedroomsChanged;
  final Function(int?) onMaxBedroomsChanged;

  const ClientPropertyFilterBedrooms({
    super.key,
    required this.minBedrooms,
    required this.maxBedrooms,
    required this.onMinBedroomsChanged,
    required this.onMaxBedroomsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: '${context.l10n.clientPropertiesFilterBedrooms} (Min)',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final bedrooms = int.tryParse(value);
              onMinBedroomsChanged(bedrooms);
            },
          ),
        ),
        AppSpacing.horizontal(context, 0.02),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: '${context.l10n.clientPropertiesFilterBedrooms} (Max)',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final bedrooms = int.tryParse(value);
              onMaxBedroomsChanged(bedrooms);
            },
          ),
        ),
      ],
    );
  }
}
