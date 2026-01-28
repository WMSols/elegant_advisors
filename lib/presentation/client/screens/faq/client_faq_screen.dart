import 'package:flutter/material.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_screen_layout.dart';
import 'package:elegant_advisors/presentation/client/widgets/faq/faq_content_section.dart';

class ClientFaqScreen extends StatelessWidget {
  const ClientFaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClientScreenLayout(
      children: [
        FaqContentSection(),
      ],
    );
  }
}
