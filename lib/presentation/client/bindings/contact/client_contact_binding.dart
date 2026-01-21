import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/controllers/contact/client_contact_controller.dart';

class ClientContactBinding extends Bindings {
  @override
  void dependencies() {
    // Use lazyPut with fenix: true to recreate controller when needed
    // This ensures proper browser navigation support - controller is recreated when navigating back
    Get.lazyPut<ClientContactController>(
      () => ClientContactController(),
      fenix: true, // Recreate controller when it's removed and accessed again
    );
  }
}
