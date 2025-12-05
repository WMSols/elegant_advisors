import 'package:flutter/material.dart';
import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_images/app_images.dart';
import '../../../core/utils/app_responsive/app_responsive.dart';
import 'home_top_content.dart';

class HomeTopSection extends StatelessWidget {
  const HomeTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppResponsive.screenHeight(context),
      decoration: BoxDecoration(
        color: AppColors.primary, // Fallback color
        image: const DecorationImage(
          image: AssetImage(AppImages.homeBackground),
          fit: BoxFit.cover,
          onError: null,
        ),
      ),
      child: Stack(
        children: [
          // Content (responsive alignment)
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isSmallScreen = constraints.maxWidth < 600;
                final headerHeight =
                    AppResponsive.screenHeight(context) * 0.08;

                return Padding(
                  padding: EdgeInsets.only(
                    top: headerHeight,
                    left: isSmallScreen
                        ? AppResponsive.screenWidth(context) * 0.05
                        : AppResponsive.screenWidth(context) * 0.1,
                    right: isSmallScreen
                        ? AppResponsive.screenWidth(context) * 0.05
                        : AppResponsive.screenWidth(context) * 0.1,
                    bottom: AppResponsive.screenHeight(context) * 0.05,
                  ),
                  child: isSmallScreen
                      ? const HomeTopContentSmall()
                      : const HomeTopContentLarge(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

