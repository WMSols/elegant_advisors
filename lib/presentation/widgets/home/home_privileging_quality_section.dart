import 'package:flutter/material.dart';
import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_spacing/app_spacing.dart';
import '../common/app_fade_in_on_scroll.dart';
import 'home_privileging_quality_content.dart';

class HomePrivilegingQualitySection extends StatelessWidget {
  const HomePrivilegingQualitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 768;

        return Container(
          width: double.infinity,
          color: AppColors.lightBeige,
          padding: AppSpacing.symmetric(context, h: 0.1, v: 0.08),
          child: AppFadeInOnScroll(
            child: isSmallScreen
                ? const HomePrivilegingQualityContentMobile()
                : const HomePrivilegingQualityContentDesktop(),
          ),
        );
      },
    );
  }
}

