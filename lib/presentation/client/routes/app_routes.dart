import 'package:get/get.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/presentation/client/bindings/home/home_binding.dart';
import 'package:elegant_advisors/presentation/client/screens/home/home_screen.dart';
import 'package:elegant_advisors/presentation/client/bindings/properties/properties_binding.dart';
import 'package:elegant_advisors/presentation/client/screens/properties/properties_screen.dart';
import 'package:elegant_advisors/presentation/client/bindings/our_team/our_team_binding.dart';
import 'package:elegant_advisors/presentation/client/screens/our_team/our_team_screen.dart';
import 'package:elegant_advisors/presentation/client/bindings/about_us/about_us_binding.dart';
import 'package:elegant_advisors/presentation/client/screens/about_us/about_us_screen.dart';
import 'package:elegant_advisors/presentation/client/bindings/contact/contact_binding.dart';
import 'package:elegant_advisors/presentation/client/screens/contact/contact_screen.dart';

class ClientRoutes {
  ClientRoutes._();

  static final routes = [
    GetPage(
      name: ClientConstants.routeHome,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: ClientConstants.routeProperties,
      page: () => const PropertiesScreen(),
      binding: PropertiesBinding(),
    ),
    GetPage(
      name: ClientConstants.routeOurTeam,
      page: () => const OurTeamScreen(),
      binding: OurTeamBinding(),
    ),
    GetPage(
      name: ClientConstants.routeAboutUs,
      page: () => const AboutUsScreen(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: ClientConstants.routeContact,
      page: () => const ContactScreen(),
      binding: ContactBinding(),
    ),
  ];
}
