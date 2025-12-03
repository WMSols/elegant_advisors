import 'package:get/get.dart';
import '../../controllers/golden_visa/golden_visa_controller.dart';

class GoldenVisaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoldenVisaController>(() => GoldenVisaController());
  }
}

