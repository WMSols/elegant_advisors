import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/cards/client_property_card.dart';

/// Responsive grid layout for properties
class ClientPropertiesGrid extends StatelessWidget {
  final List<PropertyModel> properties;
  final Function(PropertyModel)? onPropertyTap;

  /// When true, cards show "Inquire" and navigate to contact (off-market inquire-only).
  final bool isInquireOnly;

  const ClientPropertiesGrid({
    super.key,
    required this.properties,
    this.onPropertyTap,
    this.isInquireOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    if (properties.isEmpty) {
      return const SizedBox.shrink();
    }

    final spacing = AppResponsive.scaleSize(context, 24, min: 16, max: 32);

    if (AppResponsive.isMobile(context)) {
      // Mobile: Single column with natural height
      return Column(
        children: properties.asMap().entries.map((entry) {
          final index = entry.key;
          final property = entry.value;
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < properties.length - 1 ? spacing : 0,
            ),
            child: ClientPropertyCard(
              property: property,
              index: index,
              onTap: onPropertyTap != null
                  ? () => onPropertyTap!(property)
                  : null,
              isInquireOnly: isInquireOnly,
            ),
          );
        }).toList(),
      );
    } else {
      // Desktop: Full width cards with alternating layout
      return Column(
        children: properties.asMap().entries.map((entry) {
          final index = entry.key;
          final property = entry.value;
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < properties.length - 1 ? spacing : 0,
            ),
            child: ClientPropertyCard(
              property: property,
              index: index,
              onTap: onPropertyTap != null
                  ? () => onPropertyTap!(property)
                  : null,
              isInquireOnly: isInquireOnly,
            ),
          );
        }).toList(),
      );
    }
  }
}
