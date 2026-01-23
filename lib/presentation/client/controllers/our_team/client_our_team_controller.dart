import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/domain/models/team_model.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';

class ClientOurTeamController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();

  final teamMembers = <TeamModel>[].obs;
  final isLoadingTeam = false.obs;
  final scrollController = ScrollController();
  final showHeader = false.obs;
  int _keyCounter = 0;

  // Use ValueKey instead of GlobalKey to avoid duplicate key issues
  // ValueKey with a counter ensures unique keys without GlobalKey conflicts
  Key get scrollViewKey => ValueKey('our_team_scroll_$_keyCounter');

  @override
  void onInit() {
    super.onInit();
    // Increment key counter to ensure unique key for each navigation
    _keyCounter++;
    scrollController.addListener(_onScroll);
    loadTeam();
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    final show = scrollController.hasClients && scrollController.offset > 100;
    if (showHeader.value != show) {
      showHeader.value = show;
    }
  }

  Future<void> loadTeam() async {
    isLoadingTeam.value = true;
    try {
      final fetchedTeam = await _firestoreService.getPublishedTeamOnce();
      teamMembers.value = fetchedTeam;
    } catch (e) {
      // showError('Failed to load team members');
    } finally {
      isLoadingTeam.value = false;
    }
  }
}
