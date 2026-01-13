import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/admin/controllers/admins/admin_create_edit_admin_controller.dart';

class AdminCreateEditAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminCreateEditAdminController());
  }
}
