import 'package:get/get.dart';
import '../../controllers/how_we_do_it/how_we_do_it_controller.dart';

class HowWeDoItBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HowWeDoItController>(() => HowWeDoItController());
  }
}

