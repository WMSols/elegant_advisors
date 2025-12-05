import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../base_controller.dart';

class HomeController extends BaseController {
  // Scroll controller
  late ScrollController scrollController;
  
  // Scroll position tracking
  final scrollPosition = 0.0.obs;
  final showHeader = false.obs;

  @override
  void onInit() {
    super.onInit();
    initScrollController();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  // Initialize scroll controller
  void initScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  // Update scroll position and determine header visibility
  void _onScroll() {
    final position = scrollController.position.pixels;
    scrollPosition.value = position;
    // Show header when scrolled down more than 100 pixels
    showHeader.value = position > 100;
  }
}

