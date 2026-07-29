import 'package:flutter/material.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_screen_layout.dart';
import 'package:elegant_advisors/presentation/client/widgets/services/services_content_section.dart';

class ClientServicesScreen extends StatelessWidget {
  const ClientServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClientScreenLayout(children: [ServicesContentSection()]);
  }
}
