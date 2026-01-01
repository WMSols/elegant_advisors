import 'package:get/get.dart';
import '../../presentation/bindings/home/home_binding.dart';
import '../../presentation/pages/home/home_page.dart';
import '../../presentation/bindings/properties/properties_binding.dart';
import '../../presentation/pages/properties/properties_page.dart';
import '../../presentation/bindings/our_team/our_team_binding.dart';
import '../../presentation/pages/our_team/our_team_page.dart';
import '../../presentation/bindings/about_us/about_us_binding.dart';
import '../../presentation/pages/about_us/about_us_page.dart';
import '../../presentation/bindings/contact/contact_binding.dart';
import '../../presentation/pages/contact/contact_page.dart';
import '../constants/app_constants.dart';

class AppRoutes {
  AppRoutes._();

  static final routes = [
    GetPage(
      name: AppConstants.routeHome,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppConstants.routeProperties,
      page: () => const PropertiesPage(),
      binding: PropertiesBinding(),
    ),
    GetPage(
      name: AppConstants.routeOurTeam,
      page: () => const OurTeamPage(),
      binding: OurTeamBinding(),
    ),
    GetPage(
      name: AppConstants.routeAboutUs,
      page: () => const AboutUsPage(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: AppConstants.routeContact,
      page: () => const ContactPage(),
      binding: ContactBinding(),
    ),
  ];
}

