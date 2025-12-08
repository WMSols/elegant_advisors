import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_responsive/app_responsive.dart';
import '../../../core/utils/app_styles/app_text_styles.dart';

class HeaderGoldenVisaDropdown extends StatelessWidget {
  final String selectedOption;
  final Function(String) onOptionSelected;

  const HeaderGoldenVisaDropdown({
    super.key,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DropdownOption(
            label: 'IFICI',
            isSelected: selectedOption == 'IFICI',
            onTap: () {
              onOptionSelected('IFICI');
              // Navigate to IFICI page or handle selection
            },
          ),
          // Add more options as needed
        ],
      ),
    );
  }
}

class _DropdownOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DropdownOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppResponsive.scaleSize(context, 16, min: 12, max: 20),
          vertical: AppResponsive.scaleSize(context, 12, min: 10, max: 16),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: AppTextStyles.bodyText(context).copyWith(
                color: isSelected ? AppColors.primary : AppColors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

