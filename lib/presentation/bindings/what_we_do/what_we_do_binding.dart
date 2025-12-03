import 'package:get/get.dart';
import '../../controllers/what_we_do/what_we_do_controller.dart';

class WhatWeDoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WhatWeDoController>(() => WhatWeDoController());
  }
}

