import 'package:get/get.dart';
import '../../../core/constants/client_constants.dart';
import '../bindings/home/home_binding.dart';
import '../pages/home/home_page.dart';
import '../bindings/properties/properties_binding.dart';
import '../pages/properties/properties_page.dart';
import '../bindings/our_team/our_team_binding.dart';
import '../pages/our_team/our_team_page.dart';
import '../bindings/about_us/about_us_binding.dart';
import '../pages/about_us/about_us_page.dart';
import '../bindings/contact/contact_binding.dart';
import '../pages/contact/contact_page.dart';

class AppRoutes {
  AppRoutes._();

  static final routes = [
    GetPage(
      name: ClientConstants.routeHome,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: ClientConstants.routeProperties,
      page: () => const PropertiesPage(),
      binding: PropertiesBinding(),
    ),
    GetPage(
      name: ClientConstants.routeOurTeam,
      page: () => const OurTeamPage(),
      binding: OurTeamBinding(),
    ),
    GetPage(
      name: ClientConstants.routeAboutUs,
      page: () => const AboutUsPage(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: ClientConstants.routeContact,
      page: () => const ContactPage(),
      binding: ContactBinding(),
    ),
  ];
}
