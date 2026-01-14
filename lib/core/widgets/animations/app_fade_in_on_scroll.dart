import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/controllers/home/client_home_controller.dart';

class AppFadeInOnScroll extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double offset;

  const AppFadeInOnScroll({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOut,
    this.offset = 150.0,
  });

  @override
  State<AppFadeInOnScroll> createState() => _AppFadeInOnScrollState();
}

class _AppFadeInOnScrollState extends State<AppFadeInOnScroll>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final GlobalKey _key = GlobalKey();
  bool _wasVisible = false;
  ScrollController? _scrollController;
  double _lastScrollPosition = 0.0;
  bool _hasCheckedInBuild = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);

    // Start with opacity 0
    _controller.value = 0.0;

    // Try to get the ClientHomeController
    try {
      final homeController = Get.find<ClientHomeController>();
      _scrollController = homeController.scrollController;
      _lastScrollPosition = _scrollController?.position.pixels ?? 0.0;
      _scrollController?.addListener(_checkVisibility);
      // Check initial visibility after widget is fully laid out
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Multiple checks to ensure we catch the visibility state
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) _checkVisibility();
        });
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) _checkVisibility();
        });
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) _checkVisibility();
        });
      });
    } catch (e) {
      // If controller not found, just animate immediately
      _controller.forward();
      _wasVisible = true;
    }
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_checkVisibility);
    _controller.dispose();
    super.dispose();
  }

  void _checkVisibility() {
    if (!mounted) return;

    final RenderObject? renderObject = _key.currentContext?.findRenderObject();
    if (renderObject == null || renderObject is! RenderBox) return;

    final RenderBox renderBox = renderObject;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenHeight = MediaQuery.of(context).size.height;

    // Check if widget is in viewport (with offset buffer)
    final isVisible =
        position.dy < screenHeight + widget.offset &&
        position.dy + size.height > -widget.offset;

    // Get current scroll position to determine scroll direction
    final currentScrollPosition = _scrollController?.position.pixels ?? 0.0;
    final isScrollingDown = currentScrollPosition > _lastScrollPosition;
    _lastScrollPosition = currentScrollPosition;

    // Animate when section comes into view
    if (isVisible) {
      // If just became visible (transition from not visible to visible)
      if (!_wasVisible) {
        // Reset and animate
        if (_controller.status == AnimationStatus.completed ||
            _controller.status == AnimationStatus.dismissed) {
          _controller.reset();
        }
        if (_controller.status != AnimationStatus.forward) {
          _controller.forward();
        }
      }
      // Also animate if scrolling down and animation hasn't completed
      else if (isScrollingDown &&
          _controller.value < 1.0 &&
          _controller.status != AnimationStatus.forward) {
        _controller.forward();
      }
    } else {
      // Reset when going out of view (for re-animation when scrolling back)
      if (_wasVisible && _controller.status == AnimationStatus.completed) {
        _controller.reset();
      }
    }

    _wasVisible = isVisible;
  }

  @override
  Widget build(BuildContext context) {
    // Additional check: if widget is visible but animation hasn't started, trigger it
    // Only check once to avoid performance issues
    if (!_hasCheckedInBuild) {
      _hasCheckedInBuild = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted &&
            _controller.value == 0.0 &&
            _controller.status != AnimationStatus.forward) {
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              final RenderObject? renderObject = _key.currentContext
                  ?.findRenderObject();
              if (renderObject != null && renderObject is RenderBox) {
                final RenderBox renderBox = renderObject;
                final position = renderBox.localToGlobal(Offset.zero);
                final size = renderBox.size;
                final screenHeight = MediaQuery.of(context).size.height;
                final isVisible =
                    position.dy < screenHeight + widget.offset &&
                    position.dy + size.height > -widget.offset;

                if (isVisible) {
                  _controller.forward();
                  _wasVisible = true;
                }
              }
            }
          });
        }
      });
    }

    return FadeTransition(
      opacity: _animation,
      child: Container(key: _key, child: widget.child),
    );
  }
}
