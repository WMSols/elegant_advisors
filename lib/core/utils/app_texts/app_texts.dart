class AppTexts {
  AppTexts._();

  // Logo (used in AppLogo widget)
  static const String logoTitle = "ELEGANT";
  static const String logoSubtitle = "REAL ESTATE";

  // Admin Login
  static const String adminLoginTitle = "ADMIN LOGIN";
  static const String adminLoginEmailHint = "Enter Email Address";
  static const String adminLoginPasswordHint = "Enter Password";
  static const String adminLoginButton = "Login";
  static const String adminLoginEmailError = "Please enter your email";
  static const String adminLoginEmailInvalidError =
      "Please enter a valid email";
  static const String adminLoginPasswordError = "Please enter your password";

  // Admin Navigation
  static const String adminNavDashboard = "Dashboard";
  static const String adminNavProperties = "Properties";
  static const String adminNavInquiries = "Inquiries";
  static const String adminNavManageAdmins = "Manage Admins";
  static const String adminNavLogout = "Log Out";

  // Admin Dashboard
  static const String adminDashboardTitle = "Dashboard";
  static const String adminDashboardTodayVisitors = "Today's Visitors";
  static const String adminDashboardYesterdayVisitors = "Yesterday's Visitors";
  static const String adminDashboardTotalVisitors = "Total Visitors";
  static const String adminDashboardTotalPropertyVisits = "Property Visits";
  static const String adminDashboardUniqueVisits = "Unique Visits";
  static const String adminDashboardTotalProperties = "Total Properties";
  static const String adminDashboardPublishedProperties =
      "Published Properties";
  static const String adminDashboardNewInquiries = "New Inquiries";

  // Admin Manage Admins
  static const String adminManageAdminsSearchHint =
      "Search by name or email...";
  static const String adminManageAdminsSortBy = "Sort By";
  static const String adminManageAdminsSortByName = "Name";
  static const String adminManageAdminsSortByEmail = "Email";
  static const String adminManageAdminsSortByCreatedDate = "Created Date";
  static const String adminManageAdminsAscending = "Ascending";
  static const String adminManageAdminsDescending = "Descending";
  static const String adminManageAdminsCreateNewAdmin = "Create New Admin";
  static const String adminManageAdminsCreateFirstAdmin = "Create First Admin";
  static const String adminManageAdminsNoAdminsFound = "No admins found";
  static const String adminManageAdminsNoMatchFound =
      "No admins match your search";
  static const String adminManageAdminsRole = "Admin";
  static const String adminManageAdminsEdit = "Edit";
  static const String adminManageAdminsDelete = "Delete";
  static const String adminManageAdminsDeleteTitle = "Delete Admin";
  static const String adminManageAdminsDeleteMessage =
      "Are you sure you want to delete this admin? This action cannot be undone.";
  static const String adminManageAdminsDeleteCancel = "Cancel";
  static const String adminManageAdminsDeleteConfirm = "Delete";

  // Admin Create/Edit Admin
  static const String adminCreateAdminTitle = "Create Admin";
  static const String adminEditAdminTitle = "Edit Admin";
  static const String adminCreateAdminNameLabel = "Admin Name";
  static const String adminCreateAdminNameHint = "Enter admin name";
  static const String adminCreateAdminEmailLabel = "Email";
  static const String adminCreateAdminEmailHint = "Enter email address";
  static const String adminCreateAdminPasswordLabel = "Password";
  static const String adminCreateAdminPasswordHint = "Enter password";
  static const String adminEditAdminPasswordLabel = "Password (Optional)";
  static const String adminCreateAdminButton = "Create Admin";
  static const String adminUpdateAdminButton = "Update Admin";

  // Admin Properties
  static const String adminPropertiesSearchHint =
      "Search by title, description, or location...";
  static const String adminPropertiesSortBy = "Sort By";
  static const String adminPropertiesSortByTitle = "Title";
  static const String adminPropertiesSortByCreatedDate = "Created Date";
  static const String adminPropertiesSortByUpdatedDate = "Updated Date";
  static const String adminPropertiesSortByPrice = "Price";
  static const String adminPropertiesSortByStatus = "Status";
  static const String adminPropertiesAscending = "Ascending";
  static const String adminPropertiesDescending = "Descending";
  static const String adminPropertiesCreateNewProperty = "Add Property";
  static const String adminPropertiesCreateFirstProperty = "Add First Property";
  static const String adminPropertiesNoPropertiesFound = "No properties found";
  static const String adminPropertiesNoMatchFound =
      "No properties match your search";
  static const String adminPropertiesEdit = "Edit";
  static const String adminPropertiesDelete = "Delete";
  static const String adminPropertiesDeleteTitle = "Delete Property";
  static const String adminPropertiesDeleteMessage =
      "Are you sure you want to delete this property? This action cannot be undone and will also delete all associated images.";
  static const String adminPropertiesDeleteCancel = "Cancel";
  static const String adminPropertiesDeleteConfirm = "Delete";
  static const String adminPropertiesStatusFilter = "Status";
  static const String adminPropertiesPublishedFilter = "Published";
  static const String adminPropertiesFeaturedFilter = "Featured";
  static const String adminPropertiesClearFilters = "Clear Filters";
  static const String adminPropertiesStatusAvailable = "Available";
  static const String adminPropertiesStatusSold = "Sold";
  static const String adminPropertiesStatusOffMarket = "Off Market";
  static const String adminPropertiesStatusComingSoon = "Coming Soon";
  static const String adminPropertiesPublished = "Published";
  static const String adminPropertiesUnpublished = "Unpublished";
  static const String adminPropertiesFeatured = "Featured";
  static const String adminPropertiesNotFeatured = "Not Featured";

  // Admin Inquiries
  static const String adminInquiriesSearchHint =
      "Search by name, email, subject, or message...";
  static const String adminInquiriesSortBy = "Sort By";
  static const String adminInquiriesSortByName = "Name";
  static const String adminInquiriesSortByEmail = "Email";
  static const String adminInquiriesSortBySubject = "Subject";
  static const String adminInquiriesSortByStatus = "Status";
  static const String adminInquiriesSortByCreatedDate = "Created Date";
  static const String adminInquiriesAscending = "Ascending";
  static const String adminInquiriesDescending = "Descending";
  static const String adminInquiriesStatusFilter = "Status";
  static const String adminInquiriesSortAllStatuses = "All Statuses";
  static const String adminInquiriesStatusNew = "New";
  static const String adminInquiriesStatusInProgress = "In Progress";
  static const String adminInquiriesStatusClosed = "Closed";
  static const String adminInquiriesClearFilters = "Clear Filters";
  static const String adminInquiriesNoInquiriesFound = "No inquiries found";
  static const String adminInquiriesNoMatchFound =
      "No inquiries match your search";
  static const String adminInquiryCardSubject = "Subject";
  static const String adminInquiryCardMessage = "Message";
  static const String adminInquiryCardPropertyId = "Property ID";
  static const String adminInquiryCardProperty = "Property";
  static const String adminInquiryCardCreated = "Created";
  static const String adminInquiriesViewDetails = "View Details";
  static const String adminInquiriesReply = "Reply";
  static const String adminInquiriesViewProperty = "View Property";
  static const String adminInquiriesDelete = "Delete";
  static const String adminInquiriesDeleteTitle = "Delete Inquiry";
  static const String adminInquiriesDeleteMessage =
      "Are you sure you want to delete this inquiry? This action cannot be undone.";
  static const String adminInquiriesDeleteCancel = "Cancel";
  static const String adminInquiriesDeleteConfirm = "Delete";
  static const String adminInquiryReplyTitle = "Reply to Inquiry";
  static const String adminInquiryReplyMessageLabel = "Reply Message";
  static const String adminInquiryReplyMessageHint =
      "Enter your reply message...";
  static const String adminInquiryReplySend = "Send Reply";
  static const String adminInquiryReplyCancel = "Cancel";
  static const String adminInquiryReplySuccess = "Reply sent successfully";
  static const String adminInquiryReplyError = "Failed to send reply";
  static const String adminInquiryReplyEmpty = "Please enter a reply message";
  static const String adminInquiryDetailName = "Name";
  static const String adminInquiryDetailEmail = "Email";
  static const String adminInquiryDetailPhone = "Phone";
  static const String adminInquiryDetailIpAddress = "IP Address";

  // Admin Property Form
  static const String adminPropertyFormCreateTitle = "Create Property";
  static const String adminPropertyFormEditTitle = "Edit Property";
  static const String adminPropertyFormBasicInfo = "Basic Information";
  static const String adminPropertyFormLocation = "Location";
  static const String adminPropertyFormPrice = "Price";
  static const String adminPropertyFormSpecs = "Specifications";
  static const String adminPropertyFormFeatures = "Features";
  static const String adminPropertyFormImages = "Images";
  static const String adminPropertyFormStatusSettings = "Status & Settings";
  static const String adminPropertyFormTitleLabel = "Property Title";
  static const String adminPropertyFormTitleHint = "Enter property title";
  static const String adminPropertyFormSlugLabel = "Slug (URL)";
  static const String adminPropertyFormSlugHint = "Auto-generated from title";
  static const String adminPropertyFormShortDescriptionLabel =
      "Short Description";
  static const String adminPropertyFormShortDescriptionHint =
      "Brief description (shown in listings)";
  static const String adminPropertyFormFullDescriptionLabel =
      "Full Description";
  static const String adminPropertyFormFullDescriptionHint =
      "Detailed description";
  static const String adminPropertyFormCountryLabel = "Country";
  static const String adminPropertyFormCountryHint = "Enter country";
  static const String adminPropertyFormCityLabel = "City";
  static const String adminPropertyFormCityHint = "Enter city";
  static const String adminPropertyFormAreaLabel = "Area (Optional)";
  static const String adminPropertyFormAreaHint = "Enter area/neighborhood";
  static const String adminPropertyFormAddressLabel = "Address (Optional)";
  static const String adminPropertyFormAddressHint = "Enter full address";
  static const String adminPropertyFormPriceAmountLabel = "Price Amount";
  static const String adminPropertyFormPriceAmountHint = "Enter price";
  static const String adminPropertyFormCurrencyLabel = "Currency";
  static const String adminPropertyFormPriceOnRequest = "Price on Request";
  static const String adminPropertyFormPropertyTypeLabel = "Property Type";
  static const String adminPropertyFormPropertyTypeHint =
      "e.g., Apartment, Villa, House";
  static const String adminPropertyFormBedroomsLabel = "Bedrooms (Optional)";
  static const String adminPropertyFormBedroomsHint = "Number of bedrooms";
  static const String adminPropertyFormBathroomsLabel = "Bathrooms (Optional)";
  static const String adminPropertyFormBathroomsHint = "Number of bathrooms";
  static const String adminPropertyFormAreaSizeLabel = "Area Size (Optional)";
  static const String adminPropertyFormAreaSizeHint = "Enter area size";
  static const String adminPropertyFormAreaUnitLabel = "Area Unit";
  static const String adminPropertyFormFeatureLabel = "Feature";
  static const String adminPropertyFormFeatureHint = "Enter feature";
  static const String adminPropertyFormAddFeature = "Add Feature";
  static const String adminPropertyFormRemoveFeature = "Remove";
  static const String adminPropertyFormAddImage = "Add Image";
  static const String adminPropertyFormRemoveImage = "Remove Image";
  static const String adminPropertyFormSetCoverImage = "Set as Cover";
  static const String adminPropertyFormCoverImage = "Cover Image";
  static const String adminPropertyFormMaxImages = "Maximum 5 images";
  static const String adminPropertyFormStatusLabel = "Status";
  static const String adminPropertyFormIsFeatured = "Featured Property";
  static const String adminPropertyFormIsPublished = "Published";
  static const String adminPropertyFormSaveButton = "Save Property";
  static const String adminPropertyFormUpdateButton = "Update Property";
  static const String adminPropertyFormSqm = "Square Meters (sqm)";
  static const String adminPropertyFormSqft = "Square Feet (sqft)";
  static const String adminPropertyFormCurrencyEUR = "EUR (€)";
  static const String adminPropertyFormCurrencyGBP = "GBP (£)";
  static const String adminPropertyFormCurrencyUSD = "USD (\$)";

  // Admin Property Detail Dialog
  static const String adminPropertyDetailImages = "Images";
  static const String adminPropertyDetailLocation = "Location";
  static const String adminPropertyDetailPrice = "Price";
  static const String adminPropertyDetailSpecifications = "Specifications";
  static const String adminPropertyDetailShortDescription = "Short Description";
  static const String adminPropertyDetailFullDescription = "Full Description";
  static const String adminPropertyDetailFeatures = "Features";
  static const String adminPropertyDetailCreated = "Created";
  static const String adminPropertyDetailLastUpdated = "Last Updated";
  static const String adminPropertyDetailCover = "Cover";
  static const String adminPropertyDetailPriceOnRequest = "Price on Request";
  static const String adminPropertyDetailPriceNotSet = "Price not set";

  // Admin Property Card
  static const String adminPropertyCardPriceOnRequest = "Price on Request";
  static const String adminPropertyCardPriceNotSet = "Price not set";
  static const String adminPropertyCardCreated = "Created";

  // Admin Property Search and Filters
  static const String adminPropertiesSortAllStatuses = "All Statuses";
  static const String adminPropertiesSortAll = "All";

  // Admin Property Form
  static const String adminPropertyFormNoImagesAdded = "No images added";
  static const String adminPropertyFormNoFeaturesAdded = "No features added";

  // Admin Property Map Picker
  static const String adminPropertyMapPickerSearchHint =
      "Search for a location...";
  static const String adminPropertyMapPickerSelectLocation =
      "Select Location on Map";

  // Common UI Elements
  static const String commonGoBack = "Go Back";
  static const String commonGoHome = "Go Home";
  static const String commonMenu = "Menu";
  static const String commonClose = "Close";
  static const String commonRetry = "Retry";
  static const String commonCancel = "Cancel";
  static const String commonPageNotFound = "Page Not Found";
  static const String commonSuccess = "Success";
  static const String commonError = "Error";
  static const String commonInfo = "Info";
  static const String commonWarning = "Warning";

  // App Titles
  static const String appTitleClient = "Elegant Real Estate";
  static const String appTitleAdmin = "Elegant Real Estate - Admin";

  // Property Detail
  static const String clientPropertyDetailNotFoundMessage =
      "The property you are looking for could not be found.";

  // Admin Inquiries
  static const String adminInquiriesExport = "Export Inquiries";

  // Admin Property Images
  static const String adminPropertyImageRemove = "Remove image";
  static const String adminPropertyImageCover = "Cover image";
  static const String adminPropertyImageSetCover = "Set as cover image";
}
