import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_off_market_controller.dart';

class ClientOffMarketBinding extends Bindings {
  @override
  void dependencies() {
    // Use lazyPut with fenix: true to recreate controller when needed
    // This ensures proper browser navigation support - controller is recreated when navigating back
    Get.lazyPut<ClientOffMarketController>(
      () => ClientOffMarketController(),
      fenix: true, // Recreate controller when it's removed and accessed again
    );
  }
}
