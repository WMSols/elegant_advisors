import 'package:get/get.dart';

/// Base controller that provides common functionality for all controllers
abstract class BaseController extends GetxController {
  // Loading state
  final isLoading = false.obs;
  final isInitialized = false.obs;

  // Error handling
  final errorMessage = ''.obs;
  final hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  @override
  void onReady() {
    super.onReady();
    isInitialized.value = true;
  }

  @override
  void onClose() {
    isLoading.value = false;
    errorMessage.value = '';
    hasError.value = false;
    super.onClose();
  }

  /// Initialize controller - override this method for custom initialization
  void _initialize() {
    // Override in child controllers if needed
  }

  /// Set loading state
  void setLoading(bool value) {
    isLoading.value = value;
  }

  /// Set error state
  void setError(String? message) {
    hasError.value = message != null && message.isNotEmpty;
    errorMessage.value = message ?? '';
  }

  /// Clear error state
  void clearError() {
    hasError.value = false;
    errorMessage.value = '';
  }

  /// Execute async operation with loading and error handling
  Future<T?> executeAsync<T>(Future<T> Function() operation) async {
    try {
      setLoading(true);
      clearError();
      final result = await operation();
      return result;
    } catch (e) {
      setError(e.toString());
      return null;
    } finally {
      setLoading(false);
    }
  }

  /// Show success message
  void showSuccess(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// Show error message
  void showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

