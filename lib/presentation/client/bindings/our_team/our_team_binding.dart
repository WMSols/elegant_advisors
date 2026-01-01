import 'package:get/get.dart';
import '../../controllers/our_team/our_team_controller.dart';

class OurTeamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OurTeamController>(() => OurTeamController());
  }
}
