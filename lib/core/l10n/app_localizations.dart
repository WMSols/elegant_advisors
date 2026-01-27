import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @webName.
  ///
  /// In en, this message translates to:
  /// **'Elegant Advisors'**
  String get webName;

  /// No description provided for @logoTitle.
  ///
  /// In en, this message translates to:
  /// **'ELEGANT'**
  String get logoTitle;

  /// No description provided for @logoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'REAL ESTATE'**
  String get logoSubtitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navProperties.
  ///
  /// In en, this message translates to:
  /// **'Properties'**
  String get navProperties;

  /// No description provided for @navOffMarket.
  ///
  /// In en, this message translates to:
  /// **'Off Market'**
  String get navOffMarket;

  /// No description provided for @navContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get navContact;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'ELEGANCE, INTEGRITY, TRANSPARENCY'**
  String get homeTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Elegant is a real estate advisory defined by a singular philosophy: real estate, at its finest, is an art of elegance. We curate exceptional property opportunities in Portugal, guided by discretion, market insight, and uncompromising standards.'**
  String get homeSubtitle;

  /// No description provided for @homeButtonConsultation.
  ///
  /// In en, this message translates to:
  /// **'Request A Private Consultation'**
  String get homeButtonConsultation;

  /// No description provided for @homeOurApproachTitle.
  ///
  /// In en, this message translates to:
  /// **'OUR APPROACH'**
  String get homeOurApproachTitle;

  /// No description provided for @homeOurApproachDescription.
  ///
  /// In en, this message translates to:
  /// **'We combine deep market intelligence with strong local and international networks to deliver tailored advisory services across the full investment lifecycle — from strategy definition and asset sourcing to acquisition, due diligence, structuring, and closing. Each client receives discreet, data-driven guidance aligned with their financial objectives, risk profile, and investment horizon.'**
  String get homeOurApproachDescription;

  /// No description provided for @homeOurApproachButton.
  ///
  /// In en, this message translates to:
  /// **'What We Do'**
  String get homeOurApproachButton;

  /// No description provided for @homeOurPhilosophyMissionTitle.
  ///
  /// In en, this message translates to:
  /// **'OUR PHILOSOPHY\n& MISSION'**
  String get homeOurPhilosophyMissionTitle;

  /// No description provided for @homeOurPhilosophyMissionDescription.
  ///
  /// In en, this message translates to:
  /// **'Elegance, integrity, and transparency define how we operate. At Elegant, we believe in quality over volume — carefully curating residential, commercial, and hospitality opportunities that align precisely with each client\'s lifestyle ambitions or investment strategy.'**
  String get homeOurPhilosophyMissionDescription;

  /// No description provided for @homeOurPhilosophyTitle.
  ///
  /// In en, this message translates to:
  /// **'OUR PHILOSOPHY'**
  String get homeOurPhilosophyTitle;

  /// No description provided for @homeOurPhilosophyDescription.
  ///
  /// In en, this message translates to:
  /// **'Elegance, integrity, and transparency define how we operate. At Elegant, we believe in quality over volume — carefully curating residential, commercial, and hospitality opportunities that align precisely with each client\'s lifestyle ambitions or investment strategy.'**
  String get homeOurPhilosophyDescription;

  /// No description provided for @homeOurMissionTitle.
  ///
  /// In en, this message translates to:
  /// **'OUR MISSION'**
  String get homeOurMissionTitle;

  /// No description provided for @homeOurMissionDescription.
  ///
  /// In en, this message translates to:
  /// **'Our mission is to deliver clarity and sophistication at every stage of the property journey, ensuring each acquisition is as seamless as it is distinguished.'**
  String get homeOurMissionDescription;

  /// No description provided for @homeWhatWeSpecializeInTitle.
  ///
  /// In en, this message translates to:
  /// **'WHAT WE SPECIALIZE IN'**
  String get homeWhatWeSpecializeInTitle;

  /// No description provided for @homeWhatWeSpecializeInDescription.
  ///
  /// In en, this message translates to:
  /// **'We specialize in curating exceptional property opportunities across multiple asset classes, each tailored to meet distinct investment objectives and lifestyle aspirations.'**
  String get homeWhatWeSpecializeInDescription;

  /// No description provided for @homeWhatWeSpecializeInHighEndResidentialTitle.
  ///
  /// In en, this message translates to:
  /// **'HIGH-END RESIDENTIAL ASSETS'**
  String get homeWhatWeSpecializeInHighEndResidentialTitle;

  /// No description provided for @homeWhatWeSpecializeInHighEndResidentialDescription.
  ///
  /// In en, this message translates to:
  /// **'Luxury villas, premium apartments, and exclusive residential properties in prime locations — curated for lifestyle buyers and investors seeking long-term capital appreciation.'**
  String get homeWhatWeSpecializeInHighEndResidentialDescription;

  /// No description provided for @homeWhatWeSpecializeInInvestmentPlotsTitle.
  ///
  /// In en, this message translates to:
  /// **'INVESTMENT PLOTS & DEVELOPMENT LAND'**
  String get homeWhatWeSpecializeInInvestmentPlotsTitle;

  /// No description provided for @homeWhatWeSpecializeInInvestmentPlotsDescription.
  ///
  /// In en, this message translates to:
  /// **'Strategic land opportunities for residential, commercial, and hospitality developments. Suitable for developers, asset managers, private equity funds, and long-term investors seeking scalable growth.'**
  String get homeWhatWeSpecializeInInvestmentPlotsDescription;

  /// No description provided for @homeWhatWeSpecializeInInvestmentBuildingsTitle.
  ///
  /// In en, this message translates to:
  /// **'INVESTMENT BUILDINGS'**
  String get homeWhatWeSpecializeInInvestmentBuildingsTitle;

  /// No description provided for @homeWhatWeSpecializeInInvestmentBuildingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Entire buildings requiring renovation, refurbishment, or redevelopment for residential or commercial use. Ideal for developers, asset managers, private equity funds, and investors pursuing value-add and repositioning strategies.'**
  String get homeWhatWeSpecializeInInvestmentBuildingsDescription;

  /// No description provided for @homeWhatWeSpecializeInCommercialRealEstateTitle.
  ///
  /// In en, this message translates to:
  /// **'COMMERCIAL REAL ESTATE'**
  String get homeWhatWeSpecializeInCommercialRealEstateTitle;

  /// No description provided for @homeWhatWeSpecializeInCommercialRealEstateDescription.
  ///
  /// In en, this message translates to:
  /// **'Retail, office, parking, and industrial assets — including income-generating properties with stable tenants and strong yield profiles.'**
  String get homeWhatWeSpecializeInCommercialRealEstateDescription;

  /// No description provided for @homeWhatWeSpecializeInHospitalityTitle.
  ///
  /// In en, this message translates to:
  /// **'HOSPITALITY & HOTEL INVESTMENTS'**
  String get homeWhatWeSpecializeInHospitalityTitle;

  /// No description provided for @homeWhatWeSpecializeInHospitalityDescription.
  ///
  /// In en, this message translates to:
  /// **'A dedicated focus on hotels, serviced apartments, boutique hotels, resorts, and mixed-use hospitality developments. We advise on acquisitions, repositioning opportunities, operational assets, and development-led projects — targeting both yield and value creation.'**
  String get homeWhatWeSpecializeInHospitalityDescription;

  /// No description provided for @homeWhatWeSpecializeInButton.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get homeWhatWeSpecializeInButton;

  /// No description provided for @homeOurPortfolioTitle.
  ///
  /// In en, this message translates to:
  /// **'OUR PORTFOLIO'**
  String get homeOurPortfolioTitle;

  /// No description provided for @homeOurPortfolioSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Discover Our Curated Selection'**
  String get homeOurPortfolioSubtitle;

  /// No description provided for @homeOurPortfolioDescription.
  ///
  /// In en, this message translates to:
  /// **'Explore our handpicked collection of exceptional properties'**
  String get homeOurPortfolioDescription;

  /// No description provided for @homeOurPortfolioButton.
  ///
  /// In en, this message translates to:
  /// **'Request a Private Consultation'**
  String get homeOurPortfolioButton;

  /// No description provided for @propertiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Properties'**
  String get propertiesTitle;

  /// No description provided for @propertiesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Property Listings for Sale'**
  String get propertiesSubtitle;

  /// No description provided for @propertiesDescription.
  ///
  /// In en, this message translates to:
  /// **'Browse our curated selection of premium properties available for purchase.'**
  String get propertiesDescription;

  /// No description provided for @offMarketTitle.
  ///
  /// In en, this message translates to:
  /// **'Off Market'**
  String get offMarketTitle;

  /// No description provided for @offMarketSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Exclusive Off Market Opportunities'**
  String get offMarketSubtitle;

  /// No description provided for @offMarketDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover our curated selection of exclusive off-market properties available through private consultation.'**
  String get offMarketDescription;

  /// No description provided for @offMarketViewProperties.
  ///
  /// In en, this message translates to:
  /// **'View Off Market Properties'**
  String get offMarketViewProperties;

  /// No description provided for @clientOffMarketErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'Failed to load off-market properties'**
  String get clientOffMarketErrorLoading;

  /// No description provided for @clientOffMarketRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get clientOffMarketRetry;

  /// No description provided for @clientOffMarketNoPropertiesFound.
  ///
  /// In en, this message translates to:
  /// **'No off-market properties found'**
  String get clientOffMarketNoPropertiesFound;

  /// No description provided for @clientOffMarketNoPropertiesMessage.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find any off-market properties matching your criteria. Try adjusting your filters.'**
  String get clientOffMarketNoPropertiesMessage;

  /// No description provided for @clientOffMarketClearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get clientOffMarketClearFilters;

  /// No description provided for @clientPropertiesShowMore.
  ///
  /// In en, this message translates to:
  /// **'Show More'**
  String get clientPropertiesShowMore;

  /// No description provided for @clientPropertiesShowLess.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get clientPropertiesShowLess;

  /// No description provided for @clientPropertiesPriceOnRequest.
  ///
  /// In en, this message translates to:
  /// **'Price on Request'**
  String get clientPropertiesPriceOnRequest;

  /// No description provided for @clientPropertiesViewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get clientPropertiesViewDetails;

  /// No description provided for @clientPropertiesNoPropertiesFound.
  ///
  /// In en, this message translates to:
  /// **'No properties found'**
  String get clientPropertiesNoPropertiesFound;

  /// No description provided for @clientPropertiesNoPropertiesMessage.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find any properties matching your criteria. Try adjusting your filters.'**
  String get clientPropertiesNoPropertiesMessage;

  /// No description provided for @clientPropertiesClearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get clientPropertiesClearFilters;

  /// No description provided for @clientPropertiesErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'Failed to load properties'**
  String get clientPropertiesErrorLoading;

  /// No description provided for @clientPropertiesRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get clientPropertiesRetry;

  /// No description provided for @clientPropertiesFilters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get clientPropertiesFilters;

  /// No description provided for @clientPropertiesSortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get clientPropertiesSortBy;

  /// No description provided for @clientPropertiesSortPriceLowHigh.
  ///
  /// In en, this message translates to:
  /// **'Price: Low to High'**
  String get clientPropertiesSortPriceLowHigh;

  /// No description provided for @clientPropertiesSortPriceHighLow.
  ///
  /// In en, this message translates to:
  /// **'Price: High to Low'**
  String get clientPropertiesSortPriceHighLow;

  /// No description provided for @clientPropertiesSortNewest.
  ///
  /// In en, this message translates to:
  /// **'Newest First'**
  String get clientPropertiesSortNewest;

  /// No description provided for @clientPropertiesSortFeatured.
  ///
  /// In en, this message translates to:
  /// **'Featured First'**
  String get clientPropertiesSortFeatured;

  /// No description provided for @clientPropertiesSortAlphabetical.
  ///
  /// In en, this message translates to:
  /// **'Alphabetical'**
  String get clientPropertiesSortAlphabetical;

  /// No description provided for @clientPropertiesFilterPropertyType.
  ///
  /// In en, this message translates to:
  /// **'Property Type'**
  String get clientPropertiesFilterPropertyType;

  /// No description provided for @clientPropertiesFilterLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get clientPropertiesFilterLocation;

  /// No description provided for @clientPropertiesFilterCountry.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get clientPropertiesFilterCountry;

  /// No description provided for @clientPropertiesFilterCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get clientPropertiesFilterCity;

  /// No description provided for @clientPropertiesFilterPriceRange.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get clientPropertiesFilterPriceRange;

  /// No description provided for @clientPropertiesFilterBedrooms.
  ///
  /// In en, this message translates to:
  /// **'Bedrooms'**
  String get clientPropertiesFilterBedrooms;

  /// No description provided for @clientPropertiesFilterBathrooms.
  ///
  /// In en, this message translates to:
  /// **'Bathrooms'**
  String get clientPropertiesFilterBathrooms;

  /// No description provided for @clientPropertiesFilterStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get clientPropertiesFilterStatus;

  /// No description provided for @clientPropertiesFilterFeatured.
  ///
  /// In en, this message translates to:
  /// **'Featured Only'**
  String get clientPropertiesFilterFeatured;

  /// No description provided for @clientPropertiesFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get clientPropertiesFilterAll;

  /// No description provided for @clientPropertiesPaginationShowing.
  ///
  /// In en, this message translates to:
  /// **'Showing'**
  String get clientPropertiesPaginationShowing;

  /// No description provided for @clientPropertiesPaginationOf.
  ///
  /// In en, this message translates to:
  /// **'of'**
  String get clientPropertiesPaginationOf;

  /// No description provided for @clientPropertiesPaginationResults.
  ///
  /// In en, this message translates to:
  /// **'results'**
  String get clientPropertiesPaginationResults;

  /// No description provided for @clientPropertyDetailInquire.
  ///
  /// In en, this message translates to:
  /// **'Inquire About This Property'**
  String get clientPropertyDetailInquire;

  /// No description provided for @clientPropertyDetailSpecifications.
  ///
  /// In en, this message translates to:
  /// **'Specifications'**
  String get clientPropertyDetailSpecifications;

  /// No description provided for @clientPropertyDetailFeatures.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get clientPropertyDetailFeatures;

  /// No description provided for @clientPropertyDetailLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get clientPropertyDetailLocation;

  /// No description provided for @clientPropertyDetailDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get clientPropertyDetailDescription;

  /// No description provided for @clientPropertyDetailRelatedProperties.
  ///
  /// In en, this message translates to:
  /// **'Related Properties'**
  String get clientPropertyDetailRelatedProperties;

  /// No description provided for @clientPropertyDetailNotFound.
  ///
  /// In en, this message translates to:
  /// **'Property not found'**
  String get clientPropertyDetailNotFound;

  /// No description provided for @clientPropertyDetailBreadcrumbHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get clientPropertyDetailBreadcrumbHome;

  /// No description provided for @clientPropertyDetailBreadcrumbProperties.
  ///
  /// In en, this message translates to:
  /// **'Properties'**
  String get clientPropertyDetailBreadcrumbProperties;

  /// No description provided for @clientPropertyDetailNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'The property you are looking for could not be found.'**
  String get clientPropertyDetailNotFoundMessage;

  /// No description provided for @contactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactTitle;

  /// No description provided for @contactFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Send Us a Message'**
  String get contactFormTitle;

  /// No description provided for @contactFormName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get contactFormName;

  /// No description provided for @contactFormEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get contactFormEmail;

  /// No description provided for @contactFormPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get contactFormPhone;

  /// No description provided for @contactFormMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get contactFormMessage;

  /// No description provided for @contactFormButton.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get contactFormButton;

  /// No description provided for @contactOfficeTitle.
  ///
  /// In en, this message translates to:
  /// **'Elegant Advisors Office'**
  String get contactOfficeTitle;

  /// No description provided for @contactOfficeAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get contactOfficeAddress;

  /// No description provided for @contactOfficePhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get contactOfficePhone;

  /// No description provided for @contactOfficeEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get contactOfficeEmail;

  /// No description provided for @contactOfficeHours.
  ///
  /// In en, this message translates to:
  /// **'Working Hours'**
  String get contactOfficeHours;

  /// No description provided for @footerTagline.
  ///
  /// In en, this message translates to:
  /// **'Elegant Advisors - Your Trusted Property & Asset Advisory Partner'**
  String get footerTagline;

  /// No description provided for @footerCopyright.
  ///
  /// In en, this message translates to:
  /// **'© {year} Elegant Advisors. All rights reserved.'**
  String footerCopyright(int year);

  /// No description provided for @contactSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your message has been sent successfully!'**
  String get contactSuccessMessage;

  /// No description provided for @contactSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get contactSuccessTitle;

  /// No description provided for @myContactsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Contacts'**
  String get myContactsTitle;

  /// No description provided for @myContactsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View Your Contact Submissions'**
  String get myContactsSubtitle;

  /// No description provided for @myContactsDescription.
  ///
  /// In en, this message translates to:
  /// **'Track the status of your contact submissions and inquiries.'**
  String get myContactsDescription;

  /// No description provided for @myContactsEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email'**
  String get myContactsEnterEmail;

  /// No description provided for @myContactsEnterEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter email address'**
  String get myContactsEnterEmailHint;

  /// No description provided for @myContactsViewContacts.
  ///
  /// In en, this message translates to:
  /// **'View My Contacts'**
  String get myContactsViewContacts;

  /// No description provided for @myContactsNoContactsFound.
  ///
  /// In en, this message translates to:
  /// **'No contacts found'**
  String get myContactsNoContactsFound;

  /// No description provided for @myContactsNoContactsMessage.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t submitted any contact forms yet, or no contacts match your email address.'**
  String get myContactsNoContactsMessage;

  /// No description provided for @myContactsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get myContactsFilterAll;

  /// No description provided for @myContactsFilterNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get myContactsFilterNew;

  /// No description provided for @myContactsFilterInProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get myContactsFilterInProgress;

  /// No description provided for @myContactsFilterClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get myContactsFilterClosed;

  /// No description provided for @myContactsStatusNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get myContactsStatusNew;

  /// No description provided for @myContactsStatusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get myContactsStatusInProgress;

  /// No description provided for @myContactsStatusClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get myContactsStatusClosed;

  /// No description provided for @myContactsDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get myContactsDate;

  /// No description provided for @myContactsSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get myContactsSubject;

  /// No description provided for @myContactsMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get myContactsMessage;

  /// No description provided for @myContactsProperty.
  ///
  /// In en, this message translates to:
  /// **'Property'**
  String get myContactsProperty;

  /// No description provided for @myContactsNoProperty.
  ///
  /// In en, this message translates to:
  /// **'General Inquiry'**
  String get myContactsNoProperty;

  /// No description provided for @myContactsErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'Failed to load contacts'**
  String get myContactsErrorLoading;

  /// No description provided for @myContactsRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get myContactsRetry;

  /// No description provided for @myContactsClearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get myContactsClearFilters;

  /// No description provided for @myContactsFilters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get myContactsFilters;

  /// No description provided for @commonGoBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get commonGoBack;

  /// No description provided for @commonGoHome.
  ///
  /// In en, this message translates to:
  /// **'Go Home'**
  String get commonGoHome;

  /// No description provided for @commonMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get commonMenu;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonPageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get commonPageNotFound;

  /// No description provided for @commonSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get commonSuccess;

  /// No description provided for @commonError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get commonError;

  /// No description provided for @commonInfo.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get commonInfo;

  /// No description provided for @commonWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get commonWarning;

  /// No description provided for @appTitleClient.
  ///
  /// In en, this message translates to:
  /// **'Elegant Advisors'**
  String get appTitleClient;

  /// No description provided for @appTitleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Elegant Advisors - Admin'**
  String get appTitleAdmin;

  /// No description provided for @locationGoogleMapsError.
  ///
  /// In en, this message translates to:
  /// **'Could not open Google Maps'**
  String get locationGoogleMapsError;

  /// No description provided for @footerQuickLinksTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Links'**
  String get footerQuickLinksTitle;

  /// No description provided for @footerLinkMyContacts.
  ///
  /// In en, this message translates to:
  /// **'View My Contacts'**
  String get footerLinkMyContacts;

  /// No description provided for @footerLinkPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get footerLinkPrivacyPolicy;

  /// No description provided for @footerLinkTermsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get footerLinkTermsOfService;

  /// No description provided for @footerCompanyDescription.
  ///
  /// In en, this message translates to:
  /// **'Elegant is a real estate advisory defined by a singular philosophy: real estate, at its finest, is an art of elegance. We curate exceptional property opportunities in Portugal, guided by discretion, market insight, and uncompromising standards.'**
  String get footerCompanyDescription;

  /// No description provided for @footerSocialTitle.
  ///
  /// In en, this message translates to:
  /// **'Follow Us'**
  String get footerSocialTitle;

  /// No description provided for @clientPropertiesViewProperties.
  ///
  /// In en, this message translates to:
  /// **'View Properties'**
  String get clientPropertiesViewProperties;

  /// No description provided for @clientPropertyDetailErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'Failed to load property'**
  String get clientPropertyDetailErrorLoading;

  /// No description provided for @contactFormEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please provide a valid email address.'**
  String get contactFormEmailInvalid;

  /// No description provided for @contactFormSpamDetected.
  ///
  /// In en, this message translates to:
  /// **'Your message contains inappropriate content.'**
  String get contactFormSpamDetected;

  /// No description provided for @contactFormSubjectInquiryAbout.
  ///
  /// In en, this message translates to:
  /// **'Inquiry about {propertyTitle}'**
  String contactFormSubjectInquiryAbout(String propertyTitle);

  /// No description provided for @contactFormSubjectGeneralInquiry.
  ///
  /// In en, this message translates to:
  /// **'General Inquiry'**
  String get contactFormSubjectGeneralInquiry;

  /// No description provided for @myContactsEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get myContactsEmailInvalid;

  /// No description provided for @myContactsErrorIndex.
  ///
  /// In en, this message translates to:
  /// **'Failed to load contacts. Please ensure Firestore indexes are created. Check the Firebase console for index creation links.'**
  String get myContactsErrorIndex;

  /// No description provided for @myContactsErrorLoadingGeneric.
  ///
  /// In en, this message translates to:
  /// **'Failed to load contacts. Please try again.'**
  String get myContactsErrorLoadingGeneric;

  /// No description provided for @contactFormErrorSubmit.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit. Please try again.'**
  String get contactFormErrorSubmit;

  /// No description provided for @clientPropertiesFilterPriceMin.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get clientPropertiesFilterPriceMin;

  /// No description provided for @clientPropertiesFilterPriceMax.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get clientPropertiesFilterPriceMax;

  /// No description provided for @clientPropertiesFilterPriceCurrency.
  ///
  /// In en, this message translates to:
  /// **'€ '**
  String get clientPropertiesFilterPriceCurrency;

  /// No description provided for @headerLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get headerLanguageEnglish;

  /// No description provided for @headerLanguagePortuguese.
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get headerLanguagePortuguese;

  /// No description provided for @clientPropertiesStatusAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get clientPropertiesStatusAvailable;

  /// No description provided for @clientPropertiesStatusSold.
  ///
  /// In en, this message translates to:
  /// **'Sold'**
  String get clientPropertiesStatusSold;

  /// No description provided for @clientPropertiesStatusComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get clientPropertiesStatusComingSoon;

  /// No description provided for @clientPropertiesStatusOffMarket.
  ///
  /// In en, this message translates to:
  /// **'Off Market'**
  String get clientPropertiesStatusOffMarket;

  /// No description provided for @contactOfficeAddressValue.
  ///
  /// In en, this message translates to:
  /// **'123 Main Street, Lisbon, Portugal'**
  String get contactOfficeAddressValue;

  /// No description provided for @contactOfficePhoneValue.
  ///
  /// In en, this message translates to:
  /// **'+351 123 456 789'**
  String get contactOfficePhoneValue;

  /// No description provided for @contactOfficeEmailValue.
  ///
  /// In en, this message translates to:
  /// **'info@elegantadvisors.com'**
  String get contactOfficeEmailValue;

  /// No description provided for @contactOfficeHoursValue.
  ///
  /// In en, this message translates to:
  /// **'Monday - Friday: 9:00 AM - 6:00 PM'**
  String get contactOfficeHoursValue;

  /// No description provided for @clientPropertyCardBed.
  ///
  /// In en, this message translates to:
  /// **'bed'**
  String get clientPropertyCardBed;

  /// No description provided for @clientPropertyCardBath.
  ///
  /// In en, this message translates to:
  /// **'bath'**
  String get clientPropertyCardBath;

  /// No description provided for @clientPropertyDetailSpecType.
  ///
  /// In en, this message translates to:
  /// **'Type:'**
  String get clientPropertyDetailSpecType;

  /// No description provided for @clientPropertyDetailSpecBedrooms.
  ///
  /// In en, this message translates to:
  /// **'Bedrooms:'**
  String get clientPropertyDetailSpecBedrooms;

  /// No description provided for @clientPropertyDetailSpecBathrooms.
  ///
  /// In en, this message translates to:
  /// **'Bathrooms:'**
  String get clientPropertyDetailSpecBathrooms;

  /// No description provided for @clientPropertyDetailSpecArea.
  ///
  /// In en, this message translates to:
  /// **'Area:'**
  String get clientPropertyDetailSpecArea;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
