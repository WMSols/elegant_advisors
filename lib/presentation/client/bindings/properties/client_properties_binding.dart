import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_properties_controller.dart';

class ClientPropertiesBinding extends Bindings {
  @override
  void dependencies() {
    // Use Get.put instead of Get.lazyPut to ensure a fresh instance for each route navigation
    // This ensures the controller is created immediately and is route-specific
    Get.put<ClientPropertiesController>(
      ClientPropertiesController(),
      permanent: false,
    );
  }
}
