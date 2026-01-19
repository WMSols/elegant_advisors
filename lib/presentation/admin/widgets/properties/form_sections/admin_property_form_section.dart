import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';

/// Collapsible form section widget for property form
class AdminPropertyFormSection extends StatefulWidget {
  final String title;
  final Widget child;
  final bool initiallyExpanded;

  const AdminPropertyFormSection({
    super.key,
    required this.title,
    required this.child,
    this.initiallyExpanded = false, // All sections collapsed by default
  });

  @override
  State<AdminPropertyFormSection> createState() =>
      _AdminPropertyFormSectionState();
}

class _AdminPropertyFormSectionState extends State<AdminPropertyFormSection> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primary.withValues(alpha: 0.1),
      margin: EdgeInsets.symmetric(
        vertical: AppResponsive.scaleSize(context, 8, min: 4, max: 12),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: AppSpacing.all(context, factor: 0.5),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: AppTextStyles.heading(context).copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    _isExpanded ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: AppSpacing.all(context, factor: 0.5),
              child: widget.child,
            ),
        ],
      ),
    );
  }
}
