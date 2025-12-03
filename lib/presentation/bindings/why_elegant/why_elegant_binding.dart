import 'package:get/get.dart';
import '../../controllers/why_elegant/why_elegant_controller.dart';

class WhyElegantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WhyElegantController>(() => WhyElegantController());
  }
}

