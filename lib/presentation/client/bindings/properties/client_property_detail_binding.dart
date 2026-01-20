import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_property_detail_controller.dart';

class ClientPropertyDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Use lazyPut with fenix: true to recreate controller when needed
    // This ensures proper browser navigation support - controller is recreated when navigating back
    Get.lazyPut<ClientPropertyDetailController>(
      () => ClientPropertyDetailController(),
      fenix: true, // Recreate controller when it's removed and accessed again
    );
  }
}
