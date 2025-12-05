import 'package:flutter/material.dart';
import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_spacing/app_spacing.dart';
import 'home_market_educated_content.dart';

class HomeMarketEducatedSection extends StatelessWidget {
  const HomeMarketEducatedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 768;

        return Container(
          width: double.infinity,
          color: AppColors.lightBeige,
          padding: AppSpacing.symmetric(context, h: 0.1, v: 0.08),
          child: isSmallScreen
              ? const HomeMarketEducatedContentMobile()
              : const HomeMarketEducatedContentDesktop(),
        );
      },
    );
  }
}

