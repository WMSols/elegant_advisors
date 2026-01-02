import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/admin/controllers/properties/property_form_controller.dart';

class PropertyFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PropertyFormController());
  }
}
