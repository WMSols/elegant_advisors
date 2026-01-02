import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/properties_controller.dart';

class PropertiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropertiesController>(() => PropertiesController());
  }
}
