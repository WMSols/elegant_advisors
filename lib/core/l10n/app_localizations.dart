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

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyTitle;

  /// No description provided for @privacyPolicyLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last Updated: {date}'**
  String privacyPolicyLastUpdated(String date);

  /// No description provided for @privacyPolicyIntroduction.
  ///
  /// In en, this message translates to:
  /// **'At Elegant Advisors, we are committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you visit our website and use our services.'**
  String get privacyPolicyIntroduction;

  /// No description provided for @privacyPolicySection1Title.
  ///
  /// In en, this message translates to:
  /// **'1. Information We Collect'**
  String get privacyPolicySection1Title;

  /// No description provided for @privacyPolicySection1Content.
  ///
  /// In en, this message translates to:
  /// **'We collect information that you provide directly to us, including:\n\n• Contact Information: When you submit a contact form, we collect your name, email address, phone number, subject, and message.\n• Property Inquiries: If you inquire about a specific property, we may associate your inquiry with that property.\n• IP Address: We may collect your IP address for security and analytics purposes.\n• Usage Data: We automatically collect information about how you interact with our website, including pages visited, time spent on pages, and property views.\n• Analytics Data: We use Firebase Analytics to track website usage, screen views, and user interactions.'**
  String get privacyPolicySection1Content;

  /// No description provided for @privacyPolicySection2Title.
  ///
  /// In en, this message translates to:
  /// **'2. How We Use Your Information'**
  String get privacyPolicySection2Title;

  /// No description provided for @privacyPolicySection2Content.
  ///
  /// In en, this message translates to:
  /// **'We use the information we collect to:\n\n• Respond to your inquiries and provide customer support\n• Process and manage your contact submissions\n• Improve our website and services\n• Analyze website usage and user behavior\n• Track property views and user engagement\n• Send you updates about properties or services (if you have opted in)\n• Comply with legal obligations'**
  String get privacyPolicySection2Content;

  /// No description provided for @privacyPolicySection3Title.
  ///
  /// In en, this message translates to:
  /// **'3. Data Storage and Security'**
  String get privacyPolicySection3Title;

  /// No description provided for @privacyPolicySection3Content.
  ///
  /// In en, this message translates to:
  /// **'Your information is stored securely using:\n\n• Firebase Firestore: Contact submissions and related data are stored in Google Cloud Firestore\n• Firebase Storage: Property images and related files are stored securely\n• Local Storage: We use browser local storage (SharedPreferences) to remember your language preferences and improve your experience\n\nWe implement appropriate technical and organizational measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.'**
  String get privacyPolicySection3Content;

  /// No description provided for @privacyPolicySection4Title.
  ///
  /// In en, this message translates to:
  /// **'4. Third-Party Services'**
  String get privacyPolicySection4Title;

  /// No description provided for @privacyPolicySection4Content.
  ///
  /// In en, this message translates to:
  /// **'We use the following third-party services that may collect information:\n\n• Google Firebase: For data storage, analytics, and authentication services\n• Firebase Analytics: For website usage analytics and tracking\n\nThese services have their own privacy policies governing the collection and use of your information.'**
  String get privacyPolicySection4Content;

  /// No description provided for @privacyPolicySection5Title.
  ///
  /// In en, this message translates to:
  /// **'5. Data Retention'**
  String get privacyPolicySection5Title;

  /// No description provided for @privacyPolicySection5Content.
  ///
  /// In en, this message translates to:
  /// **'We retain your personal information for as long as necessary to fulfill the purposes outlined in this Privacy Policy, unless a longer retention period is required or permitted by law. Contact submissions are retained to provide customer support and track inquiry history.'**
  String get privacyPolicySection5Content;

  /// No description provided for @privacyPolicySection6Title.
  ///
  /// In en, this message translates to:
  /// **'6. Your Rights'**
  String get privacyPolicySection6Title;

  /// No description provided for @privacyPolicySection6Content.
  ///
  /// In en, this message translates to:
  /// **'Depending on your location, you may have the following rights regarding your personal information:\n\n• Access: Request access to your personal information\n• Correction: Request correction of inaccurate information\n• Deletion: Request deletion of your personal information\n• Objection: Object to processing of your personal information\n• Data Portability: Request transfer of your data\n\nTo exercise these rights, please contact us using the information provided in the Contact section.'**
  String get privacyPolicySection6Content;

  /// No description provided for @privacyPolicySection7Title.
  ///
  /// In en, this message translates to:
  /// **'7. Cookies and Local Storage'**
  String get privacyPolicySection7Title;

  /// No description provided for @privacyPolicySection7Content.
  ///
  /// In en, this message translates to:
  /// **'We use browser local storage to remember your language preferences and improve your browsing experience. This information is stored locally on your device and is not transmitted to our servers except as part of normal website functionality.'**
  String get privacyPolicySection7Content;

  /// No description provided for @privacyPolicySection8Title.
  ///
  /// In en, this message translates to:
  /// **'8. Children\'s Privacy'**
  String get privacyPolicySection8Title;

  /// No description provided for @privacyPolicySection8Content.
  ///
  /// In en, this message translates to:
  /// **'Our services are not directed to individuals under the age of 18. We do not knowingly collect personal information from children. If you believe we have collected information from a child, please contact us immediately.'**
  String get privacyPolicySection8Content;

  /// No description provided for @privacyPolicySection9Title.
  ///
  /// In en, this message translates to:
  /// **'9. Changes to This Privacy Policy'**
  String get privacyPolicySection9Title;

  /// No description provided for @privacyPolicySection9Content.
  ///
  /// In en, this message translates to:
  /// **'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the \"Last Updated\" date. You are advised to review this Privacy Policy periodically for any changes.'**
  String get privacyPolicySection9Content;

  /// No description provided for @privacyPolicySection10Title.
  ///
  /// In en, this message translates to:
  /// **'10. Contact Us'**
  String get privacyPolicySection10Title;

  /// No description provided for @privacyPolicySection10Content.
  ///
  /// In en, this message translates to:
  /// **'If you have any questions about this Privacy Policy or our data practices, please contact us:\n\nElegant Advisors\nEmail: info@elegantadvisors.com\nPhone: +351 123 456 789'**
  String get privacyPolicySection10Content;

  /// No description provided for @termsOfServiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfServiceTitle;

  /// No description provided for @termsOfServiceLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last Updated: {date}'**
  String termsOfServiceLastUpdated(String date);

  /// No description provided for @termsOfServiceIntroduction.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Elegant Advisors. These Terms of Service govern your access to and use of our website and services. By accessing or using our website, you agree to be bound by these Terms.'**
  String get termsOfServiceIntroduction;

  /// No description provided for @termsOfServiceSection1Title.
  ///
  /// In en, this message translates to:
  /// **'1. Acceptance of Terms'**
  String get termsOfServiceSection1Title;

  /// No description provided for @termsOfServiceSection1Content.
  ///
  /// In en, this message translates to:
  /// **'By accessing and using the Elegant Advisors website, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to these Terms, please do not use our website.'**
  String get termsOfServiceSection1Content;

  /// No description provided for @termsOfServiceSection2Title.
  ///
  /// In en, this message translates to:
  /// **'2. Use of Website'**
  String get termsOfServiceSection2Title;

  /// No description provided for @termsOfServiceSection2Content.
  ///
  /// In en, this message translates to:
  /// **'You agree to use our website only for lawful purposes and in a way that does not infringe the rights of, restrict, or inhibit anyone else\'s use and enjoyment of the website. Prohibited behavior includes harassing or causing distress or inconvenience to any person, transmitting obscene or offensive content, or disrupting the normal flow of dialogue within our website.'**
  String get termsOfServiceSection2Content;

  /// No description provided for @termsOfServiceSection3Title.
  ///
  /// In en, this message translates to:
  /// **'3. Property Information'**
  String get termsOfServiceSection3Title;

  /// No description provided for @termsOfServiceSection3Content.
  ///
  /// In en, this message translates to:
  /// **'All property information, descriptions, images, and specifications displayed on our website are provided for informational purposes only. While we strive to ensure accuracy, we do not guarantee the completeness, reliability, or accuracy of any property information. Property availability, prices, and specifications are subject to change without notice.'**
  String get termsOfServiceSection3Content;

  /// No description provided for @termsOfServiceSection4Title.
  ///
  /// In en, this message translates to:
  /// **'4. Contact Form and Submissions'**
  String get termsOfServiceSection4Title;

  /// No description provided for @termsOfServiceSection4Content.
  ///
  /// In en, this message translates to:
  /// **'When you submit a contact form or inquiry:\n\n• You agree to provide accurate and truthful information\n• You grant us permission to use your contact information to respond to your inquiry\n• You understand that we may store your submission for customer service and record-keeping purposes\n• You agree not to submit any unlawful, harmful, or inappropriate content'**
  String get termsOfServiceSection4Content;

  /// No description provided for @termsOfServiceSection5Title.
  ///
  /// In en, this message translates to:
  /// **'5. Intellectual Property'**
  String get termsOfServiceSection5Title;

  /// No description provided for @termsOfServiceSection5Content.
  ///
  /// In en, this message translates to:
  /// **'All content on this website, including text, graphics, logos, images, and software, is the property of Elegant Advisors or its content suppliers and is protected by copyright and other intellectual property laws. You may not reproduce, distribute, modify, or create derivative works from any content without our express written permission.'**
  String get termsOfServiceSection5Content;

  /// No description provided for @termsOfServiceSection6Title.
  ///
  /// In en, this message translates to:
  /// **'6. Limitation of Liability'**
  String get termsOfServiceSection6Title;

  /// No description provided for @termsOfServiceSection6Content.
  ///
  /// In en, this message translates to:
  /// **'Elegant Advisors shall not be liable for any indirect, incidental, special, consequential, or punitive damages resulting from your use of or inability to use the website or services. We do not guarantee that the website will be available at all times or free from errors or interruptions.'**
  String get termsOfServiceSection6Content;

  /// No description provided for @termsOfServiceSection7Title.
  ///
  /// In en, this message translates to:
  /// **'7. Disclaimer of Warranties'**
  String get termsOfServiceSection7Title;

  /// No description provided for @termsOfServiceSection7Content.
  ///
  /// In en, this message translates to:
  /// **'The website and services are provided \"as is\" and \"as available\" without any warranties of any kind, either express or implied. We do not warrant that the website will be uninterrupted, secure, or error-free, or that defects will be corrected.'**
  String get termsOfServiceSection7Content;

  /// No description provided for @termsOfServiceSection8Title.
  ///
  /// In en, this message translates to:
  /// **'8. Links to Third-Party Websites'**
  String get termsOfServiceSection8Title;

  /// No description provided for @termsOfServiceSection8Content.
  ///
  /// In en, this message translates to:
  /// **'Our website may contain links to third-party websites, including social media platforms and mapping services. We are not responsible for the content, privacy policies, or practices of any third-party websites. Your use of third-party websites is at your own risk.'**
  String get termsOfServiceSection8Content;

  /// No description provided for @termsOfServiceSection9Title.
  ///
  /// In en, this message translates to:
  /// **'9. Modifications to Terms'**
  String get termsOfServiceSection9Title;

  /// No description provided for @termsOfServiceSection9Content.
  ///
  /// In en, this message translates to:
  /// **'We reserve the right to modify these Terms of Service at any time. We will notify users of any material changes by updating the \"Last Updated\" date on this page. Your continued use of the website after such modifications constitutes acceptance of the updated Terms.'**
  String get termsOfServiceSection9Content;

  /// No description provided for @termsOfServiceSection10Title.
  ///
  /// In en, this message translates to:
  /// **'10. Governing Law'**
  String get termsOfServiceSection10Title;

  /// No description provided for @termsOfServiceSection10Content.
  ///
  /// In en, this message translates to:
  /// **'These Terms of Service shall be governed by and construed in accordance with the laws of Portugal, without regard to its conflict of law provisions.'**
  String get termsOfServiceSection10Content;

  /// No description provided for @termsOfServiceSection11Title.
  ///
  /// In en, this message translates to:
  /// **'11. Contact Information'**
  String get termsOfServiceSection11Title;

  /// No description provided for @termsOfServiceSection11Content.
  ///
  /// In en, this message translates to:
  /// **'If you have any questions about these Terms of Service, please contact us:\n\nElegant Advisors\nEmail: info@elegantadvisors.com\nPhone: +351 123 456 789'**
  String get termsOfServiceSection11Content;

  /// No description provided for @navFaq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get navFaq;

  /// No description provided for @faqPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get faqPageTitle;

  /// No description provided for @faqChatTooltip.
  ///
  /// In en, this message translates to:
  /// **'Have questions?'**
  String get faqChatTooltip;

  /// No description provided for @faqCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get faqCardTitle;

  /// No description provided for @faqViewFullPage.
  ///
  /// In en, this message translates to:
  /// **'View full FAQ page'**
  String get faqViewFullPage;

  /// No description provided for @faq1Question.
  ///
  /// In en, this message translates to:
  /// **'What type of clients does Elegant work with?'**
  String get faq1Question;

  /// No description provided for @faq1Answer.
  ///
  /// In en, this message translates to:
  /// **'We work with private investors, family offices, developers, private equity funds, asset management firms, and lifestyle buyers seeking high-quality residential, commercial, and hospitality assets. Many of our clients are international and rely on us for local market expertise and end-to-end transaction advisory.'**
  String get faq1Answer;

  /// No description provided for @faq2Question.
  ///
  /// In en, this message translates to:
  /// **'Are you a real estate agency or an investment advisory firm?'**
  String get faq2Question;

  /// No description provided for @faq2Answer.
  ///
  /// In en, this message translates to:
  /// **'Elegant operates as a real estate investment advisory and brokerage, combining traditional agency capabilities with strategic investment guidance. We support clients beyond the transaction — including sourcing, evaluation, structuring, and long-term asset positioning.'**
  String get faq2Answer;

  /// No description provided for @faq3Question.
  ///
  /// In en, this message translates to:
  /// **'Do you work with international investors?'**
  String get faq3Question;

  /// No description provided for @faq3Answer.
  ///
  /// In en, this message translates to:
  /// **'Yes. A significant portion of our clientele is international. We assist with market entry strategy, asset sourcing, due diligence coordination, and introductions to trusted legal, tax, and financial partners to ensure a seamless acquisition process.'**
  String get faq3Answer;

  /// No description provided for @faq4Question.
  ///
  /// In en, this message translates to:
  /// **'Can you source off-market opportunities?'**
  String get faq4Question;

  /// No description provided for @faq4Answer.
  ///
  /// In en, this message translates to:
  /// **'Absolutely. Through our network of owners, developers, operators, and private stakeholders, we regularly access discreet, off-market opportunities not publicly advertised — often among the most attractive investments available.'**
  String get faq4Answer;

  /// No description provided for @faq5Question.
  ///
  /// In en, this message translates to:
  /// **'What services do you provide beyond buying and selling?'**
  String get faq5Question;

  /// No description provided for @faq5Answer.
  ///
  /// In en, this message translates to:
  /// **'Our advisory spans the full investment lifecycle, including:\n• Investment strategy definition\n• Asset sourcing (on- and off-market)\n• Financial and yield analysis\n• Due diligence coordination\n• Transaction structuring support\n• Repositioning and value-add guidance\n• Hospitality and operational asset advisory'**
  String get faq5Answer;

  /// No description provided for @faq6Question.
  ///
  /// In en, this message translates to:
  /// **'Do you help with rental yield and income-producing assets?'**
  String get faq6Question;

  /// No description provided for @faq6Answer.
  ///
  /// In en, this message translates to:
  /// **'Yes. We advise on income-generating properties, including residential portfolios, commercial buildings, and hospitality assets, focusing on stable cash flow, strong tenant profiles, and long-term value preservation.'**
  String get faq6Answer;

  /// No description provided for @faq7Question.
  ///
  /// In en, this message translates to:
  /// **'Can you assist developers and land investors?'**
  String get faq7Question;

  /// No description provided for @faq7Answer.
  ///
  /// In en, this message translates to:
  /// **'We work closely with developers and land investors by identifying strategic plots and development opportunities and providing insights on positioning, demand trends, and exit strategies.'**
  String get faq7Answer;

  /// No description provided for @faq8Question.
  ///
  /// In en, this message translates to:
  /// **'How do you ensure discretion and confidentiality?'**
  String get faq8Question;

  /// No description provided for @faq8Answer.
  ///
  /// In en, this message translates to:
  /// **'Discretion is fundamental to our philosophy. Client identities, strategies, and transactions are handled with strict confidentiality, particularly in off-market deals and private portfolio acquisitions.'**
  String get faq8Answer;

  /// No description provided for @faq9Question.
  ///
  /// In en, this message translates to:
  /// **'How are you compensated?'**
  String get faq9Question;

  /// No description provided for @faq9Answer.
  ///
  /// In en, this message translates to:
  /// **'Compensation varies depending on the transaction and scope of services. This may include brokerage fees, advisory retainers, or success-based structures. All terms are transparently agreed upon in advance.'**
  String get faq9Answer;

  /// No description provided for @faq10Question.
  ///
  /// In en, this message translates to:
  /// **'Do you advise on hospitality investments specifically?'**
  String get faq10Question;

  /// No description provided for @faq10Answer.
  ///
  /// In en, this message translates to:
  /// **'Yes — hospitality is one of our core specializations, covering hotels, serviced apartments, resorts, and mixed-use assets, including acquisitions, repositioning, operator strategy, and development-led projects.'**
  String get faq10Answer;

  /// No description provided for @faq11Question.
  ///
  /// In en, this message translates to:
  /// **'How do we start working together?'**
  String get faq11Question;

  /// No description provided for @faq11Answer.
  ///
  /// In en, this message translates to:
  /// **'We begin with a confidential consultation to understand your objectives, risk profile, investment horizon, and capital allocation strategy. From there, we define a tailored approach and present curated opportunities aligned with your goals.'**
  String get faq11Answer;
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
