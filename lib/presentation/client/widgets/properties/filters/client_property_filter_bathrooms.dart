import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';

/// Bathrooms filter field (Min/Max)
class ClientPropertyFilterBathrooms extends StatelessWidget {
  final int? minBathrooms;
  final int? maxBathrooms;
  final Function(int?) onMinBathroomsChanged;
  final Function(int?) onMaxBathroomsChanged;

  const ClientPropertyFilterBathrooms({
    super.key,
    required this.minBathrooms,
    required this.maxBathrooms,
    required this.onMinBathroomsChanged,
    required this.onMaxBathroomsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText:
                  '${context.l10n.clientPropertiesFilterBathrooms} (Min)',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final bathrooms = int.tryParse(value);
              onMinBathroomsChanged(bathrooms);
            },
          ),
        ),
        AppSpacing.horizontal(context, 0.02),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText:
                  '${context.l10n.clientPropertiesFilterBathrooms} (Max)',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final bathrooms = int.tryParse(value);
              onMaxBathroomsChanged(bathrooms);
            },
          ),
        ),
      ],
    );
  }
}
