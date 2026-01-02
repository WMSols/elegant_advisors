import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/controllers/about_us/about_us_controller.dart';

class AboutUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutUsController>(() => AboutUsController());
  }
}
