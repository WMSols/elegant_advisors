import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:elegant_advisors/data/services/analytics_service.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';

class HomeController extends BaseController {
  final AnalyticsService _analyticsService = AnalyticsService();
  final scrollController = ScrollController();
  final showHeader = false.obs;

  @override
  void onInit() {
    super.onInit();
    _setupScrollListener();
    // Log page view
    _analyticsService.logPageView(pageName: 'Home', pagePath: '/');
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      final shouldShow = scrollController.offset > 100;
      if (showHeader.value != shouldShow) {
        showHeader.value = shouldShow;
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
