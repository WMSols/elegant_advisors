import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_images/app_images.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/widgets/forms/app_text_field.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_action_button.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';
import 'package:elegant_advisors/domain/models/contact_submission_model.dart';

/// Dialog for replying to an inquiry
class AdminInquiryReplyDialog extends StatefulWidget {
  final ContactSubmissionModel inquiry;
  final Future<void> Function(String replyMessage) onSend;

  const AdminInquiryReplyDialog({
    super.key,
    required this.inquiry,
    required this.onSend,
  });

  @override
  State<AdminInquiryReplyDialog> createState() =>
      _AdminInquiryReplyDialogState();
}

class _AdminInquiryReplyDialogState extends State<AdminInquiryReplyDialog> {
  final _formKey = GlobalKey<FormState>();
  final _replyController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  Future<void> _handleSend() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final replyMessage = _replyController.text.trim();
    if (replyMessage.isEmpty) {
      return;
    }

    setState(() {
      _isSending = true;
    });

    try {
      await widget.onSend(replyMessage);
      // Operation succeeded - close dialog
      // Success message is already shown by the controller
      if (mounted) {
        // Use post-frame callback to ensure dialog closes after UI updates
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            try {
              Navigator.of(context, rootNavigator: true).pop(true);
            } catch (e) {
              // Fallback to Get.back() if Navigator fails
              if (mounted) {
                Get.back(result: true);
              }
            }
          }
        });
      }
    } catch (e) {
      // Error handling is done in the controller
      // Reset loading state on error so user can try again
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = AppResponsive.isMobile(context);
    final screenWidth = AppResponsive.screenWidth(context);

    // Calculate dialog width based on screen size
    final dialogWidth = isMobile ? screenWidth * 0.9 : screenWidth * 0.6;

    // Calculate horizontal padding for mobile
    final horizontalPadding = isMobile
        ? AppResponsive.scaleSize(context, 16, min: 12, max: 24)
        : AppResponsive.scaleSize(context, 24, min: 16, max: 32);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: AppResponsive.scaleSize(context, 24, min: 16, max: 32),
      ),
      child: SizedBox(
        width: dialogWidth,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: AppResponsive.screenHeight(context) * 0.9,
            minWidth: isMobile ? 280 : 400,
          ),
          child: Stack(
            children: [
              // Background - same as other admin dialogs
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    image: const DecorationImage(
                      image: AssetImage(AppImages.homeBackground),
                      fit: BoxFit.cover,
                      onError: null,
                    ),
                    borderRadius: BorderRadius.circular(
                      AppResponsive.radius(context),
                    ),
                  ),
                ),
              ),
              // Content
              Padding(
                padding: AppSpacing.all(context, factor: 1.5),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              AppTexts.adminInquiryReplyTitle,
                              style: AppTextStyles.heading(context).copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Iconsax.close_circle),
                            color: AppColors.white,
                            onPressed: _isSending ? null : () => Get.back(),
                            iconSize: AppResponsive.scaleSize(
                              context,
                              24,
                              min: 20,
                              max: 28,
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.vertical(context, 0.02),
                      // Inquiry Info
                      Container(
                        padding: AppSpacing.all(context, factor: 0.5),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(
                            AppResponsive.radius(context, factor: 0.5),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To: ${widget.inquiry.name} (${widget.inquiry.email})',
                              style: AppTextStyles.bodyText(context).copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            AppSpacing.vertical(context, 0.01),
                            Text(
                              'Subject: ${widget.inquiry.subject}',
                              style: AppTextStyles.bodyText(context).copyWith(
                                color: AppColors.white.withValues(alpha: 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppSpacing.vertical(context, 0.03),
                      // Reply Message Field
                      AppTextField(
                        label: AppTexts.adminInquiryReplyMessageLabel,
                        hint: AppTexts.adminInquiryReplyMessageHint,
                        controller: _replyController,
                        maxLines: 8,
                        minLines: 5,
                        keyboardType: TextInputType.multiline,
                        enabled: !_isSending,
                        isAdmin: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppTexts.adminInquiryReplyEmpty;
                          }
                          return null;
                        },
                      ),
                      AppSpacing.vertical(context, 0.03),
                      // Action Buttons
                      if (_isSending)
                        const Center(
                          child: AppLoadingIndicator(
                            variant: LoadingIndicatorVariant.white,
                          ),
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppActionButton(
                              label: AppTexts.adminInquiryReplyCancel,
                              onPressed: () => Get.back(),
                              backgroundColor: AppColors.white.withValues(
                                alpha: 0.2,
                              ),
                              labelColor: AppColors.white,
                            ),
                            AppSpacing.horizontal(context, 0.02),
                            AppActionButton(
                              label: AppTexts.adminInquiryReplySend,
                              onPressed: _handleSend,
                              backgroundColor: AppColors.information,
                              icon: Iconsax.send_2,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
