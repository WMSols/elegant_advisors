import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_screen_layout.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_off_market_controller.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/header/off_market_header_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/contact/off_market_content_section.dart';

class ClientOffMarketScreen extends GetView<ClientOffMarketController> {
  const ClientOffMarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ClientScreenLayout(
      scrollController: controller.scrollController,
      scrollViewKey: controller.scrollViewKey,
      showHeader: controller.showHeader,
      children: [
        OffMarketHeaderSection(controller: controller),
        OffMarketContentSection(key: controller.formSectionKey),
      ],
    );
  }
}
