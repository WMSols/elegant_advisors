import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/property_detail_controller.dart';

class PropertyDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PropertyDetailController());
  }
}
