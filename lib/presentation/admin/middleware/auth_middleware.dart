import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/data/services/auth_service.dart';
import 'package:elegant_advisors/core/constants/admin_constants.dart';

class AuthMiddleware extends GetMiddleware {
  final AuthService _authService = AuthService();

  @override
  RouteSettings? redirect(String? route) {
    final user = _authService.currentUser;
    if (user == null) {
      return const RouteSettings(name: AdminConstants.routeLogin);
    }
    return null;
  }
}
