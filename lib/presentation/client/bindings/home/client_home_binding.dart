import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/controllers/home/client_home_controller.dart';

class ClientHomeBinding extends Bindings {
  @override
  void dependencies() {
    // Use lazyPut with fenix: true to recreate controller when needed
    // This ensures proper browser navigation support - controller is recreated when navigating back
    Get.lazyPut<ClientHomeController>(
      () => ClientHomeController(),
      fenix: true, // Recreate controller when it's removed and accessed again
    );
  }
}
