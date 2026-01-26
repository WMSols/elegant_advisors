import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';

/// Featured only filter checkbox
class ClientPropertyFilterFeatured extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;

  const ClientPropertyFilterFeatured({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        context.l10n.clientPropertiesFilterFeatured,
        style: AppTextStyles.bodyText(context).copyWith(
          fontWeight: FontWeight.w600,
          fontFamily: AppFonts.primaryFont,
          color: AppColors.primary,
        ),
      ),
      value: value,
      onChanged: (newValue) => onChanged(newValue ?? false),
      contentPadding: EdgeInsets.zero,
    );
  }
}
