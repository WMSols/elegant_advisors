import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_images/app_images.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_background_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/contact/my_contacts/my_contacts_listing_content.dart';

/// My contacts listing section with background
class MyContactsListingSection extends StatelessWidget {
  const MyContactsListingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ClientBackgroundSection(
      backgroundImage: AppImages.homeBackground,
      horizontalPadding: 0.1,
      verticalPadding: 0.15,
      child: const MyContactsListingContent(),
    );
  }
}
