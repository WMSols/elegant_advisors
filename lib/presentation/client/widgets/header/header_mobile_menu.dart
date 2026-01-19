import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_icon_button.dart';

class HeaderMobileMenu extends StatelessWidget {
  const HeaderMobileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return AppIconButton(
          icon: Iconsax.menu_14,
          color: AppColors.white,
          iconSize: AppResponsive.scaleSize(context, 24, min: 24, max: 28),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: 'Menu',
        );
      },
    );
  }
}
