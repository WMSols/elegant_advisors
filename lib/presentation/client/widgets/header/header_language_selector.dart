import 'package:elegant_advisors/presentation/admin/controllers/language/language_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/widgets/images/app_error_image_fallback.dart';

class HeaderLanguageSelector extends StatefulWidget {
  const HeaderLanguageSelector({super.key});

  @override
  State<HeaderLanguageSelector> createState() => _HeaderLanguageSelectorState();
}

class _HeaderLanguageSelectorState extends State<HeaderLanguageSelector> {
  late final LanguageController _languageController;

  @override
  void initState() {
    super.initState();
    _languageController = Get.find<LanguageController>();
  }

  void _selectLanguage(Locale locale) {
    _languageController.changeLanguage(locale);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentFlag = _languageController.currentFlagImage;

      return PopupMenuButton<Locale>(
        offset: Offset(
          0,
          AppResponsive.scaleSize(context, 32, min: 28, max: 40),
        ),

        color: Colors.transparent,
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppResponsive.scaleSize(context, 8, min: 4, max: 12),
          ),
          child: Container(
            width: AppResponsive.scaleSize(context, 32, min: 24, max: 25),
            height: AppResponsive.scaleSize(context, 24, min: 20, max: 15),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.white.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: ClipRRect(
              child: Image.asset(
                currentFlag,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return AppErrorImageFallback(
                    iconSize: AppResponsive.scaleSize(
                      context,
                      16,
                      min: 14,
                      max: 20,
                    ),
                    iconColor: AppColors.white,
                    backgroundColor: AppColors.grey.withValues(alpha: 0.3),
                  );
                },
              ),
            ),
          ),
        ),
        itemBuilder: (BuildContext context) {
          final englishFlag = LanguageController.getFlagImageForLocale(
            LanguageController.english,
          );
          final portugueseFlag = LanguageController.getFlagImageForLocale(
            LanguageController.portuguese,
          );
          final isEnglishSelected = _languageController.isLocaleSelected(
            LanguageController.english,
          );
          final isPortugueseSelected = _languageController.isLocaleSelected(
            LanguageController.portuguese,
          );

          return [
            PopupMenuItem<Locale>(
              value: LanguageController.english,
              enabled: true,
              child: _buildLanguageMenuItem(
                context,
                englishFlag,
                isEnglishSelected,
                'English',
              ),
            ),
            PopupMenuItem<Locale>(
              value: LanguageController.portuguese,
              enabled: true,
              child: _buildLanguageMenuItem(
                context,
                portugueseFlag,
                isPortugueseSelected,
                'Portuguese',
              ),
            ),
          ];
        },
        onSelected: (Locale locale) {
          _selectLanguage(locale);
        },
      );
    });
  }

  Widget _buildLanguageMenuItem(
    BuildContext context,
    String flagImage,
    bool isSelected,
    String languageName,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppResponsive.scaleSize(context, 12, min: 8, max: 16),
        vertical: AppResponsive.scaleSize(context, 8, min: 6, max: 10),
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primary.withValues(alpha: 0.3)
            : Colors.transparent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppResponsive.scaleSize(context, 24, min: 20, max: 25),
            height: AppResponsive.scaleSize(context, 18, min: 15, max: 15),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.white.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: ClipRRect(
              child: Image.asset(
                flagImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return AppErrorImageFallback(
                    iconSize: AppResponsive.scaleSize(
                      context,
                      12,
                      min: 10,
                      max: 16,
                    ),
                    iconColor: AppColors.white,
                    backgroundColor: AppColors.grey.withValues(alpha: 0.3),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
