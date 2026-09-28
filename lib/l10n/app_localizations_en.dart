// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get onboardingTitleOne => 'Simple, Fast, and Secure';

  @override
  String get onboardingTitleTwo => 'International Transactions';

  @override
  String get onboardingDescriptionOne =>
      'Transfer money quickly with fully secure transactions.';

  @override
  String get onboardingDescriptionTwo =>
      'Enjoy total freedom in managing your finances, with reduced fees on international transactions.';

  @override
  String get next => 'Next';

  @override
  String get start => 'Get Started';

  @override
  String get login => 'LOG IN';

  @override
  String get register => 'SIGN UP';

  @override
  String get or => 'OR';

  @override
  String get continueWithGoogle => 'CONTINUE WITH GOOGLE';

  @override
  String get french => 'French';

  @override
  String get loginTitle => 'Log In';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get loginButton => 'Login';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get orLoginWith => 'OR LOG IN WITH';

  @override
  String get emailMode => 'EMAIL';

  @override
  String get phoneMode => 'PHONE NUMBER';

  @override
  String get google => 'GOOGLE';

  @override
  String get forgotPasswordTitle => 'Forgot Password';

  @override
  String get useEmail => 'USE EMAIL';

  @override
  String get usePhoneNumber => 'USE PHONE NUMBER';

  @override
  String get confirmOtpTitle => 'Confirm Your Number';

  @override
  String get confirmOtpDescription =>
      'We sent a code via SMS. Enter it to continue.';

  @override
  String get confirm => 'Confirm';

  @override
  String get resendCode => 'RESEND CODE';

  @override
  String get resetPasswordTitle => 'Reset Your Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get phoneTitle => 'Phone';

  @override
  String get country => 'Country';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get personalInfoTitle => 'Personal Information';

  @override
  String get lastName => 'Last Name';

  @override
  String get firstName => 'First Name';

  @override
  String get securityTitle => 'Secure Your Account';

  @override
  String get addMoney => 'Add Money';

  @override
  String get send => 'Send';

  @override
  String get receive => 'Receive';

  @override
  String get exchange => 'Exchange';

  @override
  String get withdraw => 'Withdraw';

  @override
  String get transactions => 'Transactions';

  @override
  String get viewAll => 'View All';

  @override
  String get enterAmountToRecharge => 'Enter amount to top up';

  @override
  String get currency => 'XOF';

  @override
  String get availableBalance => 'Available Balance';

  @override
  String userName(Object name) {
    return '$name';
  }

  @override
  String get chooseRechargeMethod => 'Choose top-up method';

  @override
  String get rechargeMethod => 'Top-up Method';

  @override
  String get selectRechargeMethod => 'Select a top-up method';

  @override
  String get fees => 'Fees';

  @override
  String get confirmYourNumber => 'Confirm your number';

  @override
  String get mobileMoney => 'Mobile Money';

  @override
  String get phoneNumberHint => '34567890';

  @override
  String get selectMobileMoneyType => 'Select Mobile Money type';

  @override
  String willBeDebited(Object account, Object phone, Object total) {
    return 'You will be debited from your account $account ($phone) for $total XOF';
  }

  @override
  String get recharge => 'Top Up';

  @override
  String rechargeSummary(
    Object amount,
    Object currency,
    Object mobileMoney,
    Object phone,
  ) {
    return 'Top up of $amount $currency via $mobileMoney ($phone)';
  }

  @override
  String get status => 'Status';

  @override
  String get pending => 'Pending';

  @override
  String get sentBy => 'Sent by';

  @override
  String get sentVia => 'Sent via';

  @override
  String get amount => 'Amount';

  @override
  String get account => 'Account';

  @override
  String get settings => 'Settings';

  @override
  String get personalInfo => 'Personal Information';

  @override
  String get security => 'Security';

  @override
  String get changePassword => 'Change Password';

  @override
  String get changePinCode => 'Change Security PIN';

  @override
  String get business => 'Business';

  @override
  String get merchantAccount => 'Merchant Account';

  @override
  String get preferences => 'Preferences';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get language => 'Language';

  @override
  String get logout => 'Log Out';

  @override
  String get userNameFull => 'Full Name';

  @override
  String get createPinCode => 'Create your PIN code';

  @override
  String get enterPinCode => 'Enter your PIN code';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get update => 'Update';

  @override
  String get updatePasswordTitle => 'Change Password';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get sendMoney => 'Send Money';

  @override
  String get whatAmount => 'What amount?';

  @override
  String get toWho => 'To whom?';

  @override
  String sendMoneyWarning(Object account, Object balance, Object currency) {
    return 'Your transfer will be debited from Cauris $account. Your remaining balance will be $balance $currency';
  }

  @override
  String get newReceiver => 'New Beneficiary';

  @override
  String get accountNumber => 'Account Number';

  @override
  String get chooseReceiver => 'Choose a beneficiary';

  @override
  String get searchReceiver => 'Search for a recipient';

  @override
  String get addNewReceiver => 'Add new recipient';

  @override
  String get savedReceivers => 'Saved recipients';

  @override
  String get verificationSuccessTitle => 'Verification Successful';

  @override
  String get verificationSuccessMessage =>
      'Your money transfer has been completed successfully.';

  @override
  String get continueButton => 'Continue';

  @override
  String get pay => 'Pay';

  @override
  String get fingerPrint => 'Fingerprint';

  @override
  String get enable => 'Enabled';

  @override
  String get disable => 'Disabled';

  @override
  String get english => 'English';

  @override
  String get not_informed => 'Not provided';

  @override
  String get add => 'Add';

  @override
  String get enter_your_email => 'Enter your email';

  @override
  String get email_verification => 'Email Verification';

  @override
  String get email_verification_code_sent =>
      'A verification code has been sent to your email address.';

  @override
  String get resend_code => 'Resend code';

  @override
  String get enter_code => 'Enter code';

  @override
  String get enter_valid_email => 'Enter a valid email address';

  @override
  String get required_code_pin =>
      'To secure your account, please set a PIN code. Otherwise, some actions will be blocked.';

  @override
  String get request => 'Request';

  @override
  String get withdrawal => 'Withdrawal';

  @override
  String get transaction_error => 'Error loading transactions.';

  @override
  String notification_body(Object amount, Object sender) {
    return 'You received a transfer of $amount from $sender.';
  }

  @override
  String get notification_title => 'Transfer Received';

  @override
  String get insuficient_amount => 'Insufficient balance.';

  @override
  String get common_error =>
      'It seems your internet connection is unstable. Please check your connection and try again.';

  @override
  String get retry => 'Retry';

  @override
  String get add_beneficiary => 'Add Beneficiary';

  @override
  String get add_beneficiary_text =>
      'Add a beneficiary using the button below.';

  @override
  String get verification => 'Verification';

  @override
  String get confirm_beneficiary => 'Confirm Beneficiary';

  @override
  String get confirm_beneficiary_text =>
      'Make sure the information is correct before continuing.';

  @override
  String get not_correct => 'No, it is not correct.';

  @override
  String get correct_information => 'Yes, it is correct.';

  @override
  String get confirm_beneficiary_title => 'Verification';

  @override
  String get completed_name => 'Full Name';

  @override
  String get phone_number => 'Phone Number';

  @override
  String get confirm_transfer => 'Confirm Transfer';

  @override
  String get sender => 'Sender';

  @override
  String get account_number => 'Account Number';

  @override
  String get amount_to_be_withdrawn => 'Amount to withdraw';

  @override
  String get transfer_fees => 'Transfer Fees';

  @override
  String get transfer_amount => 'Transfer Amount';

  @override
  String get recipient => 'Recipient';

  @override
  String get firstname => 'First Name';

  @override
  String get lastname => 'Last Name';

  @override
  String get amount_to_be_received => 'Amount to receive';

  @override
  String get which_amount => 'For what amount?';

  @override
  String qr_code_user_text(Object name) {
    return 'This QR Code belongs to $name.';
  }

  @override
  String get qr_code_message =>
      'Show the QR Code below to a Cauris Pay user to receive the indicated amount.';

  @override
  String get qr_code_title => 'QR Code';

  @override
  String get finish => 'Finish';

  @override
  String get confirm_withdrawal => 'Confirm Withdrawal';

  @override
  String get withdrawal_fees => 'Withdrawal Fees';

  @override
  String get withdrawal_amount => 'Withdrawal Amount';

  @override
  String get netWork => 'Network';

  @override
  String get validate => 'Validate';

  @override
  String get cancel => 'Cancel';

  @override
  String get amount_request => 'Requested Amount';

  @override
  String amount_request_text(Object amount, Object currency, Object name) {
    return '$name is requesting $amount $currency from you.';
  }

  @override
  String get deposit => 'Deposit';

  @override
  String get transfer => 'Transfer';

  @override
  String get failed => 'Failed';

  @override
  String get download => 'Download';

  @override
  String notif_received(Object amount, Object currency, Object name) {
    return 'Received $amount $currency from $name';
  }

  @override
  String notif_sent(Object amount, Object currency, Object name) {
    return 'Sent $amount $currency to $name';
  }

  @override
  String notif_deposit(Object amount, Object currency, Object name) {
    return 'Deposit of $amount $currency via $name';
  }

  @override
  String notif_withdrawal(Object amount, Object currency, Object name) {
    return 'Withdrawal of $amount $currency to $name';
  }

  @override
  String get loading => 'Loading...';

  @override
  String get termsTextStart => 'By using this application, you agree to our ';

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  String get and => ' and our ';

  @override
  String get privacyPolicyText => 'Privacy Policy';

  @override
  String get loginWithPhone => 'Log in with your phone number.';

  @override
  String get loginWithEmail => 'Log in with your email address.';

  @override
  String get forgotPasswordPhoneDescription =>
      'Enter your phone number to receive a verification code.';

  @override
  String get forgotPasswordEmailDescription =>
      'Enter your email address to receive a verification code.';

  @override
  String get confirmEmailTitle => 'Confirm Your Email';

  @override
  String get codeNotReceived => 'Code not received? ';

  @override
  String get resend => 'Resend';

  @override
  String get resendIn => 'Resend code in ';

  @override
  String get resetPasswordDescription =>
      'Choose a new secure password for your account.';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String get passwordMatch => 'Passwords match';

  @override
  String get phoneDescription =>
      'Enter your phone number to create your account.';

  @override
  String get personalInfoDescription =>
      'Provide your personal information to create your account.';

  @override
  String get securityDescription =>
      'Create a secure password to protect your account.';

  @override
  String get pinDescription => 'Secure your account with a 6-digit code.';

  @override
  String get confirmPin => 'Re-enter your code to confirm';

  @override
  String get pinUsageHint =>
      'You will need to enter this for every transaction';

  @override
  String get pinMismatch => 'PIN codes do not match';

  @override
  String helloUser(Object name) {
    return 'Hello, $name 👋';
  }

  @override
  String get pinIncorrect => 'Incorrect PIN. Please try again.';

  @override
  String get forgotPin => 'Forgot PIN?';

  @override
  String get forgotPinTitle => 'Forgot PIN?';

  @override
  String get forgotPinDescription =>
      'Enter your phone number to receive a verification code and reset your PIN.';

  @override
  String get rememberPin => 'I remember my PIN';

  @override
  String get loginHere => 'Login';

  @override
  String get newPinTitle => 'New PIN Code';

  @override
  String get confirmPinTitle => 'Confirm PIN Code';

  @override
  String get newPinDescription => 'Choose a new 6-digit code';

  @override
  String get confirmPinDescription => 'Re-enter your new code to confirm';

  @override
  String get create => 'Create';

  @override
  String get fingerprintDescription =>
      'Enable or disable fingerprint authentication.';

  @override
  String get chooseLanguageDescription => 'Choose the application language.';

  @override
  String get addEmailDescription =>
      'Add an email address to your account for extra security.';

  @override
  String get validEmail => 'Valid email address';

  @override
  String get resendCodeIn => 'Resend code in';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationsSubtitle => 'Your latest activities';

  @override
  String get noNotifications => 'No notifications';

  @override
  String get notificationsEmptyDescription =>
      'Your activities will appear here';

  @override
  String get hello => 'Hello 👋';

  @override
  String get simpleSend => 'Simple Send';

  @override
  String get withdrawTo => 'Withdraw to';

  @override
  String get history => 'History';

  @override
  String get merchant => 'Merchant';

  @override
  String get availableBalanceLabel => 'Available Balance';

  @override
  String get receiveQrTitle => 'Receive Money via QR Code';

  @override
  String get qrSimple => 'Simple QR';

  @override
  String get qrSimpleDesc => 'Sender enters the amount';

  @override
  String get qrWithAmount => 'QR + Amount';

  @override
  String get qrWithAmountDesc => 'Preset amount to scan';

  @override
  String get sendQrTitle => 'Send Money by Scanning a QR Code';

  @override
  String get scanQrSimple => 'Simple QR';

  @override
  String get scanQrSimpleDesc => 'Scan your contact\'s QR';

  @override
  String get scanQrWithAmount => 'QR with Amount';

  @override
  String get scanQrWithAmountDesc => 'Amount included in the QR';

  @override
  String get comingSoonTitle => 'Merchant Space';

  @override
  String get comingSoonDescription =>
      'We are preparing something powerful for you. This feature will be available very soon.';

  @override
  String get comingSoonPayments => 'Payments';

  @override
  String get comingSoonStats => 'Statistics';

  @override
  String get comingSoonQr => 'Merchant QR';

  @override
  String get understood => 'Understood';

  @override
  String get appTagline => 'YOUR DIGITAL WALLET';

  @override
  String versionLabel(Object version) {
    return 'Version $version';
  }

  @override
  String get errorConnectionTitle => 'Connection Error';

  @override
  String get errorGenericTitle => 'Oops!';

  @override
  String get errorConnectionMessage =>
      'Please check your internet connection and try again.';

  @override
  String get errorGenericMessage =>
      'It seems there was a small hiccup. Please try again in a moment.';

  @override
  String get updateRequiredTitle => 'Update\nRequired';

  @override
  String get newVersionAvailableTitle => 'New Version\nAvailable';

  @override
  String get updateRequiredDescription =>
      'This update is required\nto continue using Caurispay.';

  @override
  String get updateAvailableDescription =>
      'Update Caurispay to\nenjoy the latest\nimprovements and fixes.';

  @override
  String get currentVersion => 'Current';

  @override
  String get newVersion => 'New';

  @override
  String get ignoreForNow => 'Ignore for now';

  @override
  String get connectionErrorTitle => 'Connection Problem';

  @override
  String get connectionErrorDescription =>
      'We couldn\'t establish a connection. Please check your internet connection.\nPress the button below to try again.';

  @override
  String get mobileRechargeTitle => 'Mobile Money Top-up';

  @override
  String amountLabel(Object amount) {
    return 'Amount: $amount';
  }

  @override
  String get operator => 'Operator';

  @override
  String get phoneExample => 'Ex: 77 123 45 67';

  @override
  String phoneLengthIndicator(Object current, Object max) {
    return '$current / $max digits';
  }

  @override
  String get mobileRecharge => 'Mobile Top-up';

  @override
  String get netAmount => 'Net';

  @override
  String get confirmRecharge => 'Confirm Top-up';

  @override
  String get securePayment => 'Secure Payment';

  @override
  String get chooseCountry => 'Choose a country';

  @override
  String get search => 'Search...';

  @override
  String get updatePasswordSubtitle =>
      'Enter your current password then choose a new one.';

  @override
  String get enterWithdrawalAmount =>
      'Enter the amount to withdraw from your wallet';

  @override
  String get digits => 'digits';

  @override
  String get withdrawal_confirmation => 'Withdrawal Confirmation';

  @override
  String get net => 'Net';

  @override
  String get secure_payment => 'Secure Payment';

  @override
  String get confirm_identity_withdrawal =>
      'Confirm your identity to validate the withdrawal';

  @override
  String get invalid_pin_code => 'Incorrect PIN. Please try again.';

  @override
  String get forgot_pin_code => 'Forgot PIN?';

  @override
  String get balance => 'Balance';

  @override
  String get enter_receiver_phone =>
      'Enter the phone number of the person you want to send money to';

  @override
  String get confirm_identity_transaction =>
      'Confirm your identity to validate the transaction';

  @override
  String get invalid_pin => 'Incorrect PIN. Please try again.';

  @override
  String get forgot_pin => 'Forgot PIN?';

  @override
  String get my_qr_code => 'My QR Code';

  @override
  String get secured_by => 'Secured by';

  @override
  String get qr_code_description =>
      'Share this QR code with the person who wants to send you money. They can scan it to initiate the payment quickly and securely.';

  @override
  String get enter_requested_amount => 'Enter the amount to request';

  @override
  String get payment_request => 'Payment Request';

  @override
  String scan_to_send(Object amount, Object currency) {
    return 'Scan to send $amount $currency';
  }

  @override
  String get camera_permission_denied => 'Camera access denied';

  @override
  String get wrong_qr_code => 'Wrong QR code';

  @override
  String get qr_code_with_amount_error =>
      'This QR code contains an amount. To use it, go back to the send screen and choose \"QR with Amount\".';

  @override
  String get got_it => 'Got it';

  @override
  String get scan_qr_simple_message =>
      'Scan the recipient\'s QR code to send money quickly and securely.';

  @override
  String get qr_scan_instruction =>
      'Scan the recipient\'s Simple QR code to send money quickly and securely.';

  @override
  String get qr_scan_simple_warning =>
      'Scan the user\'s simple QR code; you will be prompted to enter the amount later.';

  @override
  String get wrong_qr_code_description =>
      'This QR code contains an amount. Use the appropriate screen for this type of payment.';

  @override
  String get qr_scan_aim => 'Point at the SIMPLE QR CODE';

  @override
  String get qr_recipient_identified => 'Recipient identified via QR code';

  @override
  String get recipient_label => 'Recipient';

  @override
  String get amount_label => 'Amount';

  @override
  String get verified => 'Verified';

  @override
  String get qr_without_amount_error =>
      'Please scan a QR code containing an amount generated by the recipient.';

  @override
  String get qr_invalid_title => 'Incompatible QR code';

  @override
  String get qr_requires_amount_message =>
      'To continue, scan a QR code with an amount provided by the recipient.';

  @override
  String get confirm_payment => 'Confirm Payment';

  @override
  String get wrong_qr_description_amount =>
      'This QR code does not contain an amount. To use it, go back to the send screen and choose \'Contact QR\'.';

  @override
  String get qr_with_amount_description =>
      'Please scan a QR code with an amount from your recipient';

  @override
  String get success_operation => 'Your operation was completed successfully';

  @override
  String get no_transactions => 'No transactions';

  @override
  String get no_transactions_desc => 'Your operations will appear here';

  @override
  String get wrong_qr_type_title => 'Wrong QR code';

  @override
  String get wrong_qr_type_desc =>
      'This QR code does not contain an amount. Go back to the send screen and choose \'Contact QR\'.';

  @override
  String get tx_deposit => 'Deposit';

  @override
  String get tx_received => 'Received';

  @override
  String get tx_withdrawal => 'Withdrawal';

  @override
  String get tx_sent => 'Sent';

  @override
  String get transaction_detail => 'Transaction Detail';

  @override
  String get tx_detail_info => 'Information';

  @override
  String get tx_detail_name => 'Name';

  @override
  String get tx_detail_date => 'Date';

  @override
  String get tx_detail_type => 'Type';

  @override
  String get tx_detail_status => 'Status';

  @override
  String get tx_detail_reference => 'Reference';

  @override
  String get tx_no_reference => 'No reference';

  @override
  String get tx_success => 'Success';

  @override
  String get tx_failed => 'Failed';

  @override
  String get copy => 'Copy';

  @override
  String get copied => 'Copied';

  @override
  String get qr_download_success => 'QR code saved to your gallery';

  @override
  String get qr_download_error => 'Download failed, please try again';

  @override
  String get downloading => 'Downloading...';

  @override
  String get support => 'Support';

  @override
  String get support_hero_title => 'We\'re here to help';

  @override
  String get support_hero_desc =>
      'Our team is available to answer all your questions about CaurisPay.';

  @override
  String get support_contact_label => 'Contact us';

  @override
  String get support_phone_label => 'Phone';

  @override
  String get support_email_label => 'Email';

  @override
  String get support_address_label => 'Address';

  @override
  String get support_headquarters => 'Headquarters';

  @override
  String get support_region => 'West Africa';

  @override
  String get support_website_btn => 'Contact us via our website';

  @override
  String get back_to_home => 'Back to home';

  @override
  String get qrCodeSectionTitle => 'QR code';

  @override
  String get qrFreeAmountTitle => 'Receive an open amount';

  @override
  String get qrFreeAmountDesc => 'The sender enters the amount';

  @override
  String get qrFixedAmountTitle => 'Receive a fixed amount';

  @override
  String get qrFixedAmountDesc => 'The amount is already set';

  @override
  String get scanToPayTitle => 'Scan to pay';

  @override
  String get scanToPayDesc => 'Scan the recipient\'s code';

  @override
  String paymentRequestBannerTitle(String name, String amount) {
    return '$name is requesting $amount';
  }

  @override
  String paymentRequestBannerSubtitle(String time) {
    return 'Expires in $time';
  }

  @override
  String paymentRequestBannerSubtitleWithOthers(String time, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count others',
      one: '1 other',
    );
    return 'Expires in $time · $_temp0';
  }

  @override
  String paymentRequestBannerRequesterLine(String name) {
    return '$name is requesting';
  }

  @override
  String get expiresInLabel => 'Expires in';

  @override
  String viewOthersRequests(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'View $count other requests',
      one: 'View 1 other request',
    );
    return '$_temp0';
  }

  @override
  String get reject => 'Reject';

  @override
  String get paymentRequestsInboxTitle => 'Payment requests';

  @override
  String get emptyPaymentRequestsTitle => 'No pending requests';

  @override
  String get emptyPaymentRequestsBody =>
      'Payment requests you receive will show up here.';

  @override
  String get rejectConfirmTitle => 'Reject this request?';

  @override
  String rejectConfirmBody(String name) {
    return '$name won\'t receive a payment from you.';
  }

  @override
  String get confirmPaymentButton => 'Confirm payment';

  @override
  String get paymentRequestScreenTitle => 'Payment request';

  @override
  String paymentRequestScreenRequesterLine(String name) {
    return '$name is requesting';
  }

  @override
  String get paymentRequestExpiredSnack => 'This payment request has expired.';

  @override
  String get wrongPinError => 'Incorrect PIN code.';

  @override
  String get genericError => 'Something went wrong. Please try again.';

  @override
  String get close => 'Close';

  @override
  String get securedByPinLabel => 'Payment secured by PIN code';

  @override
  String get requestsFromLabel => 'is requesting';

  @override
  String get referenceLabel => 'Reference';

  @override
  String get expiresInFullLabel => 'This request expires in';

  @override
  String get rejectRequestButton => 'Reject request';

  @override
  String expiresInLabelInline(String time) {
    return 'Expires in $time';
  }

  @override
  String get noFeesApplied => 'No fees applied';

  @override
  String get irreversible_operation_warning =>
      'This operation cannot be undone once confirmed.';

  @override
  String get reference => 'Reference';

  @override
  String get auto_redirect_home => 'Automatically returning to home';

  @override
  String get cannot_add_self_beneficiary =>
      'This is your own number. You cannot add yourself as a beneficiary.';

  @override
  String get use_withdrawal_instead => 'Use a withdrawal instead.';

  @override
  String get add_this_contact => 'Add this contact';

  @override
  String get quickPayment => 'Quick payment';

  @override
  String get qr_scan_unified_description =>
      'Scan a recipient\'s QR code to send them money.';

  @override
  String get qr_scan_align_hint => 'Align the code within the frame';

  @override
  String get qr_scan_security_hint =>
      'Always verify the recipient\'s identity before confirming your transfer.';

  @override
  String get unrecognized_qr_title => 'Unrecognized code';

  @override
  String get unrecognized_qr_description =>
      'This code doesn\'t match any valid CaurisPay format. Make sure it comes from the app.';

  @override
  String get choose_from_gallery => 'Choose from gallery';

  @override
  String get request_expired_title => 'Request expired';

  @override
  String get request_expired_message =>
      'The confirmation window for this request has passed.';

  @override
  String get ok => 'OK';

  @override
  String get delete_account => 'Delete Account';

  @override
  String get delete_account_confirm_title => 'Delete your account?';

  @override
  String get delete_account_confirm_message =>
      'Your account will be permanently deleted in 14 days. All your data and transaction history will be erased and cannot be recovered. You can cancel within those 14 days.';

  @override
  String get delete_account_confirm_button => 'Yes, delete my account';

  @override
  String deletion_pending_banner(String date) {
    return 'Your account will be deleted on $date.';
  }

  @override
  String get cancel_deletion => 'Cancel deletion';

  @override
  String get cancel_deletion_confirm_title => 'Cancel account deletion?';

  @override
  String get cancel_deletion_confirm_message =>
      'Your account will remain active and all scheduled deletion will be cancelled.';

  @override
  String get cancel_deletion_confirm_button => 'Yes, keep my account';

  @override
  String get deletion_request_success =>
      'Your deletion request has been submitted. You have 14 days to cancel.';

  @override
  String get deletion_cancel_success =>
      'Your account deletion has been cancelled.';
}
