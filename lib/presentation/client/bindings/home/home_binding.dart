import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/controllers/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
