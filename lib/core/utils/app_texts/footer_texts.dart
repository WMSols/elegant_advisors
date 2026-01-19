class FooterTexts {
  FooterTexts._();

  // Company Info Section
  static const String companyName = "Elegant Advisors";
  static const String companyTagline =
      "Elegant Advisors - Your Trusted Property & Asset Advisory Partner";
  static const String companyDescription =
      "Leading real estate advisory in Portugal, helping private individuals, family offices, and property investors find and secure premium properties.";

  // Quick Links Section
  static const String quickLinksTitle = "Quick Links";
  static const String linkHome = "Home";
  static const String linkProperties = "Properties";
  static const String linkOurTeam = "Our Team";
  static const String linkAboutUs = "About Us";
  static const String linkContact = "Contact";

  // Legal Links
  static const String linkPrivacyPolicy = "Privacy Policy";
  static const String linkTermsOfService = "Terms of Service";

  // Contact Section
  static const String contactTitle = "Contact Us";
  static const String contactAddress = "123 Main Street, Lisbon, Portugal";
  static const String contactPhone = "+351 123 456 789";
  static const String contactEmail = "info@elegantadvisors.com";
  static const String contactWorkingHours =
      "Monday - Friday: 9:00 AM - 6:00 PM";

  // Social Media Section
  static const String socialTitle = "Follow Us";
  static const String socialFacebookUrl =
      "https://www.facebook.com/elegantadvisors";
  static const String socialInstagramUrl =
      "https://www.instagram.com/elegantadvisors";
  static const String socialLinkedInUrl =
      "https://www.linkedin.com/company/elegantadvisors";
  static const String socialTwitterUrl =
      "https://www.twitter.com/elegantadvisors";

  // Copyright
  static String copyright() =>
      "© ${DateTime.now().year} Elegant Advisors. All rights reserved.";

  // Callbacks for navigation (TODO: Replace with actual navigation logic)
  static void Function()? onHomeTap;
  static void Function()? onPropertiesTap;
  static void Function()? onOurTeamTap;
  static void Function()? onAboutUsTap;
  static void Function()? onContactTap;
  static void Function()? onPrivacyPolicyTap;
  static void Function()? onTermsOfServiceTap;

  // Callbacks for social media (TODO: Replace with actual URL launcher)
  static void Function(String url)? onSocialMediaTap;
}
