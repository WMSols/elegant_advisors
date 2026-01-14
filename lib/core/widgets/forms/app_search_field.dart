import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/widgets/forms/app_text_field.dart';

/// Reusable search field widget
class AppSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final void Function(String)? onFieldSubmitted;

  const AppSearchField({
    super.key,
    this.controller,
    this.hint,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hint: hint ?? 'Search...',
      controller: controller,
      prefixIcon: Icon(
        Iconsax.search_normal,
        size: AppResponsive.scaleSize(context, 20, min: 16, max: 24),
      ),
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: TextInputAction.search,
    );
  }
}
