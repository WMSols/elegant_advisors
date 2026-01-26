import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';

/// Status filter chips
class ClientPropertyFilterStatusChips extends StatelessWidget {
  final List<String> selectedStatuses;
  final Function(String, bool) onStatusToggled;

  const ClientPropertyFilterStatusChips({
    super.key,
    required this.selectedStatuses,
    required this.onStatusToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.clientPropertiesFilterStatus,
          style: AppTextStyles.bodyText(context).copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.primaryFont,
            color: AppColors.primary,
          ),
        ),
        AppSpacing.vertical(context, 0.01),
        Wrap(
          spacing: AppResponsive.scaleSize(context, 12, min: 8, max: 16),
          children: ['available', 'sold', 'coming_soon', 'off_market'].map((
            status,
          ) {
            final isSelected = selectedStatuses.contains(status);
            return FilterChip(
              label: Text(status.replaceAll('_', ' ').toUpperCase()),
              selected: isSelected,
              onSelected: (selected) {
                onStatusToggled(status, selected);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
