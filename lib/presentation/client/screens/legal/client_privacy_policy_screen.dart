import 'package:flutter/material.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_screen_layout.dart';
import 'package:elegant_advisors/presentation/client/widgets/legal/privacy_policy_content_section.dart';

class ClientPrivacyPolicyScreen extends StatelessWidget {
  const ClientPrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClientScreenLayout(children: [PrivacyPolicyContentSection()]);
  }
}
