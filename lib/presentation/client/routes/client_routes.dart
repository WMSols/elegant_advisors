import 'package:get/get.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/presentation/client/bindings/home/client_home_binding.dart';
import 'package:elegant_advisors/presentation/client/screens/home/client_home_screen.dart';
import 'package:elegant_advisors/presentation/client/bindings/properties/client_properties_binding.dart';
import 'package:elegant_advisors/presentation/client/screens/properties/client_properties_screen.dart';
import 'package:elegant_advisors/presentation/client/bindings/properties/client_off_market_binding.dart';
import 'package:elegant_advisors/presentation/client/screens/properties/client_off_market_screen.dart';
import 'package:elegant_advisors/presentation/client/bindings/properties/client_property_detail_binding.dart';
import 'package:elegant_advisors/presentation/client/screens/properties/client_property_detail_screen.dart';
import 'package:elegant_advisors/presentation/client/bindings/contact/client_contact_binding.dart';
import 'package:elegant_advisors/presentation/client/screens/contact/client_contact_screen.dart';
import 'package:elegant_advisors/presentation/client/bindings/contact/my_contacts/client_my_contacts_binding.dart';
import 'package:elegant_advisors/presentation/client/screens/contact/my_contacts/client_my_contacts_screen.dart';

class ClientRoutes {
  ClientRoutes._();

  static final routes = [
    GetPage(
      name: ClientConstants.routeClientHome,
      page: () => const ClientHomeScreen(),
      binding: ClientHomeBinding(),
    ),
    GetPage(
      name: ClientConstants.routeClientProperties,
      page: () => const ClientPropertiesScreen(),
      binding: ClientPropertiesBinding(),
    ),
    GetPage(
      name: ClientConstants.routeClientOffMarket,
      page: () => const ClientOffMarketScreen(),
      binding: ClientOffMarketBinding(),
    ),
    GetPage(
      name: ClientConstants.routeClientPropertyDetail,
      page: () => const ClientPropertyDetailScreen(),
      binding: ClientPropertyDetailBinding(),
    ),
    GetPage(
      name: ClientConstants.routeClientContact,
      page: () => const ClientContactScreen(),
      binding: ClientContactBinding(),
    ),
    GetPage(
      name: ClientConstants.routeClientContacts,
      page: () => const ClientMyContactsScreen(),
      binding: ClientMyContactsBinding(),
    ),
  ];
}
