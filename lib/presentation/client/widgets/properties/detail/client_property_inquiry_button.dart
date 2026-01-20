import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';

/// Inquiry button widget for property detail page
class ClientPropertyInquiryButton extends StatelessWidget {
  final String? propertyId;

  const ClientPropertyInquiryButton({super.key, this.propertyId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppButton(
        text: AppTexts.clientPropertyDetailInquire,
        onPressed: () {
          // Navigate to contact page with propertyId
          Get.toNamed(
            ClientConstants.routeClientContact,
            arguments: propertyId,
          );
        },
        width: AppResponsive.screenWidth(context) * 0.4,
        backgroundColor: AppColors.primary,
        textColor: AppColors.white,
      ),
    );
  }
}
