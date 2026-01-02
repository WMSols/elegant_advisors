import 'package:get/get.dart';
import 'package:elegant_advisors/core/constants/admin_constants.dart';
import 'package:elegant_advisors/presentation/admin/screens/login/login_screen.dart';
import 'package:elegant_advisors/presentation/admin/screens/login/login_binding.dart';
import 'package:elegant_advisors/presentation/admin/screens/dashboard/dashboard_screen.dart';
import 'package:elegant_advisors/presentation/admin/screens/dashboard/dashboard_binding.dart';
import 'package:elegant_advisors/presentation/admin/screens/properties/properties_screen.dart';
import 'package:elegant_advisors/presentation/admin/bindings/properties/properties_binding.dart';
import 'package:elegant_advisors/presentation/admin/screens/properties/property_form_screen.dart';
import 'package:elegant_advisors/presentation/admin/bindings/properties/property_form_binding.dart';
import 'package:elegant_advisors/presentation/admin/screens/inquiries/inquiries_screen.dart';
import 'package:elegant_advisors/presentation/admin/bindings/inquiries/inquiries_binding.dart';
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
    GetPage(
      name: AdminConstants.routeProperties,
      page: () => const AdminPropertiesScreen(),
      binding: AdminPropertiesBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AdminConstants.routePropertyAdd,
      page: () => const PropertyFormScreen(),
      binding: PropertyFormBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AdminConstants.routePropertyEdit,
      page: () => const PropertyFormScreen(),
      binding: PropertyFormBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AdminConstants.routeInquiries,
      page: () => const AdminInquiriesScreen(),
      binding: AdminInquiriesBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
