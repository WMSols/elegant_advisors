import 'package:flutter/material.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_screen_layout.dart';
import 'package:elegant_advisors/presentation/client/widgets/legal/terms_of_service_content_section.dart';

class ClientTermsOfServiceScreen extends StatelessWidget {
  const ClientTermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClientScreenLayout(children: [TermsOfServiceContentSection()]);
  }
}
