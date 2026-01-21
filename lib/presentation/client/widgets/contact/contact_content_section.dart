import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_background_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/contact/contact_form_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/contact/contact_office_details_section.dart';

/// Contact content section with background
class ContactContentSection extends StatelessWidget {
  const ContactContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ClientBackgroundSection(
      horizontalPadding: 0.04,
      verticalPadding: 0.08,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.vertical(context, 0.1),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 768) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 1, child: const ContactFormSection()),
                    AppSpacing.horizontal(context, 0.04),
                    Expanded(flex: 1, child: const ContactOfficeDetailsSection()),
                  ],
                );
              } else {
                return Column(
                  children: [
                    const ContactFormSection(),
                    AppSpacing.vertical(context, 0.04),
                    const ContactOfficeDetailsSection(),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
