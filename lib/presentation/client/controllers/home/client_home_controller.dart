import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:elegant_advisors/data/services/analytics_service.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';

class ClientHomeController extends BaseController {
  final AnalyticsService _analyticsService = AnalyticsService();
  final scrollController = ScrollController();
  final showHeader = false.obs;
  int _keyCounter = 0;

  // Use ValueKey instead of GlobalKey to avoid duplicate key issues
  // ValueKey with a counter ensures unique keys without GlobalKey conflicts
  Key get scrollViewKey => ValueKey('home_scroll_$_keyCounter');

  @override
  void onInit() {
    super.onInit();
    // Increment key counter to ensure unique key for each navigation
    _keyCounter++;
    scrollController.addListener(_onScroll);
    // Log page view
    _analyticsService.logPageView(pageName: 'Home', pagePath: '/');
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    final show = scrollController.hasClients && scrollController.offset > 100;
    if (showHeader.value != show) {
      showHeader.value = show;
    }
  }
}
