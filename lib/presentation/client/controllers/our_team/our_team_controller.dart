import 'package:get/get.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/domain/models/team_model.dart';
import 'package:elegant_advisors/presentation/base_controller.dart';

class OurTeamController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();

  final teamMembers = <TeamModel>[].obs;
  final isLoadingTeam = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTeam();
  }

  Future<void> loadTeam() async {
    isLoadingTeam.value = true;
    try {
      final fetchedTeam = await _firestoreService.getPublishedTeamOnce();
      teamMembers.value = fetchedTeam;
    } catch (e) {
      showError('Failed to load team members');
    } finally {
      isLoadingTeam.value = false;
    }
  }
}
