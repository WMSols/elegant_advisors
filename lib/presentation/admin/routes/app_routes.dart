import 'package:get/get.dart';
import 'package:elegant_advisors/core/constants/admin_constants.dart';
import 'package:elegant_advisors/presentation/admin/screens/login/login_screen.dart';
import 'package:elegant_advisors/presentation/admin/screens/login/login_binding.dart';
import 'package:elegant_advisors/presentation/admin/screens/dashboard/dashboard_screen.dart';
import 'package:elegant_advisors/presentation/admin/screens/dashboard/dashboard_binding.dart';
import 'package:elegant_advisors/presentation/admin/middleware/auth_middleware.dart';

class AdminRoutes {
  AdminRoutes._();

  static final routes = [
    GetPage(
      name: AdminConstants.routeLogin,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AdminConstants.routeDashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
