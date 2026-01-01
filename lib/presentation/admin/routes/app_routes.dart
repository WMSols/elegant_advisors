import 'package:get/get.dart';
import '../../../core/constants/admin_constants.dart';
import '../pages/login/login_page.dart';
import '../pages/login/login_binding.dart';
import '../pages/dashboard/dashboard_page.dart';
import '../pages/dashboard/dashboard_binding.dart';
import '../middleware/auth_middleware.dart';

class AppRoutes {
  AppRoutes._();

  static final routes = [
    GetPage(
      name: AdminConstants.routeLogin,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AdminConstants.routeDashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
