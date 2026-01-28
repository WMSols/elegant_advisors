import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/presentation/client/controllers/faq/faq_chat_controller.dart';

/// Elegant chat-style FAQ widget: collapsed bubble bottom-left,
/// expanded card with preview questions + "View full FAQ page" button.
/// Auto-collapses on route change.
class FaqChatWidget extends StatelessWidget {
  const FaqChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<FaqChatController>()) {
      Get.put(FaqChatController(), permanent: true);
    }
    final controller = Get.find<FaqChatController>();
    // Defer route check to after build to avoid setState/markNeedsBuild during build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.onRouteMaybeChanged(Get.currentRoute);
    });

    return Positioned(
      bottom: AppResponsive.screenHeight(context) * 0.03,
      left: AppResponsive.screenWidth(context) * 0.03,
      child: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (controller.expanded.value)
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 1, end: 0),
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                builder: (_, value, child) => SlideTransition(
                  position: AlwaysStoppedAnimation(Offset(0, value)),
                  child: child,
                ),
                child: _ExpandedCard(onClose: controller.collapse),
              ),
            AppSpacing.vertical(context, 0.008),
            _BubbleButton(
              onTap: controller.toggle,
              tooltip: context.l10n.faqChatTooltip,
            ),
          ],
        );
      }),
    );
  }
}

class _ExpandedCard extends StatelessWidget {
  final VoidCallback onClose;

  const _ExpandedCard({required this.onClose});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final previewQuestions = [
      l10n.faq1Question,
      l10n.faq2Question,
      l10n.faq3Question,
      l10n.faq4Question,
      l10n.faq5Question,
    ];

    final padding = AppResponsive.screenWidth(context) * 0.02;
    final maxHeight = AppResponsive.screenHeight(context) * 0.75;
    final questionSpacing = AppResponsive.screenHeight(context) * 0.012;

    return Material(
      elevation: 12,
      shadowColor: AppColors.black.withValues(alpha: 0.25),
      borderRadius: BorderRadius.circular(12),
      color: AppColors.primary,
      child: Container(
        width: AppResponsive.scaleSize(context, 360, min: 320, max: 380),
        constraints: BoxConstraints(maxHeight: maxHeight),
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    l10n.faqCardTitle,
                    style: AppTextStyles.bodyText(context).copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.primaryFont,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onClose,
                  icon: const Icon(Iconsax.close_circle),
                  color: AppColors.white,
                  iconSize: AppResponsive.iconSize(context, factor: 0.3),
                ),
              ],
            ),
            AppSpacing.vertical(context, 0.015),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxHeight * 0.55),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final q in previewQuestions)
                      Padding(
                        padding: EdgeInsets.only(bottom: questionSpacing),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 2,
                                right: AppResponsive.scaleSize(
                                  context,
                                  8,
                                  min: 6,
                                  max: 10,
                                ),
                              ),
                              child: Icon(
                                Iconsax.quote_down_circle,
                                color: AppColors.white.withValues(alpha: 0.9),
                                size: AppResponsive.scaleSize(
                                  context,
                                  18,
                                  min: 16,
                                  max: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                q,
                                style: AppTextStyles.bodyText(context).copyWith(
                                  color: AppColors.white.withValues(
                                    alpha: 0.95,
                                  ),
                                  fontSize: AppResponsive.fontSizeClamped(
                                    context,
                                    min: 13,
                                    max: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            AppSpacing.vertical(context, 0.015),
            AppButton(
              text: l10n.faqViewFullPage,
              onPressed: () {
                onClose();
                Get.toNamed(ClientConstants.routeClientFaq);
              },
              textColor: AppColors.primary,
              backgroundColor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class _BubbleButton extends StatelessWidget {
  final VoidCallback onTap;
  final String tooltip;

  const _BubbleButton({required this.onTap, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    final size = AppResponsive.scaleSize(context, 56, min: 48, max: 60);
    return Tooltip(
      message: tooltip,
      child: Material(
        color: AppColors.primary,
        shape: const CircleBorder(),
        elevation: 8,
        shadowColor: AppColors.black.withValues(alpha: 0.3),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: size,
            height: size,
            child: Icon(
              Iconsax.message_2,
              color: AppColors.white,
              size: AppResponsive.scaleSize(context, 26, min: 22, max: 28),
            ),
          ),
        ),
      ),
    );
  }
}
