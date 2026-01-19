import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/widgets/animations/app_fade_in_on_scroll.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/filters/properties_filters_content.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_properties_controller.dart';

/// Properties filters and sort section
class PropertiesFiltersSection extends StatelessWidget {
  final ClientPropertiesController controller;

  const PropertiesFiltersSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.symmetric(context, h: 0.1, v: 0.06),
      child: AppFadeInOnScroll(
        child: PropertiesFiltersContent(controller: controller),
      ),
    );
  }
}
