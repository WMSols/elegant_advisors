import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/admin/controllers/properties/admin_property_form_controller.dart';

class AdminPropertyFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminPropertyFormController>(
      () => AdminPropertyFormController(),
    );
  }
}
