import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/controllers/contact/contact_controller.dart';

class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(() => ContactController());
  }
}
