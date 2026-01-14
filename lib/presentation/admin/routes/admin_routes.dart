import 'package:get/get.dart';
import 'package:elegant_advisors/core/constants/admin_constants.dart';
import 'package:elegant_advisors/presentation/admin/widgets/navigation/transitions/admin_transitions.dart';
import 'package:elegant_advisors/presentation/admin/screens/login/admin_login_screen.dart';
import 'package:elegant_advisors/presentation/admin/bindings/login/admin_login_binding.dart';
import 'package:elegant_advisors/presentation/admin/screens/dashboard/admin_dashboard_screen.dart';
import 'package:elegant_advisors/presentation/admin/bindings/dashboard/admin_dashboard_binding.dart';
import 'package:elegant_advisors/presentation/admin/screens/properties/admin_properties_screen.dart';
import 'package:elegant_advisors/presentation/admin/bindings/properties/admin_properties_binding.dart';
import 'package:elegant_advisors/presentation/admin/screens/properties/admin_property_form_screen.dart';
import 'package:elegant_advisors/presentation/admin/bindings/properties/admin_property_form_binding.dart';
import 'package:elegant_advisors/presentation/admin/screens/inquiries/admin_inquiries_screen.dart';
import 'package:elegant_advisors/presentation/admin/bindings/inquiries/admin_inquiries_binding.dart';
import 'package:elegant_advisors/presentation/admin/screens/admins/admin_manage_admins_screen.dart';
import 'package:elegant_advisors/presentation/admin/bindings/admins/admin_manage_admins_binding.dart';
import 'package:elegant_advisors/presentation/admin/screens/admins/admin_create_edit_admin_screen.dart';
import 'package:elegant_advisors/presentation/admin/bindings/admins/admin_create_edit_admin_binding.dart';
import 'package:elegant_advisors/presentation/admin/middleware/admin_auth_middleware.dart';

class AdminRoutes {
  AdminRoutes._();

  static final routes = [
    GetPage(
      name: AdminConstants.routeAdminLogin,
      page: () => const AdminLoginScreen(),
      binding: AdminLoginBinding(),
      // Login screen doesn't need transition as it's the initial route
    ),
    GetPage(
      name: AdminConstants.routeAdminDashboard,
      page: () => const AdminDashboardScreen(),
      binding: AdminDashboardBinding(),
      middlewares: [AdminAuthMiddleware()],
      customTransition: AdminTransitions.buildTransition,
    ),
    GetPage(
      name: AdminConstants.routeAdminProperties,
      page: () => const AdminPropertiesScreen(),
      binding: AdminPropertiesBinding(),
      middlewares: [AdminAuthMiddleware()],
      customTransition: AdminTransitions.buildTransition,
    ),
    GetPage(
      name: AdminConstants.routeAdminPropertyAdd,
      page: () => const AdminPropertyFormScreen(),
      binding: AdminPropertyFormBinding(),
      middlewares: [AdminAuthMiddleware()],
      customTransition: AdminTransitions.buildTransition,
    ),
    GetPage(
      name: AdminConstants.routeAdminPropertyEdit,
      page: () => const AdminPropertyFormScreen(),
      binding: AdminPropertyFormBinding(),
      middlewares: [AdminAuthMiddleware()],
      customTransition: AdminTransitions.buildTransition,
    ),
    GetPage(
      name: AdminConstants.routeAdminInquiries,
      page: () => const AdminInquiriesScreen(),
      binding: AdminInquiriesBinding(),
      middlewares: [AdminAuthMiddleware()],
      customTransition: AdminTransitions.buildTransition,
    ),
    GetPage(
      name: AdminConstants.routeAdminManageAdmins,
      page: () => const AdminManageAdminsScreen(),
      binding: AdminManageAdminsBinding(),
      middlewares: [AdminAuthMiddleware()],
      customTransition: AdminTransitions.buildTransition,
    ),
    GetPage(
      name: AdminConstants.routeAdminCreateAdmin,
      page: () => const AdminCreateEditAdminScreen(),
      binding: AdminCreateEditAdminBinding(),
      middlewares: [AdminAuthMiddleware()],
      customTransition: AdminTransitions.buildTransition,
    ),
    GetPage(
      name: AdminConstants.routeAdminEditAdmin,
      page: () => const AdminCreateEditAdminScreen(),
      binding: AdminCreateEditAdminBinding(),
      middlewares: [AdminAuthMiddleware()],
      customTransition: AdminTransitions.buildTransition,
    ),
  ];
}
