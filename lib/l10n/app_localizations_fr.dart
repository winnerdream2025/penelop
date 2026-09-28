// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get onboardingTitleOne => 'Simple, rapide et sécurisé';

  @override
  String get onboardingTitleTwo => 'Transactions internationales';

  @override
  String get onboardingDescriptionOne =>
      'Transférez de l\'argent rapidement avec des transactions totalement sécurisées.';

  @override
  String get onboardingDescriptionTwo =>
      'Profitez d\'une liberté totale dans la gestion de vos finances, avec des frais réduits sur les transactions internationales.';

  @override
  String get next => 'Suivant';

  @override
  String get start => 'Commencer';

  @override
  String get login => 'SE CONNECTER';

  @override
  String get register => 'S\'INSCRIRE';

  @override
  String get or => 'OU';

  @override
  String get continueWithGoogle => 'CONTINUER AVEC GOOGLE';

  @override
  String get french => 'Français';

  @override
  String get loginTitle => 'Se connecter';

  @override
  String get email => 'Email';

  @override
  String get password => 'Mot de passe';

  @override
  String get loginButton => 'Connexion';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get orLoginWith => 'OU CONNECTEZ-VOUS AVEC';

  @override
  String get emailMode => 'E-MAIL';

  @override
  String get phoneMode => 'NUMÉRO DE TÉLÉPHONE';

  @override
  String get google => 'GOOGLE';

  @override
  String get forgotPasswordTitle => 'Mot de passe oublié';

  @override
  String get useEmail => 'UTILISER EMAIL';

  @override
  String get usePhoneNumber => 'UTILISER LE NUMÉRO DE TÉLÉPHONE';

  @override
  String get confirmOtpTitle => 'Confirmer votre numéro';

  @override
  String get confirmOtpDescription =>
      'Nous avons envoyé un code par SMS. Saisissez-le pour continuer.';

  @override
  String get confirm => 'Confirmer';

  @override
  String get resendCode => 'RENVOYER LE CODE';

  @override
  String get resetPasswordTitle => 'Réinitialiser votre mot de passe';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get phoneTitle => 'Téléphone';

  @override
  String get country => 'Pays';

  @override
  String get phoneNumber => 'Numéro';

  @override
  String get personalInfoTitle => 'Informations personnelles';

  @override
  String get lastName => 'Nom';

  @override
  String get firstName => 'Prénom';

  @override
  String get securityTitle => 'Sécurisez votre compte';

  @override
  String get addMoney => 'Ajouter';

  @override
  String get send => 'Envoyer';

  @override
  String get receive => 'Recevoir';

  @override
  String get exchange => 'Échanger';

  @override
  String get withdraw => 'Retirer';

  @override
  String get transactions => 'Transactions';

  @override
  String get viewAll => 'Voir tout';

  @override
  String get enterAmountToRecharge => 'Entrez le montant à recharger';

  @override
  String get currency => 'FCFA';

  @override
  String get availableBalance => 'Solde disponible';

  @override
  String userName(Object name) {
    return '$name';
  }

  @override
  String get chooseRechargeMethod => 'Choisissez la méthode de recharge';

  @override
  String get rechargeMethod => 'Méthode de recharge';

  @override
  String get selectRechargeMethod => 'Sélectionnez une méthode de recharge';

  @override
  String get fees => 'Frais';

  @override
  String get confirmYourNumber => 'Confirmez votre numéro';

  @override
  String get mobileMoney => 'Mobile Money';

  @override
  String get phoneNumberHint => '34567890';

  @override
  String get selectMobileMoneyType => 'Sélectionnez le type de Mobile Money';

  @override
  String willBeDebited(Object account, Object phone, Object total) {
    return 'Vous serez débité sur votre compte $account ($phone) de $total FCFA';
  }

  @override
  String get recharge => 'Recharger';

  @override
  String rechargeSummary(
    Object amount,
    Object currency,
    Object mobileMoney,
    Object phone,
  ) {
    return 'Recharge de $amount $currency via $mobileMoney ($phone)';
  }

  @override
  String get status => 'Statut';

  @override
  String get pending => 'En attente';

  @override
  String get sentBy => 'Envoyé par';

  @override
  String get sentVia => 'Envoyé via';

  @override
  String get amount => 'Montant';

  @override
  String get account => 'Compte';

  @override
  String get settings => 'Paramètres';

  @override
  String get personalInfo => 'Informations personnelles';

  @override
  String get security => 'Sécurité';

  @override
  String get changePassword => 'Modifier votre mot de passe';

  @override
  String get changePinCode => 'Changer votre code de sécurité';

  @override
  String get business => 'Business';

  @override
  String get merchantAccount => 'Compte Marchand';

  @override
  String get preferences => 'Préférences';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get language => 'Langue';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get userNameFull => 'Nom complet';

  @override
  String get createPinCode => 'Créez votre code PIN';

  @override
  String get enterPinCode => 'Entrez votre code PIN';

  @override
  String get personalInformation => 'Informations personnelles';

  @override
  String get update => 'Mettre à jour';

  @override
  String get updatePasswordTitle => 'Modifier le mot de passe';

  @override
  String get currentPassword => 'Mot de passe actuel';

  @override
  String get newPassword => 'Nouveau mot de passe';

  @override
  String get sendMoney => 'Envoyer de l\'argent';

  @override
  String get whatAmount => 'Quel montant ?';

  @override
  String get toWho => 'À qui ?';

  @override
  String sendMoneyWarning(Object account, Object balance, Object currency) {
    return 'Votre envoi d\'argent sera débité depuis Cauris $account. Il vous restera $balance $currency';
  }

  @override
  String get newReceiver => 'Nouveau Bénéficiaire';

  @override
  String get accountNumber => 'Numéro de compte';

  @override
  String get chooseReceiver => 'Choisissez un bénéficiaire';

  @override
  String get searchReceiver => 'Rechercher un destinataire';

  @override
  String get addNewReceiver => 'Ajouter un nouveau destinataire';

  @override
  String get savedReceivers => 'Destinataires enregistrés';

  @override
  String get verificationSuccessTitle => 'Vérification réussie';

  @override
  String get verificationSuccessMessage =>
      'Votre transfert d\'argent a été effectué avec succès.';

  @override
  String get continueButton => 'Continuer';

  @override
  String get pay => 'Payer';

  @override
  String get fingerPrint => 'Empreinte digitale';

  @override
  String get enable => 'Activé';

  @override
  String get disable => 'Désactivé';

  @override
  String get english => 'Anglais';

  @override
  String get not_informed => 'Non renseigné';

  @override
  String get add => 'Ajouter';

  @override
  String get enter_your_email => 'Entrez votre email';

  @override
  String get email_verification => 'Vérification d\'adresse email';

  @override
  String get email_verification_code_sent =>
      'Un code de vérification a été envoyé à votre adresse email.';

  @override
  String get resend_code => 'Renvoyer le code';

  @override
  String get enter_code => 'Entrez le code';

  @override
  String get enter_valid_email => 'Entrez une adresse email valide';

  @override
  String get required_code_pin =>
      'Pour sécuriser votre compte, définissez un code PIN. Sinon, certaines actions seront bloquées.';

  @override
  String get request => 'Demander';

  @override
  String get withdrawal => 'Retrait';

  @override
  String get transaction_error => 'Erreur lors du chargement des transactions.';

  @override
  String notification_body(Object amount, Object sender) {
    return 'Vous avez reçu un virement de $amount de $sender.';
  }

  @override
  String get notification_title => 'Virement reçu';

  @override
  String get insuficient_amount => 'Montant insuffisant.';

  @override
  String get common_error =>
      '\"Il semble que votre connexion Internet soit instable. Veuillez vérifier votre connexion et réessayer\",';

  @override
  String get retry => 'Réessayer';

  @override
  String get add_beneficiary => 'Ajouter un bénéficiaire';

  @override
  String get add_beneficiary_text =>
      'Ajoutez un bénéficiaire en utilisant le bouton ci-dessous.';

  @override
  String get verification => 'Vérification';

  @override
  String get confirm_beneficiary => 'Confirmer le bénéficiaire';

  @override
  String get confirm_beneficiary_text =>
      'Veuillez confirmer les informations du bénéficiaire avant de continuer';

  @override
  String get not_correct => 'Non, ce n\'est pas correct.';

  @override
  String get correct_information => 'Oui, c\'est correct.';

  @override
  String get confirm_beneficiary_title => 'Vérification';

  @override
  String get completed_name => 'Nom complet';

  @override
  String get phone_number => 'Numéro de téléphone';

  @override
  String get confirm_transfer => 'Confirmer le transfert';

  @override
  String get sender => 'Expéditeur';

  @override
  String get account_number => 'Numéro de compte';

  @override
  String get amount_to_be_withdrawn => 'Montant à retirer';

  @override
  String get transfer_fees => 'Frais de transfert';

  @override
  String get transfer_amount => 'Montant du transfert';

  @override
  String get recipient => 'Destinataire';

  @override
  String get firstname => 'Prénom';

  @override
  String get lastname => 'Nom';

  @override
  String get amount_to_be_received => 'Montant à recevoir';

  @override
  String get which_amount => 'Pour quel montant ?';

  @override
  String qr_code_user_text(Object name) {
    return 'Ce QR Code appartient à $name.';
  }

  @override
  String get qr_code_message =>
      'Présentez le QR Code ci-dessous à un utilisateur Cauris Pay pour recevoir le montant indiqué.';

  @override
  String get qr_code_title => 'QR Code';

  @override
  String get finish => 'Terminer';

  @override
  String get confirm_withdrawal => 'Confirmer le retrait';

  @override
  String get withdrawal_fees => 'Frais de retrait';

  @override
  String get withdrawal_amount => 'Montant du retrait';

  @override
  String get netWork => 'Réseau';

  @override
  String get validate => 'Valider';

  @override
  String get cancel => 'Annuler';

  @override
  String get amount_request => 'Montant demandé';

  @override
  String amount_request_text(Object amount, Object currency, Object name) {
    return '$name vous demande une somme de $amount $currency.';
  }

  @override
  String get deposit => 'Depot';

  @override
  String get transfer => 'Transfert';

  @override
  String get failed => 'Echec';

  @override
  String get download => 'Télecharger';

  @override
  String notif_received(Object amount, Object currency, Object name) {
    return 'Reçu $amount $currency de $name';
  }

  @override
  String notif_sent(Object amount, Object currency, Object name) {
    return 'Envoyé $amount $currency à $name';
  }

  @override
  String notif_deposit(Object amount, Object currency, Object name) {
    return 'Dépôt de $amount $currency via $name';
  }

  @override
  String notif_withdrawal(Object amount, Object currency, Object name) {
    return 'Retrait de $amount $currency vers $name';
  }

  @override
  String get loading => 'Chargement ....';

  @override
  String get termsTextStart =>
      'En utilisant cette application, vous acceptez nos ';

  @override
  String get termsOfUse => 'Conditions d\'utilisation';

  @override
  String get and => ' et notre ';

  @override
  String get privacyPolicyText => 'Politique de confidentialité';

  @override
  String get loginWithPhone => 'Connectez-vous avec votre numéro de téléphone.';

  @override
  String get loginWithEmail => 'Connectez-vous avec votre adresse email.';

  @override
  String get forgotPasswordPhoneDescription =>
      'Entrez votre numéro de téléphone pour recevoir un code de vérification.';

  @override
  String get forgotPasswordEmailDescription =>
      'Entrez votre adresse email pour recevoir un code de vérification.';

  @override
  String get confirmEmailTitle => 'Confirmez votre email';

  @override
  String get codeNotReceived => 'Code non reçu ? ';

  @override
  String get resend => 'Renvoyer';

  @override
  String get resendIn => 'Renvoyer le code dans ';

  @override
  String get resetPasswordDescription =>
      'Choisissez un nouveau mot de passe sécurisé pour votre compte.';

  @override
  String get passwordMismatch => 'Les mots de passe ne correspondent pas';

  @override
  String get passwordMatch => 'Les mots de passe correspondent';

  @override
  String get phoneDescription =>
      'Entrez votre numéro de téléphone pour créer votre compte.';

  @override
  String get personalInfoDescription => 'Vos informations personnelles.';

  @override
  String get securityDescription =>
      'Créez un mot de passe sécurisé pour protéger votre compte.';

  @override
  String get pinDescription =>
      'Sécurisez votre compte avec un code à 6 chiffres.';

  @override
  String get confirmPin => 'Ressaisissez votre code pour confirmer';

  @override
  String get pinUsageHint => 'Vous devrez le saisir à chaque transaction';

  @override
  String get pinMismatch => 'Les codes PIN ne correspondent pas';

  @override
  String helloUser(Object name) {
    return 'Bonjour, $name 👋';
  }

  @override
  String get pinIncorrect => 'Code PIN incorrect. Veuillez réessayer.';

  @override
  String get forgotPin => 'Code PIN oublié ?';

  @override
  String get forgotPinTitle => 'Code PIN oublié ?';

  @override
  String get forgotPinDescription =>
      'Entrez votre numéro de téléphone pour recevoir un code de vérification et réinitialiser votre PIN.';

  @override
  String get rememberPin => 'Je me souviens de mon code PIN';

  @override
  String get loginHere => 'Connexion';

  @override
  String get newPinTitle => 'Nouveau code PIN';

  @override
  String get confirmPinTitle => 'Confirmer le code PIN';

  @override
  String get newPinDescription => 'Choisissez un nouveau code à 6 chiffres';

  @override
  String get confirmPinDescription =>
      'Ressaisissez votre nouveau code pour confirmer';

  @override
  String get create => 'Créer';

  @override
  String get fingerprintDescription =>
      'Activez ou désactivez l\'authentification par empreinte digitale.';

  @override
  String get chooseLanguageDescription =>
      'Choisissez la langue de l\'application.';

  @override
  String get addEmailDescription =>
      'Ajoutez une adresse email à votre compte pour plus de sécurité.';

  @override
  String get validEmail => 'Adresse email valide';

  @override
  String get resendCodeIn => 'Renvoyer le code dans';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationsSubtitle => 'Vos dernières activités';

  @override
  String get noNotifications => 'Aucune notification';

  @override
  String get notificationsEmptyDescription => 'Vos activités apparaîtront ici';

  @override
  String get hello => 'Bonjour 👋';

  @override
  String get simpleSend => 'Envoi Simple';

  @override
  String get withdrawTo => 'Retrait vers';

  @override
  String get history => 'Historique';

  @override
  String get merchant => 'Marchand';

  @override
  String get availableBalanceLabel => 'Solde disponible';

  @override
  String get receiveQrTitle => 'Recevoir de l\'argent via QR Code';

  @override
  String get qrSimple => 'QR Simple';

  @override
  String get qrSimpleDesc => 'L\'expéditeur saisit le montant';

  @override
  String get qrWithAmount => 'QR + Montant';

  @override
  String get qrWithAmountDesc => 'Montant prédéfini à scanner';

  @override
  String get sendQrTitle => 'Envoyer de l\'argent en scannant un QR Code';

  @override
  String get scanQrSimple => 'QR Simple';

  @override
  String get scanQrSimpleDesc => 'Scannez le QR de votre contact';

  @override
  String get scanQrWithAmount => 'QR avec Montant';

  @override
  String get scanQrWithAmountDesc => 'Montant inclus dans le QR';

  @override
  String get comingSoonTitle => 'Espace Marchand';

  @override
  String get comingSoonDescription =>
      'Nous vous préparons quelque chose de puissant. Cette fonctionnalité sera bientôt disponible.';

  @override
  String get comingSoonPayments => 'Paiements';

  @override
  String get comingSoonStats => 'Statistiques';

  @override
  String get comingSoonQr => 'QR Marchand';

  @override
  String get understood => 'Compris';

  @override
  String get appTagline => 'VOTRE PORTEFEUILLE NUMÉRIQUE';

  @override
  String versionLabel(Object version) {
    return 'Version $version';
  }

  @override
  String get errorConnectionTitle => 'Erreur de connexion';

  @override
  String get errorGenericTitle => 'Oups !';

  @override
  String get errorConnectionMessage =>
      'Veuillez vérifier votre connexion internet et réessayer.';

  @override
  String get errorGenericMessage =>
      'Il semble y avoir un petit problème. Veuillez réessayer dans un instant.';

  @override
  String get updateRequiredTitle => 'Mise à jour\nRequise';

  @override
  String get newVersionAvailableTitle => 'Nouvelle version\nDisponible';

  @override
  String get updateRequiredDescription =>
      'Cette mise à jour est nécessaire\npour continuer à utiliser Caurispay.';

  @override
  String get updateAvailableDescription =>
      'Mettez à jour Caurispay pour\nprofiter des dernières\naméliorations et corrections.';

  @override
  String get currentVersion => 'Actuelle';

  @override
  String get newVersion => 'Nouvelle';

  @override
  String get ignoreForNow => 'Ignorer pour l\'instant';

  @override
  String get connectionErrorTitle => 'Problème de connexion';

  @override
  String get connectionErrorDescription =>
      'Nous n\'avons pas pu établir de connexion. Veuillez vérifier votre connexion internet.\nAppuyez sur le bouton ci-dessous pour réessayer.';

  @override
  String get mobileRechargeTitle => 'Recharge Mobile Money';

  @override
  String amountLabel(Object amount) {
    return 'Montant : $amount';
  }

  @override
  String get operator => 'Opérateur';

  @override
  String get phoneExample => 'Ex: 77 123 45 67';

  @override
  String phoneLengthIndicator(Object current, Object max) {
    return '$current / $max chiffres';
  }

  @override
  String get mobileRecharge => 'Recharge Mobile';

  @override
  String get netAmount => 'Net';

  @override
  String get confirmRecharge => 'Confirmer la recharge';

  @override
  String get securePayment => 'Paiement sécurisé';

  @override
  String get chooseCountry => 'Choisir un pays';

  @override
  String get search => 'Rechercher...';

  @override
  String get updatePasswordSubtitle =>
      'Entrez votre mot de passe actuel puis choisissez-en un nouveau.';

  @override
  String get enterWithdrawalAmount =>
      'Entrez le montant à retirer de votre portefeuille';

  @override
  String get digits => 'chiffres';

  @override
  String get withdrawal_confirmation => 'Confirmation de retrait';

  @override
  String get net => 'Net';

  @override
  String get secure_payment => 'Paiement sécurisé';

  @override
  String get confirm_identity_withdrawal =>
      'Confirmez votre identité pour valider le retrait';

  @override
  String get invalid_pin_code => 'Code PIN incorrect. Veuillez réessayer.';

  @override
  String get forgot_pin_code => 'Code PIN oublié ?';

  @override
  String get balance => 'Solde';

  @override
  String get enter_receiver_phone =>
      'Entrez le numéro de téléphone de la personne à qui vous souhaitez envoyer de l\'argent';

  @override
  String get confirm_identity_transaction =>
      'Confirmez votre identité pour valider la transaction';

  @override
  String get invalid_pin => 'Code PIN incorrect. Veuillez réessayer.';

  @override
  String get forgot_pin => 'Code PIN oublié ?';

  @override
  String get my_qr_code => 'Mon QR Code';

  @override
  String get secured_by => 'Sécurisé par';

  @override
  String get qr_code_description =>
      'Partagez ce QR code avec la personne qui souhaite vous envoyer de l\'argent. Elle pourra le scanner pour initier le paiement rapidement et en toute sécurité.';

  @override
  String get enter_requested_amount => 'Entrez le montant à demander';

  @override
  String get payment_request => 'Demande de paiement';

  @override
  String scan_to_send(Object amount, Object currency) {
    return 'Scannez pour envoyer $amount $currency';
  }

  @override
  String get camera_permission_denied => 'Accès à la caméra refusé';

  @override
  String get wrong_qr_code => 'Mauvais QR code';

  @override
  String get qr_code_with_amount_error =>
      'Ce QR code contient un montant. Pour l\'utiliser, retournez à l\'écran d\'envoi et choisissez \"QR avec Montant\".';

  @override
  String get got_it => 'Compris';

  @override
  String get scan_qr_simple_message =>
      'Scannez le QR code du destinataire pour envoyer de l\'argent rapidement et en toute sécurité.';

  @override
  String get qr_scan_instruction =>
      'Scannez le QR code Simple du destinataire pour envoyer de l\'argent rapidement et en toute sécurité.';

  @override
  String get qr_scan_simple_warning =>
      'Scannez le QR code simple de l\'utilisateur ; vous serez invité à saisir le montant plus tard.';

  @override
  String get wrong_qr_code_description =>
      'Ce QR code contient un montant. Utilisez l\'écran approprié pour ce type de paiement.';

  @override
  String get qr_scan_aim => 'Pointez vers le QR CODE SIMPLE';

  @override
  String get qr_recipient_identified => 'Destinataire identifié via QR code';

  @override
  String get recipient_label => 'Destinataire';

  @override
  String get amount_label => 'Montant';

  @override
  String get verified => 'Vérifié';

  @override
  String get qr_without_amount_error =>
      'Veuillez scanner un QR code contenant un montant généré par le destinataire.';

  @override
  String get qr_invalid_title => 'QR code incompatible';

  @override
  String get qr_requires_amount_message =>
      'Pour continuer, scannez un QR code avec un montant fourni par le destinataire.';

  @override
  String get confirm_payment => 'Confirmer le paiement';

  @override
  String get wrong_qr_description_amount =>
      'Ce QR code ne contient pas de montant. Pour l\'utiliser, retournez à l\'écran d\'envoi et choisissez \'Contact QR\'.';

  @override
  String get qr_with_amount_description =>
      'Veuillez scanner un QR code avec un montant de votre destinataire';

  @override
  String get success_operation => 'Votre opération a été effectuée avec succès';

  @override
  String get no_transactions => 'Aucune transaction';

  @override
  String get no_transactions_desc => 'Vos opérations apparaîtront ici';

  @override
  String get wrong_qr_type_title => 'Mauvais QR code';

  @override
  String get wrong_qr_type_desc =>
      'Ce QR code ne contient pas de montant. Retournez à l\'écran d\'envoi et choisissez \'Contact QR\'.';

  @override
  String get tx_deposit => 'Dépôt';

  @override
  String get tx_received => 'Reçu';

  @override
  String get tx_withdrawal => 'Retrait';

  @override
  String get tx_sent => 'Envoyé';

  @override
  String get transaction_detail => 'Détail de la transaction';

  @override
  String get tx_detail_info => 'Informations';

  @override
  String get tx_detail_name => 'Nom';

  @override
  String get tx_detail_date => 'Date';

  @override
  String get tx_detail_type => 'Type';

  @override
  String get tx_detail_status => 'Statut';

  @override
  String get tx_detail_reference => 'Référence';

  @override
  String get tx_no_reference => 'Aucune référence';

  @override
  String get tx_success => 'Succès';

  @override
  String get tx_failed => 'Échec';

  @override
  String get copy => 'Copier';

  @override
  String get copied => 'Copié';

  @override
  String get qr_download_success => 'QR code enregistré dans votre galerie';

  @override
  String get qr_download_error => 'Échec du téléchargement, veuillez réessayer';

  @override
  String get downloading => 'Téléchargement...';

  @override
  String get support => 'Support';

  @override
  String get support_hero_title => 'Nous sommes là pour vous aider';

  @override
  String get support_hero_desc =>
      'Notre équipe répond à toutes vos questions sur CaurisPay.';

  @override
  String get support_contact_label => 'Nous contacter';

  @override
  String get support_phone_label => 'Téléphone';

  @override
  String get support_email_label => 'Email';

  @override
  String get support_address_label => 'Adresse';

  @override
  String get support_headquarters => 'Siège social';

  @override
  String get support_region => 'Afrique de l\'Ouest';

  @override
  String get support_website_btn => 'Contacter via notre site web';

  @override
  String get back_to_home => 'Retour à l\'accueil';

  @override
  String get qrCodeSectionTitle => 'QR code';

  @override
  String get qrFreeAmountTitle => 'Recevoir un montant libre';

  @override
  String get qrFreeAmountDesc => 'L\'expéditeur saisit le montant';

  @override
  String get qrFixedAmountTitle => 'Recevoir un montant fixe';

  @override
  String get qrFixedAmountDesc => 'Le montant est déjà défini';

  @override
  String get scanToPayTitle => 'Scanner';

  @override
  String get scanToPayDesc => 'Scannez le code du destinataire';

  @override
  String paymentRequestBannerTitle(String name, String amount) {
    return '$name vous demande $amount';
  }

  @override
  String paymentRequestBannerSubtitle(String time) {
    return 'Expire dans $time';
  }

  @override
  String paymentRequestBannerSubtitleWithOthers(String time, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count autres',
      one: '1 autre',
    );
    return 'Expire dans $time · $_temp0';
  }

  @override
  String paymentRequestBannerRequesterLine(String name) {
    return '$name vous demande';
  }

  @override
  String get expiresInLabel => 'Expire dans';

  @override
  String viewOthersRequests(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Voir les $count autres demandes',
      one: 'Voir 1 autre demande',
    );
    return '$_temp0';
  }

  @override
  String get reject => 'Refuser';

  @override
  String get paymentRequestsInboxTitle => 'Demandes de paiement';

  @override
  String get emptyPaymentRequestsTitle => 'Aucune demande en attente';

  @override
  String get emptyPaymentRequestsBody =>
      'Les demandes de paiement que vous recevez apparaîtront ici.';

  @override
  String get rejectConfirmTitle => 'Refuser cette demande ?';

  @override
  String rejectConfirmBody(String name) {
    return '$name ne recevra pas de paiement de votre part.';
  }

  @override
  String get confirmPaymentButton => 'Confirmer le paiement';

  @override
  String get paymentRequestScreenTitle => 'Demande de paiement';

  @override
  String paymentRequestScreenRequesterLine(String name) {
    return '$name vous demande';
  }

  @override
  String get paymentRequestExpiredSnack =>
      'Cette demande de paiement a expiré.';

  @override
  String get wrongPinError => 'Code PIN incorrect.';

  @override
  String get genericError => 'Une erreur est survenue. Réessayez.';

  @override
  String get close => 'Fermer';

  @override
  String get securedByPinLabel => 'Paiement sécurisé par code PIN';

  @override
  String get requestsFromLabel => 'vous demande';

  @override
  String get referenceLabel => 'Référence';

  @override
  String get expiresInFullLabel => 'Cette demande expire dans';

  @override
  String get rejectRequestButton => 'Refuser la demande';

  @override
  String expiresInLabelInline(String time) {
    return 'Expire dans $time';
  }

  @override
  String get noFeesApplied => 'Aucuns frais appliqués';

  @override
  String get irreversible_operation_warning =>
      'Cette opération est irréversible une fois confirmée.';

  @override
  String get reference => 'Référence';

  @override
  String get auto_redirect_home => 'Retour automatique à l\'accueil';

  @override
  String get cannot_add_self_beneficiary =>
      'C\'est votre propre numéro. Vous ne pouvez pas vous ajouter comme bénéficiaire.';

  @override
  String get use_withdrawal_instead => 'Utilisez plutôt un retrait.';

  @override
  String get add_this_contact => 'Ajouter ce contact';

  @override
  String get quickPayment => 'Paiement rapide';

  @override
  String get qr_scan_unified_description =>
      'Scannez le QR code d\'un bénéficiaire pour lui envoyer de l\'argent.';

  @override
  String get qr_scan_align_hint => 'Alignez le code dans le cadre';

  @override
  String get qr_scan_security_hint =>
      'Vérifiez toujours l\'identité du destinataire avant de confirmer votre envoi.';

  @override
  String get unrecognized_qr_title => 'Code non reconnu';

  @override
  String get unrecognized_qr_description =>
      'Ce code ne correspond à aucun format CaurisPay valide. Assurez-vous qu\'il provient bien de l\'application.';

  @override
  String get choose_from_gallery => 'Choisir depuis la galerie';

  @override
  String get request_expired_title => 'Demande expirée';

  @override
  String get request_expired_message =>
      'Le délai pour confirmer cette demande est dépassé.';

  @override
  String get ok => 'OK';

  @override
  String get delete_account => 'Supprimer le compte';

  @override
  String get delete_account_confirm_title => 'Supprimer votre compte ?';

  @override
  String get delete_account_confirm_message =>
      'Votre compte sera définitivement supprimé dans 14 jours. Toutes vos données et votre historique de transactions seront effacés et ne pourront pas être récupérés. Vous pouvez annuler dans les 14 jours.';

  @override
  String get delete_account_confirm_button => 'Oui, supprimer mon compte';

  @override
  String deletion_pending_banner(String date) {
    return 'Votre compte sera supprimé le $date.';
  }

  @override
  String get cancel_deletion => 'Annuler la suppression';

  @override
  String get cancel_deletion_confirm_title =>
      'Annuler la suppression du compte ?';

  @override
  String get cancel_deletion_confirm_message =>
      'Votre compte restera actif et la demande de suppression sera annulée.';

  @override
  String get cancel_deletion_confirm_button => 'Oui, conserver mon compte';

  @override
  String get deletion_request_success =>
      'Votre demande de suppression a été soumise. Vous avez 14 jours pour l\'annuler.';

  @override
  String get deletion_cancel_success =>
      'La suppression de votre compte a été annulée.';
}
