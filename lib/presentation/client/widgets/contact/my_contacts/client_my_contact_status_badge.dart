import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';

/// Status badge widget for my contact submissions
class ClientMyContactStatusBadge extends StatelessWidget {
  final String status; // new, in_progress, closed

  const ClientMyContactStatusBadge({
    super.key,
    required this.status,
  });

  Color _getStatusColor() {
    switch (status) {
      case 'new':
        return Colors.blue;
      case 'in_progress':
        return Colors.orange;
      case 'closed':
        return Colors.green;
      default:
        return AppColors.primary;
    }
  }

  String _getStatusText() {
    switch (status) {
      case 'new':
        return AppTexts.myContactsStatusNew;
      case 'in_progress':
        return AppTexts.myContactsStatusInProgress;
      case 'closed':
        return AppTexts.myContactsStatusClosed;
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppResponsive.scaleSize(context, 8, min: 6, max: 12),
        vertical: AppResponsive.scaleSize(context, 4, min: 2, max: 6),
      ),
      decoration: BoxDecoration(
        color: _getStatusColor(),
        borderRadius: BorderRadius.circular(
          AppResponsive.radius(context, factor: 3),
        ),
      ),
      child: Text(
        _getStatusText(),
        style: AppTextStyles.heading(context).copyWith(
          color: AppColors.white,
          fontSize: AppResponsive.fontSizeClamped(
            context,
            min: 10,
            max: 12,
          ),
        ),
      ),
    );
  }
}
