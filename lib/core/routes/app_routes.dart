import 'package:get/get.dart';
import '../../presentation/bindings/home/home_binding.dart';
import '../../presentation/pages/home/home_page.dart';
import '../../presentation/bindings/what_we_do/what_we_do_binding.dart';
import '../../presentation/pages/what_we_do/what_we_do_page.dart';
import '../../presentation/bindings/how_we_do_it/how_we_do_it_binding.dart';
import '../../presentation/pages/how_we_do_it/how_we_do_it_page.dart';
import '../../presentation/bindings/why_elegant/why_elegant_binding.dart';
import '../../presentation/pages/why_elegant/why_elegant_page.dart';
import '../../presentation/bindings/services/services_binding.dart';
import '../../presentation/pages/services/services_page.dart';
import '../../presentation/bindings/properties/properties_binding.dart';
import '../../presentation/pages/properties/properties_page.dart';
import '../../presentation/bindings/insights/insights_binding.dart';
import '../../presentation/pages/insights/insights_page.dart';
import '../../presentation/bindings/golden_visa/golden_visa_binding.dart';
import '../../presentation/pages/golden_visa/golden_visa_page.dart';
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
      name: AppConstants.routeWhatWeDo,
      page: () => const WhatWeDoPage(),
      binding: WhatWeDoBinding(),
    ),
    GetPage(
      name: AppConstants.routeHowWeDoIt,
      page: () => const HowWeDoItPage(),
      binding: HowWeDoItBinding(),
    ),
    GetPage(
      name: AppConstants.routeWhyElegant,
      page: () => const WhyElegantPage(),
      binding: WhyElegantBinding(),
    ),
    GetPage(
      name: AppConstants.routeServices,
      page: () => const ServicesPage(),
      binding: ServicesBinding(),
    ),
    GetPage(
      name: AppConstants.routeProperties,
      page: () => const PropertiesPage(),
      binding: PropertiesBinding(),
    ),
    GetPage(
      name: AppConstants.routeInsights,
      page: () => const InsightsPage(),
      binding: InsightsBinding(),
    ),
    GetPage(
      name: AppConstants.routeGoldenVisa,
      page: () => const GoldenVisaPage(),
      binding: GoldenVisaBinding(),
    ),
    GetPage(
      name: AppConstants.routeContact,
      page: () => const ContactPage(),
      binding: ContactBinding(),
    ),
  ];
}

