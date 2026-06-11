import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_images/app_images.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';

/// Reusable logo widget displaying the app logo image.
class AppLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;

  const AppLogo({
    super.key,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    final logoWidth =
        width ?? AppResponsive.fontSizeClamped(context, min: 120, max: 180);
    final logoHeight = height ?? (logoWidth * 0.35);

    return Image.asset(
      AppImages.appLogo,
      width: logoWidth,
      height: logoHeight,
      fit: fit,
      color: color,
      colorBlendMode: color != null ? BlendMode.srcIn : null,
      filterQuality: FilterQuality.high,
    );
  }
}
