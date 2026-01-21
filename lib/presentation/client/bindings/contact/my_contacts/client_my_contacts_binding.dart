import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/controllers/contact/my_contacts/client_my_contacts_controller.dart';

class ClientMyContactsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientMyContactsController>(() => ClientMyContactsController());
  }
}
