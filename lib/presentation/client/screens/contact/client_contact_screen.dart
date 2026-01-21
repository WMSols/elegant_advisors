import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_screen_layout.dart';
import 'package:elegant_advisors/presentation/client/controllers/contact/client_contact_controller.dart';
import 'package:elegant_advisors/presentation/client/widgets/contact/contact_content_section.dart';

class ClientContactScreen extends GetView<ClientContactController> {
  const ClientContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ClientScreenLayout(
      scrollController: controller.scrollController,
      scrollViewKey: controller.scrollViewKey,
      showHeader: controller.showHeader,
      children: [
        // Contact Content Section with Background
        const ContactContentSection(),
      ],
    );
  }
}
