import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_pagination_helper.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_icon_button.dart';

/// Pagination widget for properties
class ClientPropertiesPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final Function(int) onPageChanged;

  const ClientPropertiesPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 1) {
      return const SizedBox.shrink();
    }

    final pageNumbers = AppPaginationHelper.getPageNumbers(
      currentPage,
      totalPages,
    );
    final startItem = AppPaginationHelper.getStartItemNumber(
      currentPage,
      itemsPerPage,
    );
    final endItem = AppPaginationHelper.getEndItemNumber(
      currentPage,
      itemsPerPage,
      totalItems,
    );

    return Column(
      children: [
        // Page Info
        Text(
          '${AppTexts.clientPropertiesPaginationShowing} $startItem-$endItem ${AppTexts.clientPropertiesPaginationOf} $totalItems ${AppTexts.clientPropertiesPaginationResults}',
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.primary,
            fontSize: AppResponsive.fontSizeClamped(
              context,
              min: 12,
              max: 14,
            ),
          ),
        ),
        AppSpacing.vertical(context, 0.02),
        // Pagination Controls
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Previous Button
            AppIconButton(
              icon: Iconsax.arrow_left_2,
              onPressed: currentPage > 1
                  ? () => onPageChanged(currentPage - 1)
                  : null,
              backgroundColor: AppColors.primary,
            ),
            AppSpacing.horizontal(context, 0.02),
            // Page Numbers
            Wrap(
              spacing: AppResponsive.scaleSize(context, 8, min: 4, max: 12),
              children: pageNumbers.map((pageNum) {
                if (pageNum == null) {
                  // Ellipsis
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppResponsive.scaleSize(
                        context,
                        4,
                        min: 2,
                        max: 6,
                      ),
                    ),
                    child: Text(
                      '...',
                      style: AppTextStyles.bodyText(context),
                    ),
                  );
                }

                final isActive = pageNum == currentPage;
                return GestureDetector(
                  onTap: () => onPageChanged(pageNum),
                  child: Container(
                    width: AppResponsive.scaleSize(context, 40, min: 32, max: 48),
                    height: AppResponsive.scaleSize(context, 40, min: 32, max: 48),
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.primary : AppColors.white,
                      borderRadius: BorderRadius.circular(
                        AppResponsive.radius(context, factor: 0.8),
                      ),
                      border: Border.all(
                        color: isActive
                            ? AppColors.primary
                            : AppColors.grey.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$pageNum',
                        style: AppTextStyles.bodyText(context).copyWith(
                          color: isActive ? AppColors.white : AppColors.primary,
                          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                          fontSize: AppResponsive.fontSizeClamped(
                            context,
                            min: 14,
                            max: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            AppSpacing.horizontal(context, 0.02),
            // Next Button
            AppIconButton(
              icon: Iconsax.arrow_right_2,
              onPressed: currentPage < totalPages
                  ? () => onPageChanged(currentPage + 1)
                  : null,
              backgroundColor: AppColors.primary,
            ),
          ],
        ),
      ],
    );
  }
}
