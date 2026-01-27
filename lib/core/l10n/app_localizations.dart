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

  /// No description provided for @navContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get navContact;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'YOUR VISION, OUR EXPERTISE'**
  String get homeTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Elegant is a leading real estate advisory in Portugal in finding and securing properties for private individuals, family offices, and property investors.'**
  String get homeSubtitle;

  /// No description provided for @homeButtonConsultation.
  ///
  /// In en, this message translates to:
  /// **'Request A Private Consultation'**
  String get homeButtonConsultation;

  /// No description provided for @homeMarketEducatedTitle.
  ///
  /// In en, this message translates to:
  /// **'MARKET EDUCATED,\nBUYER FOCUSED'**
  String get homeMarketEducatedTitle;

  /// No description provided for @homeMarketEducatedDescription.
  ///
  /// In en, this message translates to:
  /// **'Combining an international mindset and profound local market expertise, our bespoke service gives you the insider\'s edge on the Portuguese real estate market. We\'ve spent years forging deep connections with prominent real estate agencies, established developers, and well-connected individuals to shape our network and help you find and secure the property you\'re truly seeking. On or off market, no exclusives to push.'**
  String get homeMarketEducatedDescription;

  /// No description provided for @homeMarketEducatedButton.
  ///
  /// In en, this message translates to:
  /// **'What We Do'**
  String get homeMarketEducatedButton;

  /// No description provided for @homeOurDiscerningClienteleTitle.
  ///
  /// In en, this message translates to:
  /// **'OUR DISCERNING\nCLIENTELE'**
  String get homeOurDiscerningClienteleTitle;

  /// No description provided for @homeOurDiscerningClienteleDescription.
  ///
  /// In en, this message translates to:
  /// **'Hailing from 30+ nationalities since 2014, our private clientele values a bespoke, discreet service with strategic guidance across all relevant fields. That\'s precisely what we do.'**
  String get homeOurDiscerningClienteleDescription;

  /// No description provided for @homeOurDiscerningClientelePropertyInvestorsTitle.
  ///
  /// In en, this message translates to:
  /// **'PROPERTY INVESTORS'**
  String get homeOurDiscerningClientelePropertyInvestorsTitle;

  /// No description provided for @homeOurDiscerningClientelePropertyInvestorsDescription.
  ///
  /// In en, this message translates to:
  /// **'If you are looking to grow your real estate portfolio in Portugal, we act as your skilled advisor on all things strategy.'**
  String get homeOurDiscerningClientelePropertyInvestorsDescription;

  /// No description provided for @homeOurDiscerningClienteleCitizenshipClientsTitle.
  ///
  /// In en, this message translates to:
  /// **'CITIZENSHIP CLIENTS'**
  String get homeOurDiscerningClienteleCitizenshipClientsTitle;

  /// No description provided for @homeOurDiscerningClienteleCitizenshipClientsDescription.
  ///
  /// In en, this message translates to:
  /// **'If you are looking to gain access to the Golden Visa or another citizenship program by making a real estate investment, we will guide you in the right way.'**
  String get homeOurDiscerningClienteleCitizenshipClientsDescription;

  /// No description provided for @homeOurDiscerningClienteleLifestyleHomeBuyersTitle.
  ///
  /// In en, this message translates to:
  /// **'LIFESTYLE HOME BUYERS'**
  String get homeOurDiscerningClienteleLifestyleHomeBuyersTitle;

  /// No description provided for @homeOurDiscerningClienteleLifestyleHomeBuyersDescription.
  ///
  /// In en, this message translates to:
  /// **'If you are looking to fully relocate to Portugal or simply enjoy a vacation home, you can count on us to help you find the property you\'ve always envisioned.'**
  String get homeOurDiscerningClienteleLifestyleHomeBuyersDescription;

  /// No description provided for @homeOurDiscerningClienteleLuxuryPropertyOwnersTitle.
  ///
  /// In en, this message translates to:
  /// **'LUXURY PROPERTY OWNERS'**
  String get homeOurDiscerningClienteleLuxuryPropertyOwnersTitle;

  /// No description provided for @homeOurDiscerningClienteleLuxuryPropertyOwnersDescription.
  ///
  /// In en, this message translates to:
  /// **'If you are looking to rent or find a trustworthy property manager, we deliver a 360° bespoke service that ensures all runs smoothly.'**
  String get homeOurDiscerningClienteleLuxuryPropertyOwnersDescription;

  /// No description provided for @homeOurDiscerningClienteleButton.
  ///
  /// In en, this message translates to:
  /// **'What Our Clients Say'**
  String get homeOurDiscerningClienteleButton;

  /// No description provided for @homeUnparalleledExpertiseTitle.
  ///
  /// In en, this message translates to:
  /// **'UNPARALLELED EXPERTISE'**
  String get homeUnparalleledExpertiseTitle;

  /// No description provided for @homeUnparalleledExpertiseDescription.
  ///
  /// In en, this message translates to:
  /// **'With an unrivalled track record, our multidisciplinary team manages all transaction details - from first brief to acquisition and post sales.'**
  String get homeUnparalleledExpertiseDescription;

  /// No description provided for @homeUnparalleledExpertisePropertySearchTitle.
  ///
  /// In en, this message translates to:
  /// **'PROPERTY SEARCH'**
  String get homeUnparalleledExpertisePropertySearchTitle;

  /// No description provided for @homeUnparalleledExpertisePropertySearchDescription.
  ///
  /// In en, this message translates to:
  /// **'After thoroughly analyzing your brief, we take it to the market and search for the property that meets your utmost standards.'**
  String get homeUnparalleledExpertisePropertySearchDescription;

  /// No description provided for @homeUnparalleledExpertisePurchaseStrategyTitle.
  ///
  /// In en, this message translates to:
  /// **'PURCHASE STRATEGY'**
  String get homeUnparalleledExpertisePurchaseStrategyTitle;

  /// No description provided for @homeUnparalleledExpertisePurchaseStrategyDescription.
  ///
  /// In en, this message translates to:
  /// **'In collaboration with you, we develop a tactical buying plan that adapts to your particular needs.'**
  String get homeUnparalleledExpertisePurchaseStrategyDescription;

  /// No description provided for @homeUnparalleledExpertiseNegotiationTitle.
  ///
  /// In en, this message translates to:
  /// **'NEGOTIATION'**
  String get homeUnparalleledExpertiseNegotiationTitle;

  /// No description provided for @homeUnparalleledExpertiseNegotiationDescription.
  ///
  /// In en, this message translates to:
  /// **'Renowned for our exceptional negotiation skills, we handle the process on your behalf, so you can secure your selected property at the best price.'**
  String get homeUnparalleledExpertiseNegotiationDescription;

  /// No description provided for @homeUnparalleledExpertisePortfolioManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'PORTFOLIO MANAGEMENT'**
  String get homeUnparalleledExpertisePortfolioManagementTitle;

  /// No description provided for @homeUnparalleledExpertisePortfolioManagementDescription.
  ///
  /// In en, this message translates to:
  /// **'Using our market experience to assess risk and identify opportunities, we advise and assist you in building your real estate portfolio.'**
  String get homeUnparalleledExpertisePortfolioManagementDescription;

  /// No description provided for @homeUnparalleledExpertiseVisaTaxAdvisoryTitle.
  ///
  /// In en, this message translates to:
  /// **'VISA & TAX ADVISORY'**
  String get homeUnparalleledExpertiseVisaTaxAdvisoryTitle;

  /// No description provided for @homeUnparalleledExpertiseVisaTaxAdvisoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Through our established partnerships with Portuguese lawyers and tax specialists, we provide a turn-key solution to clients interested in the Golden Visa, D7, D2, Nomad Visa or Portugal\'s Non-Habitual Resident Status (NHR).'**
  String get homeUnparalleledExpertiseVisaTaxAdvisoryDescription;

  /// No description provided for @homeUnparalleledExpertiseLuxuryRentalsManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'LUXURY RENTALS & MANAGEMENT'**
  String get homeUnparalleledExpertiseLuxuryRentalsManagementTitle;

  /// No description provided for @homeUnparalleledExpertiseLuxuryRentalsManagementDescription.
  ///
  /// In en, this message translates to:
  /// **'We ensure your investment is maximized by securing sterling tenants or simply maintaining your property in mint condition. Should you wish to rent an apartment, we will find a prime rental option suitable for your particular goals.'**
  String get homeUnparalleledExpertiseLuxuryRentalsManagementDescription;

  /// No description provided for @homeUnparalleledExpertiseButton.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get homeUnparalleledExpertiseButton;

  /// No description provided for @homePrivilegingQualityTitle.
  ///
  /// In en, this message translates to:
  /// **'PRIVILEGING QUALITY'**
  String get homePrivilegingQualityTitle;

  /// No description provided for @homePrivilegingQualitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Nearly 70% of our clients come by referral'**
  String get homePrivilegingQualitySubtitle;

  /// No description provided for @homePrivilegingQualityDescription.
  ///
  /// In en, this message translates to:
  /// **'Here is a selection of our previous transactions.'**
  String get homePrivilegingQualityDescription;

  /// No description provided for @homePrivilegingQualityButton.
  ///
  /// In en, this message translates to:
  /// **'Request a Private Consultation'**
  String get homePrivilegingQualityButton;

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
  /// **'Leading real estate advisory in Portugal, helping private individuals, family offices, and property investors find and secure premium properties.'**
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
