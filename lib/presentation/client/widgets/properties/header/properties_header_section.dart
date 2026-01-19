import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_images/app_images.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/header/properties_header_content.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_properties_controller.dart';

/// Properties page header section
class PropertiesHeaderSection extends StatelessWidget {
  final ClientPropertiesController controller;
  
  const PropertiesHeaderSection({
    super.key,
    required this.controller,
  });

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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 600;
          final headerHeight = AppResponsive.screenHeight(context) * 0.08;

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
            child: Center(
              child: PropertiesHeaderContent(
                onButtonPressed: () => controller.scrollToListing(),
              ),
            ),
          );
        },
      ),
    );
  }
}
