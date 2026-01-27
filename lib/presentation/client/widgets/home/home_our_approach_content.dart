import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_images/app_images.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/core/widgets/images/app_error_image_fallback.dart';

class HomeOurApproachContentDesktop extends StatelessWidget {
  const HomeOurApproachContentDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: _OurApproachImage(
            height: AppResponsive.screenHeight(context) * 0.6,
            iconSize: 80,
          ),
        ),
        AppSpacing.horizontal(context, 0.04),
        Expanded(
          flex: 4,
          child: _OurApproachContent(
            onButtonPressed: () =>
                Get.toNamed(ClientConstants.routeClientProperties),
          ),
        ),
      ],
    );
  }
}

class HomeOurApproachContentMobile extends StatelessWidget {
  const HomeOurApproachContentMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _OurApproachImage(
          height: AppResponsive.screenHeight(context) * 0.4,
          iconSize: 60,
        ),
        AppSpacing.vertical(context, 0.04),
        _OurApproachContent(
          onButtonPressed: () =>
              Get.toNamed(ClientConstants.routeClientProperties),
          fullWidthButton: true,
        ),
      ],
    );
  }
}

class _OurApproachImage extends StatefulWidget {
  final double height;
  final double iconSize;

  const _OurApproachImage({required this.height, required this.iconSize});

  @override
  State<_OurApproachImage> createState() => _OurApproachImageState();
}

class _OurApproachImageState extends State<_OurApproachImage> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: double.infinity,
          height: widget.height,
          decoration: BoxDecoration(
            color: AppColors.grey.withValues(alpha: 0.1),
            border: Border.all(
              color: _isHovered ? AppColors.primary : Colors.transparent,
              width: 2,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 0),
                    ),
                  ]
                : null,
          ),
          child: ClipRRect(
            child: Image.asset(
              AppImages.homeOurApproachBanner,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return AppErrorImageFallback(iconSize: widget.iconSize);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _OurApproachContent extends StatelessWidget {
  final VoidCallback onButtonPressed;
  final bool fullWidthButton;

  const _OurApproachContent({
    required this.onButtonPressed,
    this.fullWidthButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.l10n.homeOurApproachTitle,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.primaryFont,
            fontSize: AppResponsive.fontSizeClamped(context, min: 26, max: 30),
          ),
          textAlign: TextAlign.left,
        ),
        AppSpacing.vertical(context, 0.04),
        Text(
          context.l10n.homeOurApproachDescription,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.black.withValues(alpha: 0.7),
            height: 1.6,
          ),
          textAlign: TextAlign.left,
        ),
        AppSpacing.vertical(context, 0.06),
        AppButton(
          text: context.l10n.homeOurApproachButton,
          backgroundColor: AppColors.primary,
          textColor: AppColors.white,
          width: fullWidthButton ? double.infinity : null,
          onPressed: onButtonPressed,
        ),
      ],
    );
  }
}
