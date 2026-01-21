import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_images/app_images.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';

/// Reusable hero header section with background image
/// Used for page headers with full-screen background
class ClientHeroHeaderSection extends StatelessWidget {
  final Widget child;
  final String? backgroundImage;
  final double? height;
  final EdgeInsets? customPadding;

  const ClientHeroHeaderSection({
    super.key,
    required this.child,
    this.backgroundImage,
    this.height,
    this.customPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? AppResponsive.screenHeight(context),
      decoration: BoxDecoration(
        color: AppColors.primary, // Fallback color
        image: DecorationImage(
          image: AssetImage(
            backgroundImage ?? AppImages.homeBackground,
          ),
          fit: BoxFit.cover,
          onError: null,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 600;
          final headerHeight = AppResponsive.screenHeight(context) * 0.08;

          return Padding(
            padding: customPadding ??
                EdgeInsets.only(
                  top: headerHeight,
                  left: isSmallScreen
                      ? AppResponsive.screenWidth(context) * 0.05
                      : AppResponsive.screenWidth(context) * 0.1,
                  right: isSmallScreen
                      ? AppResponsive.screenWidth(context) * 0.05
                      : AppResponsive.screenWidth(context) * 0.1,
                  bottom: AppResponsive.screenHeight(context) * 0.05,
                ),
            child: Center(child: child),
          );
        },
      ),
    );
  }
}
