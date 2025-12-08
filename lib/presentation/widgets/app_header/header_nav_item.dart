import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_responsive/app_responsive.dart';
import '../../../core/utils/app_styles/app_text_styles.dart';
import '../../../core/utils/app_texts/app_texts.dart';
import 'header_golden_visa_dropdown.dart';

class HeaderNavItem extends StatefulWidget {
  final String label;
  final String route;
  final List<String>? submenuOptions;

  const HeaderNavItem({
    super.key,
    required this.label,
    required this.route,
    this.submenuOptions,
  });

  @override
  State<HeaderNavItem> createState() => _HeaderNavItemState();
}

class _HeaderNavItemState extends State<HeaderNavItem> {
  bool _isHovered = false;
  bool _showDropdown = false;
  String _selectedOption = 'IFICI';

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;
    final isActive = currentRoute == widget.route;
    final isGoldenVisa = widget.label == AppTexts.navGoldenVisa;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppResponsive.scaleSize(context, 8, min: 4, max: 12),
      ),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovered = true;
            if (isGoldenVisa) {
              _showDropdown = true;
            }
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false;
            if (isGoldenVisa) {
              _showDropdown = false;
            }
          });
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            TextButton(
              onPressed: () {
                if (!isGoldenVisa) {
                  Get.toNamed(widget.route);
                }
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: AppResponsive.scaleSize(context, 10, min: 6, max: 16),
                  vertical: AppResponsive.screenHeight(context) * 0.01,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.label,
                        style: AppTextStyles.bodyText(context).copyWith(
                          color: AppColors.white,
                          letterSpacing: 0.5,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (isGoldenVisa)
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 10,
                            color: AppColors.white.withValues(alpha:0.7),
                          ),
                        ),
                    ],
                  ),
                  if (_isHovered || isActive)
                    Container(
                      margin: EdgeInsets.only(
                        top: AppResponsive.scaleSize(context, 4, min: 4, max: 6),
                      ),
                      height: 1,
                      width: AppResponsive.scaleSize(context, 20, min: 15, max: 25),
                      color: AppColors.white,
                    ),
                ],
              ),
            ),
            // Dropdown for Golden Visa
            if (isGoldenVisa && _showDropdown)
              Positioned(
                top: 40,
                left: 0,
                child: MouseRegion(
                  onEnter: (_) => setState(() {
                    _showDropdown = true;
                    _isHovered = true;
                  }),
                  onExit: (_) => setState(() {
                    _showDropdown = false;
                    _isHovered = false;
                  }),
                  child: HeaderGoldenVisaDropdown(
                    selectedOption: _selectedOption,
                    onOptionSelected: (option) {
                      setState(() {
                        _selectedOption = option;
                        _showDropdown = false;
                        _isHovered = false;
                      });
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

