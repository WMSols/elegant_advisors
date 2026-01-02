import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/admin/controllers/inquiries/inquiries_controller.dart';

class AdminInquiriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminInquiriesController());
  }
}
