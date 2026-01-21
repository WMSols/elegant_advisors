import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/domain/models/contact_submission_model.dart';
import 'package:elegant_advisors/presentation/client/widgets/contact/my_contacts/client_my_contact_status_badge.dart';

/// My contact card widget displaying a single contact submission
class ClientMyContactCard extends StatefulWidget {
  final ContactSubmissionModel contact;

  const ClientMyContactCard({super.key, required this.contact});

  @override
  State<ClientMyContactCard> createState() => _ClientMyContactCardState();
}

class _ClientMyContactCardState extends State<ClientMyContactCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = AppResponsive.isMobile(context);
    final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');
    final formattedDate = dateFormat.format(widget.contact.createdAt);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(
          bottom: AppSpacing.vertical(context, 0.02).height ?? 16,
        ),
        padding: AppSpacing.all(context),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
          border: Border.all(
            color: _isHovered
                ? AppColors.primary
                : AppColors.grey.withValues(alpha: 0.2),
            width: _isHovered ? 1 : 0,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.white.withValues(alpha: 0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Status and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClientMyContactStatusBadge(status: widget.contact.status),
                Text(
                  formattedDate,
                  style: AppTextStyles.bodyText(context).copyWith(
                    color: AppColors.primary,
                    fontSize: AppResponsive.fontSizeClamped(
                      context,
                      min: 12,
                      max: 14,
                    ),
                  ),
                ),
              ],
            ),
            AppSpacing.vertical(context, 0.02),
            // Subject
            if (widget.contact.subject.isNotEmpty) ...[
              Text(
                AppTexts.myContactsSubject,
                style: AppTextStyles.bodyText(context).copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: AppResponsive.fontSizeClamped(
                    context,
                    min: 12,
                    max: 14,
                  ),
                ),
              ),
              AppSpacing.vertical(context, 0.01),
              Text(
                widget.contact.subject,
                style: AppTextStyles.heading(context).copyWith(
                  fontSize: AppResponsive.fontSizeClamped(
                    context,
                    min: 16,
                    max: 20,
                  ),
                ),
              ),
              AppSpacing.vertical(context, 0.02),
            ],
            // Message
            Text(
              AppTexts.myContactsMessage,
              style: AppTextStyles.bodyText(context).copyWith(
                fontWeight: FontWeight.bold,
                fontSize: AppResponsive.fontSizeClamped(
                  context,
                  min: 12,
                  max: 14,
                ),
              ),
            ),
            AppSpacing.vertical(context, 0.01),
            Text(
              widget.contact.message,
              style: AppTextStyles.bodyText(context).copyWith(
                fontSize: AppResponsive.fontSizeClamped(
                  context,
                  min: 14,
                  max: 16,
                ),
              ),
              maxLines: isMobile ? 3 : 4,
              overflow: TextOverflow.ellipsis,
            ),
            // Property link if exists
            if (widget.contact.propertyId != null) ...[
              AppSpacing.vertical(context, 0.02),
              Text(
                AppTexts.myContactsProperty,
                style: AppTextStyles.bodyText(context).copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: AppResponsive.fontSizeClamped(
                    context,
                    min: 12,
                    max: 14,
                  ),
                ),
              ),
            ] else ...[
              AppSpacing.vertical(context, 0.01),
              Text(
                AppTexts.myContactsNoProperty,
                style: AppTextStyles.bodyText(context).copyWith(
                  color: AppColors.primary,
                  fontSize: AppResponsive.fontSizeClamped(
                    context,
                    min: 12,
                    max: 14,
                  ),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
