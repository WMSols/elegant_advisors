import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/presentation/admin/controllers/dashboard/admin_dashboard_controller.dart';

/// Pie chart widget for admin dashboard showing combined metrics
class AdminDashboardPieChart extends GetView<AdminDashboardController> {
  const AdminDashboardPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppResponsive.isMobile(context);
    final spacing = AppResponsive.scaleSize(context, 16, min: 12, max: 24);
    final borderRadius = AppResponsive.scaleSize(context, 12, min: 8, max: 16);
    final padding = AppResponsive.scaleSize(context, 20, min: 16, max: 24);

    return Obx(() {
      final totalVisitors = controller.totalVisitors.value;
      final totalPropertyVisits = controller.totalPropertyVisits.value;
      final totalUniqueVisits = controller.totalUniqueVisits.value;
      final totalProperties = controller.propertiesCount.value;
      final publishedProperties = controller.publishedPropertiesCount.value;
      final newInquiries = controller.newInquiriesCount.value;

      // Prepare pie chart data
      final pieChartData = [
        _PieChartData(
          value: totalVisitors.toDouble(),
          color: AppColors.totalVisits,
          label: AppTexts.adminDashboardTotalVisitors,
        ),
        _PieChartData(
          value: totalPropertyVisits.toDouble(),
          color: AppColors.propertyVisits,
          label: AppTexts.adminDashboardTotalPropertyVisits,
        ),
        _PieChartData(
          value: totalUniqueVisits.toDouble(),
          color: AppColors.uniqueVisits,
          label: AppTexts.adminDashboardUniqueVisits,
        ),
        _PieChartData(
          value: totalProperties.toDouble(),
          color: AppColors.totalProperties,
          label: AppTexts.adminDashboardTotalProperties,
        ),
        _PieChartData(
          value: publishedProperties.toDouble(),
          color: AppColors.publishedProperties,
          label: AppTexts.adminDashboardPublishedProperties,
        ),
        _PieChartData(
          value: newInquiries.toDouble(),
          color: AppColors.newInquiries,
          label: AppTexts.adminDashboardNewInquiries,
        ),
      ];

      return Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              'Overview Statistics',
              style: AppTextStyles.headline(
                context,
              ).copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: spacing),
            // Chart and Legend - Flexible to prevent overflow
            Flexible(
              child: isMobile
                  ? _buildMobileLayout(context, pieChartData, spacing)
                  : _buildDesktopLayout(context, pieChartData, spacing),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildMobileLayout(
    BuildContext context,
    List<_PieChartData> data,
    double spacing,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Pie Chart
        SizedBox(
          height: AppResponsive.scaleSize(context, 200, min: 150, max: 250),
          child: _buildPieChart(data),
        ),
        SizedBox(height: spacing),
        // Legend - Flexible to prevent overflow
        Flexible(child: _buildLegend(context, data)),
      ],
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    List<_PieChartData> data,
    double spacing,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pie Chart
        Expanded(
          flex: 2,
          child: SizedBox(
            height: AppResponsive.scaleSize(context, 250, min: 200, max: 300),
            child: _buildPieChart(data),
          ),
        ),
        SizedBox(width: spacing),
        // Legend
        Expanded(flex: 1, child: _buildLegend(context, data)),
      ],
    );
  }

  Widget _buildPieChart(List<_PieChartData> data) {
    final total = _getTotal(data);

    return PieChart(
      PieChartData(
        sections: data.asMap().entries.map((entry) {
          final item = entry.value;
          // If total is 0, use equal values (1.0) for visual representation
          // but show 0 in the title
          final chartValue = total == 0 ? 1.0 : item.value;
          final displayValue = item.value.toInt();

          return PieChartSectionData(
            value: chartValue,
            color: item.color,
            title: displayValue.toString(),
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          );
        }).toList(),
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        startDegreeOffset: -90,
      ),
    );
  }

  Widget _buildLegend(BuildContext context, List<_PieChartData> data) {
    final total = _getTotal(data);
    final spacing = AppResponsive.scaleSize(context, 12, min: 8, max: 16);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: data.map((item) {
        final percentage = total > 0 ? (item.value / total) * 100 : 0.0;
        return Padding(
          padding: EdgeInsets.only(bottom: spacing),
          child: Row(
            children: [
              // Color indicator
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: item.color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spacing * 0.75),
              // Label and value
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.label,
                      style: AppTextStyles.bodyText(context).copyWith(
                        fontSize: AppResponsive.scaleSize(
                          context,
                          12,
                          min: 10,
                          max: 14,
                        ),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${item.value.toInt()} (${percentage.toStringAsFixed(1)}%)',
                      style: AppTextStyles.bodyText(context).copyWith(
                        fontSize: AppResponsive.scaleSize(
                          context,
                          11,
                          min: 9,
                          max: 13,
                        ),
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  double _getTotal(List<_PieChartData> data) {
    return data.fold(0.0, (sum, item) => sum + item.value);
  }
}

/// Internal class to hold pie chart data
class _PieChartData {
  final double value;
  final Color color;
  final String label;

  _PieChartData({
    required this.value,
    required this.color,
    required this.label,
  });
}
