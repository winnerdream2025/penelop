import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

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
    Locale('fr'),
  ];

  /// Titre du premier écran d'onboarding
  ///
  /// In fr, this message translates to:
  /// **'Simple, rapide et sécurisé'**
  String get onboardingTitleOne;

  /// Titre du deuxième écran d'onboarding
  ///
  /// In fr, this message translates to:
  /// **'Transactions internationales'**
  String get onboardingTitleTwo;

  /// Description du premier écran d'onboarding
  ///
  /// In fr, this message translates to:
  /// **'Transférez de l\'argent rapidement avec des transactions totalement sécurisées.'**
  String get onboardingDescriptionOne;

  /// Description du deuxième écran d'onboarding
  ///
  /// In fr, this message translates to:
  /// **'Profitez d\'une liberté totale dans la gestion de vos finances, avec des frais réduits sur les transactions internationales.'**
  String get onboardingDescriptionTwo;

  /// Bouton suivant
  ///
  /// In fr, this message translates to:
  /// **'Suivant'**
  String get next;

  /// Bouton pour terminer l'onboarding
  ///
  /// In fr, this message translates to:
  /// **'Commencer'**
  String get start;

  /// Texte du bouton pour se connecter
  ///
  /// In fr, this message translates to:
  /// **'SE CONNECTER'**
  String get login;

  /// Texte du bouton pour s'inscrire
  ///
  /// In fr, this message translates to:
  /// **'S\'INSCRIRE'**
  String get register;

  /// Texte séparateur ou
  ///
  /// In fr, this message translates to:
  /// **'OU'**
  String get or;

  /// Texte du bouton pour continuer avec Google
  ///
  /// In fr, this message translates to:
  /// **'CONTINUER AVEC GOOGLE'**
  String get continueWithGoogle;

  /// Texte du choix de langue français
  ///
  /// In fr, this message translates to:
  /// **'Français'**
  String get french;

  /// Titre de la page de connexion
  ///
  /// In fr, this message translates to:
  /// **'Se connecter'**
  String get loginTitle;

  /// Libellé du champ email
  ///
  /// In fr, this message translates to:
  /// **'Email'**
  String get email;

  /// Label et placeholder du champ mot de passe
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe'**
  String get password;

  /// Bouton de validation de la connexion
  ///
  /// In fr, this message translates to:
  /// **'Connexion'**
  String get loginButton;

  /// Lien mot de passe oublié
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe oublié ?'**
  String get forgotPassword;

  /// Séparateur pour les méthodes alternatives de connexion
  ///
  /// In fr, this message translates to:
  /// **'OU CONNECTEZ-VOUS AVEC'**
  String get orLoginWith;

  /// Bouton de connexion par email
  ///
  /// In fr, this message translates to:
  /// **'E-MAIL'**
  String get emailMode;

  /// Bouton de connexion par numéro de téléphone
  ///
  /// In fr, this message translates to:
  /// **'NUMÉRO DE TÉLÉPHONE'**
  String get phoneMode;

  /// Connexion avec Google
  ///
  /// In fr, this message translates to:
  /// **'GOOGLE'**
  String get google;

  /// Titre de la page mot de passe oublié
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe oublié'**
  String get forgotPasswordTitle;

  /// Basculer vers la récupération par email
  ///
  /// In fr, this message translates to:
  /// **'UTILISER EMAIL'**
  String get useEmail;

  /// Basculer vers la récupération par téléphone
  ///
  /// In fr, this message translates to:
  /// **'UTILISER LE NUMÉRO DE TÉLÉPHONE'**
  String get usePhoneNumber;

  /// Titre de la page de confirmation du code OTP
  ///
  /// In fr, this message translates to:
  /// **'Confirmer votre numéro'**
  String get confirmOtpTitle;

  /// Description expliquant l'envoi du code OTP
  ///
  /// In fr, this message translates to:
  /// **'Nous avons envoyé un code par SMS. Saisissez-le pour continuer.'**
  String get confirmOtpDescription;

  /// Bouton de confirmation
  ///
  /// In fr, this message translates to:
  /// **'Confirmer'**
  String get confirm;

  /// Texte permettant de renvoyer le code OTP
  ///
  /// In fr, this message translates to:
  /// **'RENVOYER LE CODE'**
  String get resendCode;

  /// Titre de la page de réinitialisation du mot de passe
  ///
  /// In fr, this message translates to:
  /// **'Réinitialiser votre mot de passe'**
  String get resetPasswordTitle;

  /// Label et placeholder du champ confirmation du mot de passe
  ///
  /// In fr, this message translates to:
  /// **'Confirmer le mot de passe'**
  String get confirmPassword;

  /// Titre de la page téléphone
  ///
  /// In fr, this message translates to:
  /// **'Téléphone'**
  String get phoneTitle;

  /// Label du champ pays
  ///
  /// In fr, this message translates to:
  /// **'Pays'**
  String get country;

  /// Label et placeholder du numéro de téléphone
  ///
  /// In fr, this message translates to:
  /// **'Numéro'**
  String get phoneNumber;

  /// No description provided for @personalInfoTitle.
  ///
  /// In fr, this message translates to:
  /// **'Informations personnelles'**
  String get personalInfoTitle;

  /// No description provided for @lastName.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get lastName;

  /// No description provided for @firstName.
  ///
  /// In fr, this message translates to:
  /// **'Prénom'**
  String get firstName;

  /// No description provided for @securityTitle.
  ///
  /// In fr, this message translates to:
  /// **'Sécurisez votre compte'**
  String get securityTitle;

  /// No description provided for @addMoney.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get addMoney;

  /// No description provided for @send.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer'**
  String get send;

  /// No description provided for @receive.
  ///
  /// In fr, this message translates to:
  /// **'Recevoir'**
  String get receive;

  /// No description provided for @exchange.
  ///
  /// In fr, this message translates to:
  /// **'Échanger'**
  String get exchange;

  /// No description provided for @withdraw.
  ///
  /// In fr, this message translates to:
  /// **'Retirer'**
  String get withdraw;

  /// No description provided for @transactions.
  ///
  /// In fr, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @viewAll.
  ///
  /// In fr, this message translates to:
  /// **'Voir tout'**
  String get viewAll;

  /// No description provided for @enterAmountToRecharge.
  ///
  /// In fr, this message translates to:
  /// **'Entrez le montant à recharger'**
  String get enterAmountToRecharge;

  /// No description provided for @currency.
  ///
  /// In fr, this message translates to:
  /// **'FCFA'**
  String get currency;

  /// No description provided for @availableBalance.
  ///
  /// In fr, this message translates to:
  /// **'Solde disponible'**
  String get availableBalance;

  /// No description provided for @userName.
  ///
  /// In fr, this message translates to:
  /// **'{name}'**
  String userName(Object name);

  /// No description provided for @chooseRechargeMethod.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez la méthode de recharge'**
  String get chooseRechargeMethod;

  /// No description provided for @rechargeMethod.
  ///
  /// In fr, this message translates to:
  /// **'Méthode de recharge'**
  String get rechargeMethod;

  /// No description provided for @selectRechargeMethod.
  ///
  /// In fr, this message translates to:
  /// **'Sélectionnez une méthode de recharge'**
  String get selectRechargeMethod;

  /// No description provided for @fees.
  ///
  /// In fr, this message translates to:
  /// **'Frais'**
  String get fees;

  /// No description provided for @confirmYourNumber.
  ///
  /// In fr, this message translates to:
  /// **'Confirmez votre numéro'**
  String get confirmYourNumber;

  /// No description provided for @mobileMoney.
  ///
  /// In fr, this message translates to:
  /// **'Mobile Money'**
  String get mobileMoney;

  /// No description provided for @phoneNumberHint.
  ///
  /// In fr, this message translates to:
  /// **'34567890'**
  String get phoneNumberHint;

  /// No description provided for @selectMobileMoneyType.
  ///
  /// In fr, this message translates to:
  /// **'Sélectionnez le type de Mobile Money'**
  String get selectMobileMoneyType;

  /// No description provided for @willBeDebited.
  ///
  /// In fr, this message translates to:
  /// **'Vous serez débité sur votre compte {account} ({phone}) de {total} FCFA'**
  String willBeDebited(Object account, Object phone, Object total);

  /// No description provided for @recharge.
  ///
  /// In fr, this message translates to:
  /// **'Recharger'**
  String get recharge;

  /// No description provided for @rechargeSummary.
  ///
  /// In fr, this message translates to:
  /// **'Recharge de {amount} {currency} via {mobileMoney} ({phone})'**
  String rechargeSummary(
    Object amount,
    Object currency,
    Object mobileMoney,
    Object phone,
  );

  /// No description provided for @status.
  ///
  /// In fr, this message translates to:
  /// **'Statut'**
  String get status;

  /// No description provided for @pending.
  ///
  /// In fr, this message translates to:
  /// **'En attente'**
  String get pending;

  /// No description provided for @sentBy.
  ///
  /// In fr, this message translates to:
  /// **'Envoyé par'**
  String get sentBy;

  /// No description provided for @sentVia.
  ///
  /// In fr, this message translates to:
  /// **'Envoyé via'**
  String get sentVia;

  /// No description provided for @amount.
  ///
  /// In fr, this message translates to:
  /// **'Montant'**
  String get amount;

  /// No description provided for @account.
  ///
  /// In fr, this message translates to:
  /// **'Compte'**
  String get account;

  /// No description provided for @settings.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get settings;

  /// No description provided for @personalInfo.
  ///
  /// In fr, this message translates to:
  /// **'Informations personnelles'**
  String get personalInfo;

  /// No description provided for @security.
  ///
  /// In fr, this message translates to:
  /// **'Sécurité'**
  String get security;

  /// No description provided for @changePassword.
  ///
  /// In fr, this message translates to:
  /// **'Modifier votre mot de passe'**
  String get changePassword;

  /// No description provided for @changePinCode.
  ///
  /// In fr, this message translates to:
  /// **'Changer votre code de sécurité'**
  String get changePinCode;

  /// No description provided for @business.
  ///
  /// In fr, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @merchantAccount.
  ///
  /// In fr, this message translates to:
  /// **'Compte Marchand'**
  String get merchantAccount;

  /// No description provided for @preferences.
  ///
  /// In fr, this message translates to:
  /// **'Préférences'**
  String get preferences;

  /// No description provided for @privacyPolicy.
  ///
  /// In fr, this message translates to:
  /// **'Politique de confidentialité'**
  String get privacyPolicy;

  /// No description provided for @language.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get language;

  /// No description provided for @logout.
  ///
  /// In fr, this message translates to:
  /// **'Se déconnecter'**
  String get logout;

  /// No description provided for @userNameFull.
  ///
  /// In fr, this message translates to:
  /// **'Nom complet'**
  String get userNameFull;

  /// No description provided for @createPinCode.
  ///
  /// In fr, this message translates to:
  /// **'Créez votre code PIN'**
  String get createPinCode;

  /// No description provided for @enterPinCode.
  ///
  /// In fr, this message translates to:
  /// **'Entrez votre code PIN'**
  String get enterPinCode;

  /// No description provided for @personalInformation.
  ///
  /// In fr, this message translates to:
  /// **'Informations personnelles'**
  String get personalInformation;

  /// No description provided for @update.
  ///
  /// In fr, this message translates to:
  /// **'Mettre à jour'**
  String get update;

  /// No description provided for @updatePasswordTitle.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le mot de passe'**
  String get updatePasswordTitle;

  /// No description provided for @currentPassword.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe actuel'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau mot de passe'**
  String get newPassword;

  /// No description provided for @sendMoney.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer de l\'argent'**
  String get sendMoney;

  /// No description provided for @whatAmount.
  ///
  /// In fr, this message translates to:
  /// **'Quel montant ?'**
  String get whatAmount;

  /// No description provided for @toWho.
  ///
  /// In fr, this message translates to:
  /// **'À qui ?'**
  String get toWho;

  /// No description provided for @sendMoneyWarning.
  ///
  /// In fr, this message translates to:
  /// **'Votre envoi d\'argent sera débité depuis Cauris {account}. Il vous restera {balance} {currency}'**
  String sendMoneyWarning(Object account, Object balance, Object currency);

  /// No description provided for @newReceiver.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau Bénéficiaire'**
  String get newReceiver;

  /// No description provided for @accountNumber.
  ///
  /// In fr, this message translates to:
  /// **'Numéro de compte'**
  String get accountNumber;

  /// No description provided for @chooseReceiver.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez un bénéficiaire'**
  String get chooseReceiver;

  /// No description provided for @searchReceiver.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher un destinataire'**
  String get searchReceiver;

  /// No description provided for @addNewReceiver.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un nouveau destinataire'**
  String get addNewReceiver;

  /// No description provided for @savedReceivers.
  ///
  /// In fr, this message translates to:
  /// **'Destinataires enregistrés'**
  String get savedReceivers;

  /// No description provided for @verificationSuccessTitle.
  ///
  /// In fr, this message translates to:
  /// **'Vérification réussie'**
  String get verificationSuccessTitle;

  /// No description provided for @verificationSuccessMessage.
  ///
  /// In fr, this message translates to:
  /// **'Votre transfert d\'argent a été effectué avec succès.'**
  String get verificationSuccessMessage;

  /// No description provided for @continueButton.
  ///
  /// In fr, this message translates to:
  /// **'Continuer'**
  String get continueButton;

  /// No description provided for @pay.
  ///
  /// In fr, this message translates to:
  /// **'Payer'**
  String get pay;

  /// No description provided for @fingerPrint.
  ///
  /// In fr, this message translates to:
  /// **'Empreinte digitale'**
  String get fingerPrint;

  /// No description provided for @enable.
  ///
  /// In fr, this message translates to:
  /// **'Activé'**
  String get enable;

  /// No description provided for @disable.
  ///
  /// In fr, this message translates to:
  /// **'Désactivé'**
  String get disable;

  /// No description provided for @english.
  ///
  /// In fr, this message translates to:
  /// **'Anglais'**
  String get english;

  /// No description provided for @not_informed.
  ///
  /// In fr, this message translates to:
  /// **'Non renseigné'**
  String get not_informed;

  /// No description provided for @add.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get add;

  /// No description provided for @enter_your_email.
  ///
  /// In fr, this message translates to:
  /// **'Entrez votre email'**
  String get enter_your_email;

  /// No description provided for @email_verification.
  ///
  /// In fr, this message translates to:
  /// **'Vérification d\'adresse email'**
  String get email_verification;

  /// No description provided for @email_verification_code_sent.
  ///
  /// In fr, this message translates to:
  /// **'Un code de vérification a été envoyé à votre adresse email.'**
  String get email_verification_code_sent;

  /// No description provided for @resend_code.
  ///
  /// In fr, this message translates to:
  /// **'Renvoyer le code'**
  String get resend_code;

  /// No description provided for @enter_code.
  ///
  /// In fr, this message translates to:
  /// **'Entrez le code'**
  String get enter_code;

  /// No description provided for @enter_valid_email.
  ///
  /// In fr, this message translates to:
  /// **'Entrez une adresse email valide'**
  String get enter_valid_email;

  /// No description provided for @required_code_pin.
  ///
  /// In fr, this message translates to:
  /// **'Pour sécuriser votre compte, définissez un code PIN. Sinon, certaines actions seront bloquées.'**
  String get required_code_pin;

  /// No description provided for @request.
  ///
  /// In fr, this message translates to:
  /// **'Demander'**
  String get request;

  /// No description provided for @withdrawal.
  ///
  /// In fr, this message translates to:
  /// **'Retrait'**
  String get withdrawal;

  /// No description provided for @transaction_error.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors du chargement des transactions.'**
  String get transaction_error;

  /// No description provided for @notification_body.
  ///
  /// In fr, this message translates to:
  /// **'Vous avez reçu un virement de {amount} de {sender}.'**
  String notification_body(Object amount, Object sender);

  /// No description provided for @notification_title.
  ///
  /// In fr, this message translates to:
  /// **'Virement reçu'**
  String get notification_title;

  /// No description provided for @insuficient_amount.
  ///
  /// In fr, this message translates to:
  /// **'Montant insuffisant.'**
  String get insuficient_amount;

  /// No description provided for @common_error.
  ///
  /// In fr, this message translates to:
  /// **'\"Il semble que votre connexion Internet soit instable. Veuillez vérifier votre connexion et réessayer\",'**
  String get common_error;

  /// No description provided for @retry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get retry;

  /// No description provided for @add_beneficiary.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un bénéficiaire'**
  String get add_beneficiary;

  /// No description provided for @add_beneficiary_text.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez un bénéficiaire en utilisant le bouton ci-dessous.'**
  String get add_beneficiary_text;

  /// No description provided for @verification.
  ///
  /// In fr, this message translates to:
  /// **'Vérification'**
  String get verification;

  /// No description provided for @confirm_beneficiary.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer le bénéficiaire'**
  String get confirm_beneficiary;

  /// No description provided for @confirm_beneficiary_text.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez confirmer les informations du bénéficiaire avant de continuer'**
  String get confirm_beneficiary_text;

  /// No description provided for @not_correct.
  ///
  /// In fr, this message translates to:
  /// **'Non, ce n\'est pas correct.'**
  String get not_correct;

  /// No description provided for @correct_information.
  ///
  /// In fr, this message translates to:
  /// **'Oui, c\'est correct.'**
  String get correct_information;

  /// No description provided for @confirm_beneficiary_title.
  ///
  /// In fr, this message translates to:
  /// **'Vérification'**
  String get confirm_beneficiary_title;

  /// No description provided for @completed_name.
  ///
  /// In fr, this message translates to:
  /// **'Nom complet'**
  String get completed_name;

  /// No description provided for @phone_number.
  ///
  /// In fr, this message translates to:
  /// **'Numéro de téléphone'**
  String get phone_number;

  /// No description provided for @confirm_transfer.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer le transfert'**
  String get confirm_transfer;

  /// No description provided for @sender.
  ///
  /// In fr, this message translates to:
  /// **'Expéditeur'**
  String get sender;

  /// No description provided for @account_number.
  ///
  /// In fr, this message translates to:
  /// **'Numéro de compte'**
  String get account_number;

  /// No description provided for @amount_to_be_withdrawn.
  ///
  /// In fr, this message translates to:
  /// **'Montant à retirer'**
  String get amount_to_be_withdrawn;

  /// No description provided for @transfer_fees.
  ///
  /// In fr, this message translates to:
  /// **'Frais de transfert'**
  String get transfer_fees;

  /// No description provided for @transfer_amount.
  ///
  /// In fr, this message translates to:
  /// **'Montant du transfert'**
  String get transfer_amount;

  /// No description provided for @recipient.
  ///
  /// In fr, this message translates to:
  /// **'Destinataire'**
  String get recipient;

  /// No description provided for @firstname.
  ///
  /// In fr, this message translates to:
  /// **'Prénom'**
  String get firstname;

  /// No description provided for @lastname.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get lastname;

  /// No description provided for @amount_to_be_received.
  ///
  /// In fr, this message translates to:
  /// **'Montant à recevoir'**
  String get amount_to_be_received;

  /// No description provided for @which_amount.
  ///
  /// In fr, this message translates to:
  /// **'Pour quel montant ?'**
  String get which_amount;

  /// No description provided for @qr_code_user_text.
  ///
  /// In fr, this message translates to:
  /// **'Ce QR Code appartient à {name}.'**
  String qr_code_user_text(Object name);

  /// No description provided for @qr_code_message.
  ///
  /// In fr, this message translates to:
  /// **'Présentez le QR Code ci-dessous à un utilisateur Cauris Pay pour recevoir le montant indiqué.'**
  String get qr_code_message;

  /// No description provided for @qr_code_title.
  ///
  /// In fr, this message translates to:
  /// **'QR Code'**
  String get qr_code_title;

  /// No description provided for @finish.
  ///
  /// In fr, this message translates to:
  /// **'Terminer'**
  String get finish;

  /// No description provided for @confirm_withdrawal.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer le retrait'**
  String get confirm_withdrawal;

  /// No description provided for @withdrawal_fees.
  ///
  /// In fr, this message translates to:
  /// **'Frais de retrait'**
  String get withdrawal_fees;

  /// No description provided for @withdrawal_amount.
  ///
  /// In fr, this message translates to:
  /// **'Montant du retrait'**
  String get withdrawal_amount;

  /// No description provided for @netWork.
  ///
  /// In fr, this message translates to:
  /// **'Réseau'**
  String get netWork;

  /// No description provided for @validate.
  ///
  /// In fr, this message translates to:
  /// **'Valider'**
  String get validate;

  /// No description provided for @cancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancel;

  /// No description provided for @amount_request.
  ///
  /// In fr, this message translates to:
  /// **'Montant demandé'**
  String get amount_request;

  /// No description provided for @amount_request_text.
  ///
  /// In fr, this message translates to:
  /// **'{name} vous demande une somme de {amount} {currency}.'**
  String amount_request_text(Object amount, Object currency, Object name);

  /// No description provided for @deposit.
  ///
  /// In fr, this message translates to:
  /// **'Depot'**
  String get deposit;

  /// No description provided for @transfer.
  ///
  /// In fr, this message translates to:
  /// **'Transfert'**
  String get transfer;

  /// No description provided for @failed.
  ///
  /// In fr, this message translates to:
  /// **'Echec'**
  String get failed;

  /// No description provided for @download.
  ///
  /// In fr, this message translates to:
  /// **'Télecharger'**
  String get download;

  /// No description provided for @notif_received.
  ///
  /// In fr, this message translates to:
  /// **'Reçu {amount} {currency} de {name}'**
  String notif_received(Object amount, Object currency, Object name);

  /// No description provided for @notif_sent.
  ///
  /// In fr, this message translates to:
  /// **'Envoyé {amount} {currency} à {name}'**
  String notif_sent(Object amount, Object currency, Object name);

  /// No description provided for @notif_deposit.
  ///
  /// In fr, this message translates to:
  /// **'Dépôt de {amount} {currency} via {name}'**
  String notif_deposit(Object amount, Object currency, Object name);

  /// No description provided for @notif_withdrawal.
  ///
  /// In fr, this message translates to:
  /// **'Retrait de {amount} {currency} vers {name}'**
  String notif_withdrawal(Object amount, Object currency, Object name);

  /// No description provided for @loading.
  ///
  /// In fr, this message translates to:
  /// **'Chargement ....'**
  String get loading;

  /// Début de la phrase des conditions
  ///
  /// In fr, this message translates to:
  /// **'En utilisant cette application, vous acceptez nos '**
  String get termsTextStart;

  /// Texte du lien conditions
  ///
  /// In fr, this message translates to:
  /// **'Conditions d\'utilisation'**
  String get termsOfUse;

  /// Connexion entre conditions et politique
  ///
  /// In fr, this message translates to:
  /// **' et notre '**
  String get and;

  /// Texte du lien politique
  ///
  /// In fr, this message translates to:
  /// **'Politique de confidentialité'**
  String get privacyPolicyText;

  /// No description provided for @loginWithPhone.
  ///
  /// In fr, this message translates to:
  /// **'Connectez-vous avec votre numéro de téléphone.'**
  String get loginWithPhone;

  /// No description provided for @loginWithEmail.
  ///
  /// In fr, this message translates to:
  /// **'Connectez-vous avec votre adresse email.'**
  String get loginWithEmail;

  /// No description provided for @forgotPasswordPhoneDescription.
  ///
  /// In fr, this message translates to:
  /// **'Entrez votre numéro de téléphone pour recevoir un code de vérification.'**
  String get forgotPasswordPhoneDescription;

  /// No description provided for @forgotPasswordEmailDescription.
  ///
  /// In fr, this message translates to:
  /// **'Entrez votre adresse email pour recevoir un code de vérification.'**
  String get forgotPasswordEmailDescription;

  /// No description provided for @confirmEmailTitle.
  ///
  /// In fr, this message translates to:
  /// **'Confirmez votre email'**
  String get confirmEmailTitle;

  /// No description provided for @codeNotReceived.
  ///
  /// In fr, this message translates to:
  /// **'Code non reçu ? '**
  String get codeNotReceived;

  /// No description provided for @resend.
  ///
  /// In fr, this message translates to:
  /// **'Renvoyer'**
  String get resend;

  /// No description provided for @resendIn.
  ///
  /// In fr, this message translates to:
  /// **'Renvoyer le code dans '**
  String get resendIn;

  /// No description provided for @resetPasswordDescription.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez un nouveau mot de passe sécurisé pour votre compte.'**
  String get resetPasswordDescription;

  /// No description provided for @passwordMismatch.
  ///
  /// In fr, this message translates to:
  /// **'Les mots de passe ne correspondent pas'**
  String get passwordMismatch;

  /// No description provided for @passwordMatch.
  ///
  /// In fr, this message translates to:
  /// **'Les mots de passe correspondent'**
  String get passwordMatch;

  /// No description provided for @phoneDescription.
  ///
  /// In fr, this message translates to:
  /// **'Entrez votre numéro de téléphone pour créer votre compte.'**
  String get phoneDescription;

  /// No description provided for @personalInfoDescription.
  ///
  /// In fr, this message translates to:
  /// **'Vos informations personnelles.'**
  String get personalInfoDescription;

  /// No description provided for @securityDescription.
  ///
  /// In fr, this message translates to:
  /// **'Créez un mot de passe sécurisé pour protéger votre compte.'**
  String get securityDescription;

  /// No description provided for @pinDescription.
  ///
  /// In fr, this message translates to:
  /// **'Sécurisez votre compte avec un code à 6 chiffres.'**
  String get pinDescription;

  /// No description provided for @confirmPin.
  ///
  /// In fr, this message translates to:
  /// **'Ressaisissez votre code pour confirmer'**
  String get confirmPin;

  /// No description provided for @pinUsageHint.
  ///
  /// In fr, this message translates to:
  /// **'Vous devrez le saisir à chaque transaction'**
  String get pinUsageHint;

  /// No description provided for @pinMismatch.
  ///
  /// In fr, this message translates to:
  /// **'Les codes PIN ne correspondent pas'**
  String get pinMismatch;

  /// No description provided for @helloUser.
  ///
  /// In fr, this message translates to:
  /// **'Bonjour, {name} 👋'**
  String helloUser(Object name);

  /// No description provided for @pinIncorrect.
  ///
  /// In fr, this message translates to:
  /// **'Code PIN incorrect. Veuillez réessayer.'**
  String get pinIncorrect;

  /// No description provided for @forgotPin.
  ///
  /// In fr, this message translates to:
  /// **'Code PIN oublié ?'**
  String get forgotPin;

  /// No description provided for @forgotPinTitle.
  ///
  /// In fr, this message translates to:
  /// **'Code PIN oublié ?'**
  String get forgotPinTitle;

  /// No description provided for @forgotPinDescription.
  ///
  /// In fr, this message translates to:
  /// **'Entrez votre numéro de téléphone pour recevoir un code de vérification et réinitialiser votre PIN.'**
  String get forgotPinDescription;

  /// No description provided for @rememberPin.
  ///
  /// In fr, this message translates to:
  /// **'Je me souviens de mon code PIN'**
  String get rememberPin;

  /// No description provided for @loginHere.
  ///
  /// In fr, this message translates to:
  /// **'Connexion'**
  String get loginHere;

  /// No description provided for @newPinTitle.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau code PIN'**
  String get newPinTitle;

  /// No description provided for @confirmPinTitle.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer le code PIN'**
  String get confirmPinTitle;

  /// No description provided for @newPinDescription.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez un nouveau code à 6 chiffres'**
  String get newPinDescription;

  /// No description provided for @confirmPinDescription.
  ///
  /// In fr, this message translates to:
  /// **'Ressaisissez votre nouveau code pour confirmer'**
  String get confirmPinDescription;

  /// No description provided for @create.
  ///
  /// In fr, this message translates to:
  /// **'Créer'**
  String get create;

  /// No description provided for @fingerprintDescription.
  ///
  /// In fr, this message translates to:
  /// **'Activez ou désactivez l\'authentification par empreinte digitale.'**
  String get fingerprintDescription;

  /// No description provided for @chooseLanguageDescription.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez la langue de l\'application.'**
  String get chooseLanguageDescription;

  /// No description provided for @addEmailDescription.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez une adresse email à votre compte pour plus de sécurité.'**
  String get addEmailDescription;

  /// No description provided for @validEmail.
  ///
  /// In fr, this message translates to:
  /// **'Adresse email valide'**
  String get validEmail;

  /// No description provided for @resendCodeIn.
  ///
  /// In fr, this message translates to:
  /// **'Renvoyer le code dans'**
  String get resendCodeIn;

  /// No description provided for @notifications.
  ///
  /// In fr, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Vos dernières activités'**
  String get notificationsSubtitle;

  /// No description provided for @noNotifications.
  ///
  /// In fr, this message translates to:
  /// **'Aucune notification'**
  String get noNotifications;

  /// No description provided for @notificationsEmptyDescription.
  ///
  /// In fr, this message translates to:
  /// **'Vos activités apparaîtront ici'**
  String get notificationsEmptyDescription;

  /// No description provided for @hello.
  ///
  /// In fr, this message translates to:
  /// **'Bonjour 👋'**
  String get hello;

  /// No description provided for @simpleSend.
  ///
  /// In fr, this message translates to:
  /// **'Envoi Simple'**
  String get simpleSend;

  /// No description provided for @withdrawTo.
  ///
  /// In fr, this message translates to:
  /// **'Retrait vers'**
  String get withdrawTo;

  /// No description provided for @history.
  ///
  /// In fr, this message translates to:
  /// **'Historique'**
  String get history;

  /// No description provided for @merchant.
  ///
  /// In fr, this message translates to:
  /// **'Marchand'**
  String get merchant;

  /// No description provided for @availableBalanceLabel.
  ///
  /// In fr, this message translates to:
  /// **'Solde disponible'**
  String get availableBalanceLabel;

  /// No description provided for @receiveQrTitle.
  ///
  /// In fr, this message translates to:
  /// **'Recevoir de l\'argent via QR Code'**
  String get receiveQrTitle;

  /// No description provided for @qrSimple.
  ///
  /// In fr, this message translates to:
  /// **'QR Simple'**
  String get qrSimple;

  /// No description provided for @qrSimpleDesc.
  ///
  /// In fr, this message translates to:
  /// **'L\'expéditeur saisit le montant'**
  String get qrSimpleDesc;

  /// No description provided for @qrWithAmount.
  ///
  /// In fr, this message translates to:
  /// **'QR + Montant'**
  String get qrWithAmount;

  /// No description provided for @qrWithAmountDesc.
  ///
  /// In fr, this message translates to:
  /// **'Montant prédéfini à scanner'**
  String get qrWithAmountDesc;

  /// No description provided for @sendQrTitle.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer de l\'argent en scannant un QR Code'**
  String get sendQrTitle;

  /// No description provided for @scanQrSimple.
  ///
  /// In fr, this message translates to:
  /// **'QR Simple'**
  String get scanQrSimple;

  /// No description provided for @scanQrSimpleDesc.
  ///
  /// In fr, this message translates to:
  /// **'Scannez le QR de votre contact'**
  String get scanQrSimpleDesc;

  /// No description provided for @scanQrWithAmount.
  ///
  /// In fr, this message translates to:
  /// **'QR avec Montant'**
  String get scanQrWithAmount;

  /// No description provided for @scanQrWithAmountDesc.
  ///
  /// In fr, this message translates to:
  /// **'Montant inclus dans le QR'**
  String get scanQrWithAmountDesc;

  /// No description provided for @comingSoonTitle.
  ///
  /// In fr, this message translates to:
  /// **'Espace Marchand'**
  String get comingSoonTitle;

  /// No description provided for @comingSoonDescription.
  ///
  /// In fr, this message translates to:
  /// **'Nous vous préparons quelque chose de puissant. Cette fonctionnalité sera bientôt disponible.'**
  String get comingSoonDescription;

  /// No description provided for @comingSoonPayments.
  ///
  /// In fr, this message translates to:
  /// **'Paiements'**
  String get comingSoonPayments;

  /// No description provided for @comingSoonStats.
  ///
  /// In fr, this message translates to:
  /// **'Statistiques'**
  String get comingSoonStats;

  /// No description provided for @comingSoonQr.
  ///
  /// In fr, this message translates to:
  /// **'QR Marchand'**
  String get comingSoonQr;

  /// No description provided for @understood.
  ///
  /// In fr, this message translates to:
  /// **'Compris'**
  String get understood;

  /// No description provided for @appTagline.
  ///
  /// In fr, this message translates to:
  /// **'VOTRE PORTEFEUILLE NUMÉRIQUE'**
  String get appTagline;

  /// No description provided for @versionLabel.
  ///
  /// In fr, this message translates to:
  /// **'Version {version}'**
  String versionLabel(Object version);

  /// No description provided for @errorConnectionTitle.
  ///
  /// In fr, this message translates to:
  /// **'Erreur de connexion'**
  String get errorConnectionTitle;

  /// No description provided for @errorGenericTitle.
  ///
  /// In fr, this message translates to:
  /// **'Oups !'**
  String get errorGenericTitle;

  /// No description provided for @errorConnectionMessage.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez vérifier votre connexion internet et réessayer.'**
  String get errorConnectionMessage;

  /// No description provided for @errorGenericMessage.
  ///
  /// In fr, this message translates to:
  /// **'Il semble y avoir un petit problème. Veuillez réessayer dans un instant.'**
  String get errorGenericMessage;

  /// No description provided for @updateRequiredTitle.
  ///
  /// In fr, this message translates to:
  /// **'Mise à jour\nRequise'**
  String get updateRequiredTitle;

  /// No description provided for @newVersionAvailableTitle.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle version\nDisponible'**
  String get newVersionAvailableTitle;

  /// No description provided for @updateRequiredDescription.
  ///
  /// In fr, this message translates to:
  /// **'Cette mise à jour est nécessaire\npour continuer à utiliser Caurispay.'**
  String get updateRequiredDescription;

  /// No description provided for @updateAvailableDescription.
  ///
  /// In fr, this message translates to:
  /// **'Mettez à jour Caurispay pour\nprofiter des dernières\naméliorations et corrections.'**
  String get updateAvailableDescription;

  /// No description provided for @currentVersion.
  ///
  /// In fr, this message translates to:
  /// **'Actuelle'**
  String get currentVersion;

  /// No description provided for @newVersion.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle'**
  String get newVersion;

  /// No description provided for @ignoreForNow.
  ///
  /// In fr, this message translates to:
  /// **'Ignorer pour l\'instant'**
  String get ignoreForNow;

  /// No description provided for @connectionErrorTitle.
  ///
  /// In fr, this message translates to:
  /// **'Problème de connexion'**
  String get connectionErrorTitle;

  /// No description provided for @connectionErrorDescription.
  ///
  /// In fr, this message translates to:
  /// **'Nous n\'avons pas pu établir de connexion. Veuillez vérifier votre connexion internet.\nAppuyez sur le bouton ci-dessous pour réessayer.'**
  String get connectionErrorDescription;

  /// No description provided for @mobileRechargeTitle.
  ///
  /// In fr, this message translates to:
  /// **'Recharge Mobile Money'**
  String get mobileRechargeTitle;

  /// No description provided for @amountLabel.
  ///
  /// In fr, this message translates to:
  /// **'Montant : {amount}'**
  String amountLabel(Object amount);

  /// No description provided for @operator.
  ///
  /// In fr, this message translates to:
  /// **'Opérateur'**
  String get operator;

  /// No description provided for @phoneExample.
  ///
  /// In fr, this message translates to:
  /// **'Ex: 77 123 45 67'**
  String get phoneExample;

  /// No description provided for @phoneLengthIndicator.
  ///
  /// In fr, this message translates to:
  /// **'{current} / {max} chiffres'**
  String phoneLengthIndicator(Object current, Object max);

  /// No description provided for @mobileRecharge.
  ///
  /// In fr, this message translates to:
  /// **'Recharge Mobile'**
  String get mobileRecharge;

  /// No description provided for @netAmount.
  ///
  /// In fr, this message translates to:
  /// **'Net'**
  String get netAmount;

  /// No description provided for @confirmRecharge.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer la recharge'**
  String get confirmRecharge;

  /// No description provided for @securePayment.
  ///
  /// In fr, this message translates to:
  /// **'Paiement sécurisé'**
  String get securePayment;

  /// No description provided for @chooseCountry.
  ///
  /// In fr, this message translates to:
  /// **'Choisir un pays'**
  String get chooseCountry;

  /// No description provided for @search.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher...'**
  String get search;

  /// No description provided for @updatePasswordSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Entrez votre mot de passe actuel puis choisissez-en un nouveau.'**
  String get updatePasswordSubtitle;

  /// No description provided for @enterWithdrawalAmount.
  ///
  /// In fr, this message translates to:
  /// **'Entrez le montant à retirer de votre portefeuille'**
  String get enterWithdrawalAmount;

  /// No description provided for @digits.
  ///
  /// In fr, this message translates to:
  /// **'chiffres'**
  String get digits;

  /// No description provided for @withdrawal_confirmation.
  ///
  /// In fr, this message translates to:
  /// **'Confirmation de retrait'**
  String get withdrawal_confirmation;

  /// No description provided for @net.
  ///
  /// In fr, this message translates to:
  /// **'Net'**
  String get net;

  /// No description provided for @secure_payment.
  ///
  /// In fr, this message translates to:
  /// **'Paiement sécurisé'**
  String get secure_payment;

  /// No description provided for @confirm_identity_withdrawal.
  ///
  /// In fr, this message translates to:
  /// **'Confirmez votre identité pour valider le retrait'**
  String get confirm_identity_withdrawal;

  /// No description provided for @invalid_pin_code.
  ///
  /// In fr, this message translates to:
  /// **'Code PIN incorrect. Veuillez réessayer.'**
  String get invalid_pin_code;

  /// No description provided for @forgot_pin_code.
  ///
  /// In fr, this message translates to:
  /// **'Code PIN oublié ?'**
  String get forgot_pin_code;

  /// No description provided for @balance.
  ///
  /// In fr, this message translates to:
  /// **'Solde'**
  String get balance;

  /// No description provided for @enter_receiver_phone.
  ///
  /// In fr, this message translates to:
  /// **'Entrez le numéro de téléphone de la personne à qui vous souhaitez envoyer de l\'argent'**
  String get enter_receiver_phone;

  /// No description provided for @confirm_identity_transaction.
  ///
  /// In fr, this message translates to:
  /// **'Confirmez votre identité pour valider la transaction'**
  String get confirm_identity_transaction;

  /// No description provided for @invalid_pin.
  ///
  /// In fr, this message translates to:
  /// **'Code PIN incorrect. Veuillez réessayer.'**
  String get invalid_pin;

  /// No description provided for @forgot_pin.
  ///
  /// In fr, this message translates to:
  /// **'Code PIN oublié ?'**
  String get forgot_pin;

  /// No description provided for @my_qr_code.
  ///
  /// In fr, this message translates to:
  /// **'Mon QR Code'**
  String get my_qr_code;

  /// No description provided for @secured_by.
  ///
  /// In fr, this message translates to:
  /// **'Sécurisé par'**
  String get secured_by;

  /// No description provided for @qr_code_description.
  ///
  /// In fr, this message translates to:
  /// **'Partagez ce QR code avec la personne qui souhaite vous envoyer de l\'argent. Elle pourra le scanner pour initier le paiement rapidement et en toute sécurité.'**
  String get qr_code_description;

  /// No description provided for @enter_requested_amount.
  ///
  /// In fr, this message translates to:
  /// **'Entrez le montant à demander'**
  String get enter_requested_amount;

  /// No description provided for @payment_request.
  ///
  /// In fr, this message translates to:
  /// **'Demande de paiement'**
  String get payment_request;

  /// No description provided for @scan_to_send.
  ///
  /// In fr, this message translates to:
  /// **'Scannez pour envoyer {amount} {currency}'**
  String scan_to_send(Object amount, Object currency);

  /// No description provided for @camera_permission_denied.
  ///
  /// In fr, this message translates to:
  /// **'Accès à la caméra refusé'**
  String get camera_permission_denied;

  /// No description provided for @wrong_qr_code.
  ///
  /// In fr, this message translates to:
  /// **'Mauvais QR code'**
  String get wrong_qr_code;

  /// No description provided for @qr_code_with_amount_error.
  ///
  /// In fr, this message translates to:
  /// **'Ce QR code contient un montant. Pour l\'utiliser, retournez à l\'écran d\'envoi et choisissez \"QR avec Montant\".'**
  String get qr_code_with_amount_error;

  /// No description provided for @got_it.
  ///
  /// In fr, this message translates to:
  /// **'Compris'**
  String get got_it;

  /// No description provided for @scan_qr_simple_message.
  ///
  /// In fr, this message translates to:
  /// **'Scannez le QR code du destinataire pour envoyer de l\'argent rapidement et en toute sécurité.'**
  String get scan_qr_simple_message;

  /// No description provided for @qr_scan_instruction.
  ///
  /// In fr, this message translates to:
  /// **'Scannez le QR code Simple du destinataire pour envoyer de l\'argent rapidement et en toute sécurité.'**
  String get qr_scan_instruction;

  /// No description provided for @qr_scan_simple_warning.
  ///
  /// In fr, this message translates to:
  /// **'Scannez le QR code simple de l\'utilisateur ; vous serez invité à saisir le montant plus tard.'**
  String get qr_scan_simple_warning;

  /// No description provided for @wrong_qr_code_description.
  ///
  /// In fr, this message translates to:
  /// **'Ce QR code contient un montant. Utilisez l\'écran approprié pour ce type de paiement.'**
  String get wrong_qr_code_description;

  /// No description provided for @qr_scan_aim.
  ///
  /// In fr, this message translates to:
  /// **'Pointez vers le QR CODE SIMPLE'**
  String get qr_scan_aim;

  /// No description provided for @qr_recipient_identified.
  ///
  /// In fr, this message translates to:
  /// **'Destinataire identifié via QR code'**
  String get qr_recipient_identified;

  /// No description provided for @recipient_label.
  ///
  /// In fr, this message translates to:
  /// **'Destinataire'**
  String get recipient_label;

  /// No description provided for @amount_label.
  ///
  /// In fr, this message translates to:
  /// **'Montant'**
  String get amount_label;

  /// No description provided for @verified.
  ///
  /// In fr, this message translates to:
  /// **'Vérifié'**
  String get verified;

  /// No description provided for @qr_without_amount_error.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez scanner un QR code contenant un montant généré par le destinataire.'**
  String get qr_without_amount_error;

  /// No description provided for @qr_invalid_title.
  ///
  /// In fr, this message translates to:
  /// **'QR code incompatible'**
  String get qr_invalid_title;

  /// No description provided for @qr_requires_amount_message.
  ///
  /// In fr, this message translates to:
  /// **'Pour continuer, scannez un QR code avec un montant fourni par le destinataire.'**
  String get qr_requires_amount_message;

  /// No description provided for @confirm_payment.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer le paiement'**
  String get confirm_payment;

  /// No description provided for @wrong_qr_description_amount.
  ///
  /// In fr, this message translates to:
  /// **'Ce QR code ne contient pas de montant. Pour l\'utiliser, retournez à l\'écran d\'envoi et choisissez \'Contact QR\'.'**
  String get wrong_qr_description_amount;

  /// No description provided for @qr_with_amount_description.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez scanner un QR code avec un montant de votre destinataire'**
  String get qr_with_amount_description;

  /// No description provided for @success_operation.
  ///
  /// In fr, this message translates to:
  /// **'Votre opération a été effectuée avec succès'**
  String get success_operation;

  /// No description provided for @no_transactions.
  ///
  /// In fr, this message translates to:
  /// **'Aucune transaction'**
  String get no_transactions;

  /// No description provided for @no_transactions_desc.
  ///
  /// In fr, this message translates to:
  /// **'Vos opérations apparaîtront ici'**
  String get no_transactions_desc;

  /// No description provided for @wrong_qr_type_title.
  ///
  /// In fr, this message translates to:
  /// **'Mauvais QR code'**
  String get wrong_qr_type_title;

  /// No description provided for @wrong_qr_type_desc.
  ///
  /// In fr, this message translates to:
  /// **'Ce QR code ne contient pas de montant. Retournez à l\'écran d\'envoi et choisissez \'Contact QR\'.'**
  String get wrong_qr_type_desc;

  /// No description provided for @tx_deposit.
  ///
  /// In fr, this message translates to:
  /// **'Dépôt'**
  String get tx_deposit;

  /// No description provided for @tx_received.
  ///
  /// In fr, this message translates to:
  /// **'Reçu'**
  String get tx_received;

  /// No description provided for @tx_withdrawal.
  ///
  /// In fr, this message translates to:
  /// **'Retrait'**
  String get tx_withdrawal;

  /// No description provided for @tx_sent.
  ///
  /// In fr, this message translates to:
  /// **'Envoyé'**
  String get tx_sent;

  /// No description provided for @transaction_detail.
  ///
  /// In fr, this message translates to:
  /// **'Détail de la transaction'**
  String get transaction_detail;

  /// No description provided for @tx_detail_info.
  ///
  /// In fr, this message translates to:
  /// **'Informations'**
  String get tx_detail_info;

  /// No description provided for @tx_detail_name.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get tx_detail_name;

  /// No description provided for @tx_detail_date.
  ///
  /// In fr, this message translates to:
  /// **'Date'**
  String get tx_detail_date;

  /// No description provided for @tx_detail_type.
  ///
  /// In fr, this message translates to:
  /// **'Type'**
  String get tx_detail_type;

  /// No description provided for @tx_detail_status.
  ///
  /// In fr, this message translates to:
  /// **'Statut'**
  String get tx_detail_status;

  /// No description provided for @tx_detail_reference.
  ///
  /// In fr, this message translates to:
  /// **'Référence'**
  String get tx_detail_reference;

  /// No description provided for @tx_no_reference.
  ///
  /// In fr, this message translates to:
  /// **'Aucune référence'**
  String get tx_no_reference;

  /// No description provided for @tx_success.
  ///
  /// In fr, this message translates to:
  /// **'Succès'**
  String get tx_success;

  /// No description provided for @tx_failed.
  ///
  /// In fr, this message translates to:
  /// **'Échec'**
  String get tx_failed;

  /// No description provided for @copy.
  ///
  /// In fr, this message translates to:
  /// **'Copier'**
  String get copy;

  /// No description provided for @copied.
  ///
  /// In fr, this message translates to:
  /// **'Copié'**
  String get copied;

  /// No description provided for @qr_download_success.
  ///
  /// In fr, this message translates to:
  /// **'QR code enregistré dans votre galerie'**
  String get qr_download_success;

  /// No description provided for @qr_download_error.
  ///
  /// In fr, this message translates to:
  /// **'Échec du téléchargement, veuillez réessayer'**
  String get qr_download_error;

  /// No description provided for @downloading.
  ///
  /// In fr, this message translates to:
  /// **'Téléchargement...'**
  String get downloading;

  /// No description provided for @support.
  ///
  /// In fr, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @support_hero_title.
  ///
  /// In fr, this message translates to:
  /// **'Nous sommes là pour vous aider'**
  String get support_hero_title;

  /// No description provided for @support_hero_desc.
  ///
  /// In fr, this message translates to:
  /// **'Notre équipe répond à toutes vos questions sur CaurisPay.'**
  String get support_hero_desc;

  /// No description provided for @support_contact_label.
  ///
  /// In fr, this message translates to:
  /// **'Nous contacter'**
  String get support_contact_label;

  /// No description provided for @support_phone_label.
  ///
  /// In fr, this message translates to:
  /// **'Téléphone'**
  String get support_phone_label;

  /// No description provided for @support_email_label.
  ///
  /// In fr, this message translates to:
  /// **'Email'**
  String get support_email_label;

  /// No description provided for @support_address_label.
  ///
  /// In fr, this message translates to:
  /// **'Adresse'**
  String get support_address_label;

  /// No description provided for @support_headquarters.
  ///
  /// In fr, this message translates to:
  /// **'Siège social'**
  String get support_headquarters;

  /// No description provided for @support_region.
  ///
  /// In fr, this message translates to:
  /// **'Afrique de l\'Ouest'**
  String get support_region;

  /// No description provided for @support_website_btn.
  ///
  /// In fr, this message translates to:
  /// **'Contacter via notre site web'**
  String get support_website_btn;

  /// No description provided for @back_to_home.
  ///
  /// In fr, this message translates to:
  /// **'Retour à l\'accueil'**
  String get back_to_home;

  /// No description provided for @qrCodeSectionTitle.
  ///
  /// In fr, this message translates to:
  /// **'QR code'**
  String get qrCodeSectionTitle;

  /// No description provided for @qrFreeAmountTitle.
  ///
  /// In fr, this message translates to:
  /// **'Recevoir un montant libre'**
  String get qrFreeAmountTitle;

  /// No description provided for @qrFreeAmountDesc.
  ///
  /// In fr, this message translates to:
  /// **'L\'expéditeur saisit le montant'**
  String get qrFreeAmountDesc;

  /// No description provided for @qrFixedAmountTitle.
  ///
  /// In fr, this message translates to:
  /// **'Recevoir un montant fixe'**
  String get qrFixedAmountTitle;

  /// No description provided for @qrFixedAmountDesc.
  ///
  /// In fr, this message translates to:
  /// **'Le montant est déjà défini'**
  String get qrFixedAmountDesc;

  /// No description provided for @scanToPayTitle.
  ///
  /// In fr, this message translates to:
  /// **'Scanner'**
  String get scanToPayTitle;

  /// No description provided for @scanToPayDesc.
  ///
  /// In fr, this message translates to:
  /// **'Scannez le code du destinataire'**
  String get scanToPayDesc;

  /// No description provided for @paymentRequestBannerTitle.
  ///
  /// In fr, this message translates to:
  /// **'{name} vous demande {amount}'**
  String paymentRequestBannerTitle(String name, String amount);

  /// No description provided for @paymentRequestBannerSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Expire dans {time}'**
  String paymentRequestBannerSubtitle(String time);

  /// No description provided for @paymentRequestBannerSubtitleWithOthers.
  ///
  /// In fr, this message translates to:
  /// **'Expire dans {time} · {count, plural, one{1 autre} other{{count} autres}}'**
  String paymentRequestBannerSubtitleWithOthers(String time, int count);

  /// No description provided for @paymentRequestBannerRequesterLine.
  ///
  /// In fr, this message translates to:
  /// **'{name} vous demande'**
  String paymentRequestBannerRequesterLine(String name);

  /// No description provided for @expiresInLabel.
  ///
  /// In fr, this message translates to:
  /// **'Expire dans'**
  String get expiresInLabel;

  /// No description provided for @viewOthersRequests.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, one{Voir 1 autre demande} other{Voir les {count} autres demandes}}'**
  String viewOthersRequests(int count);

  /// No description provided for @reject.
  ///
  /// In fr, this message translates to:
  /// **'Refuser'**
  String get reject;

  /// No description provided for @paymentRequestsInboxTitle.
  ///
  /// In fr, this message translates to:
  /// **'Demandes de paiement'**
  String get paymentRequestsInboxTitle;

  /// No description provided for @emptyPaymentRequestsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Aucune demande en attente'**
  String get emptyPaymentRequestsTitle;

  /// No description provided for @emptyPaymentRequestsBody.
  ///
  /// In fr, this message translates to:
  /// **'Les demandes de paiement que vous recevez apparaîtront ici.'**
  String get emptyPaymentRequestsBody;

  /// No description provided for @rejectConfirmTitle.
  ///
  /// In fr, this message translates to:
  /// **'Refuser cette demande ?'**
  String get rejectConfirmTitle;

  /// No description provided for @rejectConfirmBody.
  ///
  /// In fr, this message translates to:
  /// **'{name} ne recevra pas de paiement de votre part.'**
  String rejectConfirmBody(String name);

  /// No description provided for @confirmPaymentButton.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer le paiement'**
  String get confirmPaymentButton;

  /// No description provided for @paymentRequestScreenTitle.
  ///
  /// In fr, this message translates to:
  /// **'Demande de paiement'**
  String get paymentRequestScreenTitle;

  /// No description provided for @paymentRequestScreenRequesterLine.
  ///
  /// In fr, this message translates to:
  /// **'{name} vous demande'**
  String paymentRequestScreenRequesterLine(String name);

  /// No description provided for @paymentRequestExpiredSnack.
  ///
  /// In fr, this message translates to:
  /// **'Cette demande de paiement a expiré.'**
  String get paymentRequestExpiredSnack;

  /// No description provided for @wrongPinError.
  ///
  /// In fr, this message translates to:
  /// **'Code PIN incorrect.'**
  String get wrongPinError;

  /// No description provided for @genericError.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur est survenue. Réessayez.'**
  String get genericError;

  /// No description provided for @close.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get close;

  /// No description provided for @securedByPinLabel.
  ///
  /// In fr, this message translates to:
  /// **'Paiement sécurisé par code PIN'**
  String get securedByPinLabel;

  /// No description provided for @requestsFromLabel.
  ///
  /// In fr, this message translates to:
  /// **'vous demande'**
  String get requestsFromLabel;

  /// No description provided for @referenceLabel.
  ///
  /// In fr, this message translates to:
  /// **'Référence'**
  String get referenceLabel;

  /// No description provided for @expiresInFullLabel.
  ///
  /// In fr, this message translates to:
  /// **'Cette demande expire dans'**
  String get expiresInFullLabel;

  /// No description provided for @rejectRequestButton.
  ///
  /// In fr, this message translates to:
  /// **'Refuser la demande'**
  String get rejectRequestButton;

  /// No description provided for @expiresInLabelInline.
  ///
  /// In fr, this message translates to:
  /// **'Expire dans {time}'**
  String expiresInLabelInline(String time);

  /// No description provided for @noFeesApplied.
  ///
  /// In fr, this message translates to:
  /// **'Aucuns frais appliqués'**
  String get noFeesApplied;

  /// No description provided for @irreversible_operation_warning.
  ///
  /// In fr, this message translates to:
  /// **'Cette opération est irréversible une fois confirmée.'**
  String get irreversible_operation_warning;

  /// No description provided for @reference.
  ///
  /// In fr, this message translates to:
  /// **'Référence'**
  String get reference;

  /// No description provided for @auto_redirect_home.
  ///
  /// In fr, this message translates to:
  /// **'Retour automatique à l\'accueil'**
  String get auto_redirect_home;

  /// No description provided for @cannot_add_self_beneficiary.
  ///
  /// In fr, this message translates to:
  /// **'C\'est votre propre numéro. Vous ne pouvez pas vous ajouter comme bénéficiaire.'**
  String get cannot_add_self_beneficiary;

  /// No description provided for @use_withdrawal_instead.
  ///
  /// In fr, this message translates to:
  /// **'Utilisez plutôt un retrait.'**
  String get use_withdrawal_instead;

  /// No description provided for @add_this_contact.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter ce contact'**
  String get add_this_contact;

  /// No description provided for @quickPayment.
  ///
  /// In fr, this message translates to:
  /// **'Paiement rapide'**
  String get quickPayment;

  /// No description provided for @qr_scan_unified_description.
  ///
  /// In fr, this message translates to:
  /// **'Scannez le QR code d\'un bénéficiaire pour lui envoyer de l\'argent.'**
  String get qr_scan_unified_description;

  /// No description provided for @qr_scan_align_hint.
  ///
  /// In fr, this message translates to:
  /// **'Alignez le code dans le cadre'**
  String get qr_scan_align_hint;

  /// No description provided for @qr_scan_security_hint.
  ///
  /// In fr, this message translates to:
  /// **'Vérifiez toujours l\'identité du destinataire avant de confirmer votre envoi.'**
  String get qr_scan_security_hint;

  /// No description provided for @unrecognized_qr_title.
  ///
  /// In fr, this message translates to:
  /// **'Code non reconnu'**
  String get unrecognized_qr_title;

  /// No description provided for @unrecognized_qr_description.
  ///
  /// In fr, this message translates to:
  /// **'Ce code ne correspond à aucun format CaurisPay valide. Assurez-vous qu\'il provient bien de l\'application.'**
  String get unrecognized_qr_description;

  /// No description provided for @choose_from_gallery.
  ///
  /// In fr, this message translates to:
  /// **'Choisir depuis la galerie'**
  String get choose_from_gallery;

  /// No description provided for @request_expired_title.
  ///
  /// In fr, this message translates to:
  /// **'Demande expirée'**
  String get request_expired_title;

  /// No description provided for @request_expired_message.
  ///
  /// In fr, this message translates to:
  /// **'Le délai pour confirmer cette demande est dépassé.'**
  String get request_expired_message;

  /// No description provided for @ok.
  ///
  /// In fr, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @delete_account.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer le compte'**
  String get delete_account;

  /// No description provided for @delete_account_confirm_title.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer votre compte ?'**
  String get delete_account_confirm_title;

  /// No description provided for @delete_account_confirm_message.
  ///
  /// In fr, this message translates to:
  /// **'Votre compte sera définitivement supprimé dans 14 jours. Toutes vos données et votre historique de transactions seront effacés et ne pourront pas être récupérés. Vous pouvez annuler dans les 14 jours.'**
  String get delete_account_confirm_message;

  /// No description provided for @delete_account_confirm_button.
  ///
  /// In fr, this message translates to:
  /// **'Oui, supprimer mon compte'**
  String get delete_account_confirm_button;

  /// No description provided for @deletion_pending_banner.
  ///
  /// In fr, this message translates to:
  /// **'Votre compte sera supprimé le {date}.'**
  String deletion_pending_banner(String date);

  /// No description provided for @cancel_deletion.
  ///
  /// In fr, this message translates to:
  /// **'Annuler la suppression'**
  String get cancel_deletion;

  /// No description provided for @cancel_deletion_confirm_title.
  ///
  /// In fr, this message translates to:
  /// **'Annuler la suppression du compte ?'**
  String get cancel_deletion_confirm_title;

  /// No description provided for @cancel_deletion_confirm_message.
  ///
  /// In fr, this message translates to:
  /// **'Votre compte restera actif et la demande de suppression sera annulée.'**
  String get cancel_deletion_confirm_message;

  /// No description provided for @cancel_deletion_confirm_button.
  ///
  /// In fr, this message translates to:
  /// **'Oui, conserver mon compte'**
  String get cancel_deletion_confirm_button;

  /// No description provided for @deletion_request_success.
  ///
  /// In fr, this message translates to:
  /// **'Votre demande de suppression a été soumise. Vous avez 14 jours pour l\'annuler.'**
  String get deletion_request_success;

  /// No description provided for @deletion_cancel_success.
  ///
  /// In fr, this message translates to:
  /// **'La suppression de votre compte a été annulée.'**
  String get deletion_cancel_success;
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
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
