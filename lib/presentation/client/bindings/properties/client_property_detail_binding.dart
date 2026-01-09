import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_property_detail_controller.dart';

class ClientPropertyDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientPropertyDetailController>(
      () => ClientPropertyDetailController(),
    );
  }
}
