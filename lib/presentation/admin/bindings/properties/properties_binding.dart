import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/admin/controllers/properties/properties_controller.dart';

class AdminPropertiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminPropertiesController());
  }
}
