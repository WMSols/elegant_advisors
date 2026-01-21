import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/widgets/layout/app_footer.dart';
import 'package:elegant_advisors/presentation/client/widgets/layout/app_header.dart';
import 'package:elegant_advisors/presentation/client/widgets/header/header_mobile_drawer.dart';

/// Reusable screen layout for client screens
/// Handles the common structure: Stack with scrollable content and fixed header
class ClientScreenLayout extends StatelessWidget {
  final List<Widget> children;
  final ScrollController? scrollController;
  final Key? scrollViewKey;
  final RxBool? showHeader;
  final bool includeFooter;

  const ClientScreenLayout({
    super.key,
    required this.children,
    this.scrollController,
    this.scrollViewKey,
    this.showHeader,
    this.includeFooter = true,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> contentChildren = List.from(children);
    
    // Add footer if needed
    if (includeFooter) {
      contentChildren.add(const AppFooter());
    }

    return Scaffold(
      drawer: HeaderMobileDrawer(onClose: () => Get.back()),
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            key: scrollViewKey,
            controller: scrollController,
            child: Column(
              children: contentChildren,
            ),
          ),
          // Header always visible, background animates on scroll
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: showHeader != null
                ? Obx(
                    () => AppHeader(showBackground: showHeader!.value),
                  )
                : const AppHeader(),
          ),
        ],
      ),
    );
  }
}
