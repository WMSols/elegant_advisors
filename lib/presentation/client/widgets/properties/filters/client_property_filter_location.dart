import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/widgets/forms/app_dropdown_field.dart';

/// Location filter fields (Country and City)
class ClientPropertyFilterLocation extends StatelessWidget {
  final String? country;
  final String? city;
  final List<String> availableCountries;
  final List<String> availableCities;
  final Function(String?) onCountryChanged;
  final Function(String?) onCityChanged;

  const ClientPropertyFilterLocation({
    super.key,
    required this.country,
    required this.city,
    required this.availableCountries,
    required this.availableCities,
    required this.onCountryChanged,
    required this.onCityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Country
        if (availableCountries.isNotEmpty)
          AppDropdownField<String>(
            label: AppTexts.clientPropertiesFilterCountry,
            value: country,
            items: [
              DropdownMenuItem<String>(
                value: null,
                child: Text(AppTexts.clientPropertiesFilterAll),
              ),
              ...availableCountries.map((country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country),
                );
              }),
            ],
            onChanged: onCountryChanged,
            borderColor: AppColors.primary.withValues(alpha: 0.5),
          ),
        if (availableCountries.isNotEmpty) AppSpacing.vertical(context, 0.015),
        // City
        if (availableCities.isNotEmpty)
          AppDropdownField<String>(
            label: AppTexts.clientPropertiesFilterCity,
            value: city,
            items: [
              DropdownMenuItem<String>(
                value: null,
                child: Text(AppTexts.clientPropertiesFilterAll),
              ),
              ...availableCities.map((city) {
                return DropdownMenuItem<String>(value: city, child: Text(city));
              }),
            ],
            onChanged: onCityChanged,
            borderColor: AppColors.primary.withValues(alpha: 0.5),
          ),
      ],
    );
  }
}
