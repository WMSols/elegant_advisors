import 'package:flutter/material.dart';
import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_responsive/app_responsive.dart';

class HeaderMobileMenu extends StatelessWidget {
  final VoidCallback? onPressed;

  const HeaderMobileMenu({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.menu,
        color: AppColors.white,
        size: AppResponsive.scaleSize(context, 24, min: 24, max: 28),
      ),
      onPressed: onPressed ?? () {
        // TODO: Implement mobile drawer
      },
    );
  }
}

