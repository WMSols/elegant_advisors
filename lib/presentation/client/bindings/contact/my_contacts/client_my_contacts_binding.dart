import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/controllers/contact/my_contacts/client_my_contacts_controller.dart';

class ClientMyContactsBinding extends Bindings {
  @override
  void dependencies() {
    // Use lazyPut with fenix: true to recreate controller when needed
    // This ensures proper browser navigation support - controller is recreated when navigating back
    Get.lazyPut<ClientMyContactsController>(
      () => ClientMyContactsController(),
      fenix: true, // Recreate controller when it's removed and accessed again
    );
  }
}
