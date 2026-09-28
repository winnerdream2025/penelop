class AppUrls {
  static String serverUrl = "https://caurispay-backend.onrender.com";
  static String policyUrl = "https://caurispay.net/privacy-policy.html";

  // TEMPORARY (App Store review): https://caurispay.net/terms returns 404,
  // so the Terms of Use link points to the privacy page for now.
  // TODO(legal): publish a dedicated Terms of Service page and restore
  // termsUrl to it — Privacy Policy and ToS are legally distinct documents.
  static String termsUrl = "https://caurispay.net/privacy-policy.html";
  static String merchantApiUrl = "https://developer.caurispay.net";
}
