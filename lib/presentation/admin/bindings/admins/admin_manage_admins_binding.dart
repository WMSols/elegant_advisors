import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/admin/controllers/admins/admin_manage_admins_controller.dart';

class AdminManageAdminsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminManageAdminsController());
  }
}
