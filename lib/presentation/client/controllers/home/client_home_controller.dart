import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:elegant_advisors/data/services/analytics_service.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';

class ClientHomeController extends BaseController {
  final AnalyticsService _analyticsService = AnalyticsService();
  ScrollController? _scrollController;
  final showHeader = false.obs;
  int _keyCounter = 0;

  // Use ValueKey instead of GlobalKey to avoid duplicate key issues
  // ValueKey with a counter ensures unique keys without GlobalKey conflicts
  Key get scrollViewKey => ValueKey('home_scroll_${_keyCounter}');

  // Store the listener function so we can remove it properly
  VoidCallback? _scrollListener;

  // Getter for scroll controller - returns existing or creates new one
  ScrollController get scrollController {
    _scrollController ??= ScrollController();
    if (_scrollListener == null) {
      _setupScrollListener();
    }
    return _scrollController!;
  }

  @override
  void onInit() {
    super.onInit();
    // Increment key counter to ensure unique key for each navigation
    _keyCounter++;
    // Create scroll controller
    _scrollController = ScrollController();
    _setupScrollListener();
    // Log page view
    _analyticsService.logPageView(pageName: 'Home', pagePath: '/');
  }

  void _setupScrollListener() {
    if (_scrollController == null) return;

    _scrollListener = () {
      // Only access position if controller has exactly one client
      if (_scrollController != null &&
          _scrollController!.hasClients &&
          _scrollController!.positions.length == 1) {
        try {
          final offset = _scrollController!.offset;
          // Show header background when scrolled down
          if (offset > 100) {
            if (!showHeader.value) {
              showHeader.value = true;
            }
          } else {
            if (showHeader.value) {
              showHeader.value = false;
            }
          }
        } catch (e) {
          // Controller might be disposed or have issues, ignore
        }
      }
    };

    _scrollController!.addListener(_scrollListener!);
  }

  @override
  void onClose() {
    // Remove listener before disposing
    if (_scrollController != null && _scrollListener != null) {
      _scrollController!.removeListener(_scrollListener!);
    }
    // Dispose the scroll controller
    _scrollController?.dispose();
    _scrollController = null;
    _scrollListener = null;
    super.onClose();
  }
}
