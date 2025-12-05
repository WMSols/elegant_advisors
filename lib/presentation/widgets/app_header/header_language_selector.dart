import 'package:flutter/material.dart';
import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_images/app_images.dart';
import '../../../core/utils/app_responsive/app_responsive.dart';
import 'header_language_option.dart';

class HeaderLanguageSelector extends StatefulWidget {
  final String selectedLanguage;
  final Function(String) onLanguageSelected;

  const HeaderLanguageSelector({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageSelected,
  });

  @override
  State<HeaderLanguageSelector> createState() => _HeaderLanguageSelectorState();
}

class _HeaderLanguageSelectorState extends State<HeaderLanguageSelector> {
  bool _showDropdown = false;

  void _toggleDropdown() {
    setState(() {
      _showDropdown = !_showDropdown;
    });
  }

  void _selectLanguage(String language) {
    widget.onLanguageSelected(language);
    setState(() {
      _showDropdown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleDropdown,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Default flag button
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppResponsive.scaleSize(context, 8, min: 4, max: 12),
            ),
            child: Container(
              width: AppResponsive.scaleSize(context, 32, min: 24, max: 25),
              height: AppResponsive.scaleSize(context, 24, min: 20, max: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppColors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  widget.selectedLanguage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.grey.withOpacity(0.3),
                      child: Icon(
                        Icons.flag,
                        size: AppResponsive.scaleSize(context, 16, min: 14, max: 20),
                        color: AppColors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // Dropdown menu
          if (_showDropdown)
            Positioned(
              top: AppResponsive.scaleSize(context, 32, min: 28, max: 40),
              right: 0,
              child: GestureDetector(
                onTap: () {}, // Prevent tap from closing dropdown
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HeaderLanguageOption(
                          flagImage: AppImages.englandFlag,
                          isSelected: widget.selectedLanguage == AppImages.englandFlag,
                          onTap: () => _selectLanguage(AppImages.englandFlag),
                        ),
                        HeaderLanguageOption(
                          flagImage: AppImages.portugalFlag,
                          isSelected: widget.selectedLanguage == AppImages.portugalFlag,
                          onTap: () => _selectLanguage(AppImages.portugalFlag),
                        ),
                        HeaderLanguageOption(
                          flagImage: AppImages.franceFlag,
                          isSelected: widget.selectedLanguage == AppImages.franceFlag,
                          onTap: () => _selectLanguage(AppImages.franceFlag),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

