import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/admin/controllers/login/admin_login_controller.dart';
import 'package:elegant_advisors/presentation/admin/widgets/login/admin_login_background.dart';
import 'package:elegant_advisors/presentation/admin/widgets/login/admin_login_overlay.dart';

/// Admin login screen
class AdminLoginScreen extends GetView<AdminLoginController> {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [const AdminLoginBackground(), const AdminLoginOverlay()],
      ),
    );
  }
}
