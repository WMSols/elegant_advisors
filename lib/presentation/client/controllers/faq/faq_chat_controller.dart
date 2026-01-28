import 'package:get/get.dart';

/// Controller for the FAQ chat-style widget.
/// Persists across client route changes and auto-collapses when route changes.
class FaqChatController extends GetxController {
  final expanded = false.obs;
  String? _lastRoute;

  void toggle() {
    expanded.value = !expanded.value;
  }

  void collapse() {
    expanded.value = false;
  }

  /// Call from widget build to auto-collapse when route changes.
  void onRouteMaybeChanged(String? currentRoute) {
    if (currentRoute != _lastRoute) {
      _lastRoute = currentRoute;
      expanded.value = false;
    }
  }
}
