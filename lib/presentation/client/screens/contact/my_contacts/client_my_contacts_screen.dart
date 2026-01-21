import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_screen_layout.dart';
import 'package:elegant_advisors/presentation/client/controllers/contact/my_contacts/client_my_contacts_controller.dart';
import 'package:elegant_advisors/presentation/client/widgets/contact/my_contacts/my_contacts_listing_section.dart';

class ClientMyContactsScreen extends GetView<ClientMyContactsController> {
  const ClientMyContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ClientScreenLayout(
      scrollController: controller.scrollController,
      scrollViewKey: controller.scrollViewKey,
      showHeader: controller.showHeader,
      children: [
        // My Contacts Listing Section
        const MyContactsListingSection(),
      ],
    );
  }
}
