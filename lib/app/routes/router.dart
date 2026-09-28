import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/features/account/views/account_view.dart';
import 'package:corrispay/features/account/views/add_email_view.dart';
import 'package:corrispay/features/account/views/confirm_verification_email_reset_password_view.dart';
import 'package:corrispay/features/account/views/create_required_code_pin_view.dart';
import 'package:corrispay/features/account/views/set_passcode_view.dart';
import 'package:corrispay/features/account/views/support_contact_view.dart';
import 'package:corrispay/features/account/views/user_info_view.dart';
import 'package:corrispay/features/account/views/forgot_password_view.dart';
import 'package:corrispay/features/account/views/verify_email_view.dart';
import 'package:corrispay/features/auth/dto/register.dto.dart';
import 'package:corrispay/features/auth/views/confirm_reset_pin_otp_view.dart';
import 'package:corrispay/features/auth/views/forgot_pincode_view.dart';
import 'package:corrispay/features/auth/views/reset_code_pin_view.dart';
import 'package:corrispay/features/intern-transactions/views/qr_scan_view.dart';
import 'package:corrispay/features/merchant/views/intern_transfer_view.dart';
import 'package:corrispay/features/merchant/views/merchant-registration.view.dart';
import 'package:corrispay/features/mobiles-transactions/views/add_money_to_wallet_view.dart';
import 'package:corrispay/features/mobiles-transactions/responses/mobile_deposit_data.dart';
import 'package:corrispay/features/mobiles-transactions/responses/mobile_recharge_preview_data.dart';
import 'package:corrispay/features/mobiles-transactions/responses/mobile_withdrawal_preview_data.dart';
import 'package:corrispay/features/mobiles-transactions/views/confirm_recharge_mobile_view.dart';
import 'package:corrispay/features/mobiles-transactions/views/withdrawal_summary_view.dart';
import 'package:corrispay/features/transactions/models/transaction.dart';
import 'package:corrispay/features/mobiles-transactions/views/mobile_recharge_view.dart';
import 'package:corrispay/features/notifications/views/notifications_view.dart';
import 'package:corrispay/features/mobiles-transactions/views/pending_recharge_view.dart';
import 'package:corrispay/features/bases/views/error_connexion_view.dart';
import 'package:corrispay/features/bases/views/force_update_view.dart';
import 'package:corrispay/features/bases/views/main_view.dart';
import 'package:corrispay/features/bases/views/splash_screen.dart';
import 'package:corrispay/features/onboarding/onboarding_one_view.dart';
import 'package:corrispay/features/transactions/models/country_operator_model.dart';
import 'package:corrispay/features/transactions/models/intern_transaction.dart';
import 'package:corrispay/features/intern-transactions/views/add_beneficiary_with_qrcode_view.dart';
import 'package:corrispay/features/intern-transactions/views/add_send_money_amount_view.dart';
import 'package:corrispay/features/beneficiary/views/add_new_receiver_view.dart';
import 'package:corrispay/features/intern-transactions/views/confirm_send_money_view.dart';
import 'package:corrispay/features/mobiles-transactions/views/confirm_withdrawal_view.dart';
import 'package:corrispay/features/intern-transactions/views/enter_code_view.dart';
import 'package:corrispay/features/intern-transactions/views/enter_request_amount_view.dart';
import 'package:corrispay/features/mobiles-transactions/views/enter_withdrawal_amount_view.dart';
import 'package:corrispay/features/mobiles-transactions/views/enter_withdrawal_code_view.dart';
import 'package:corrispay/features/mobiles-transactions/views/enter_withdrawal_phone_number.dart';
import 'package:corrispay/features/auth/views/login_with_pin_code_view.dart';
import 'package:corrispay/features/intern-transactions/views/qr_code_view.dart';
import 'package:corrispay/features/intern-transactions/views/receive_payment_view.dart';
import 'package:corrispay/features/beneficiary/views/receiver_choice_view.dart';
import 'package:corrispay/features/intern-transactions/views/send_money_with_qr_code.dart';
import 'package:corrispay/features/transactions/views/transactions_view.dart';
import 'package:corrispay/features/intern-transactions/views/verification_code_completed_view.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../features/bases/models/dashboard_data.dart';
import '../../features/beneficiary/models/beneficiary.model.dart';
import '../../features/intern-transactions/views/send-money-after-scan-view.dart';
import '../../features/account/views/update_password_view.dart';
import '../../features/auth/views/auth_view.dart';
import '../../features/auth/views/confirm_otp_password_view.dart';
import '../../features/auth/views/confirm_otp_view.dart';
import '../../features/auth/views/create_code_pin_view.dart';
import '../../features/auth/views/login_view.dart';
import '../../features/auth/views/personal_info_view.dart';
import '../../features/auth/views/phone_view.dart';
import '../../features/auth/views/reset_password_view.dart';
import '../../features/auth/views/security_view.dart';
import '../../features/bases/models/app_info.dart';
import '../../features/requests/models/user-request.model.dart';
import '../../features/requests/views/confirm-request-view.dart';
import '../../features/transactions/views/transaction_detail_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;
    switch (routeSettings.name) {
      case RoutesNames.login:
        return _createSmoothPushRoute(LoginView());
      case RoutesNames.scanView:
        return _createSmoothPushRoute(QrScanScreen());
      case RoutesNames.onBoarding:
        return _createSmoothPushRoute(OnboardingOneView());
      case RoutesNames.phone:
        return _createSmoothPushRoute(PhoneView());
      case RoutesNames.info:
        return _createSmoothPushRoute(
          PersonalInfoView(registerDto: arguments as RegisterDto),
        );
      case RoutesNames.transactionDetailView:
        return _createSmoothPushRoute(
          TransactionDetailView(transaction: arguments as Transaction),
        );
      case RoutesNames.security:
        return _createSmoothPushRoute(
          SecurityView(registerDto: arguments as RegisterDto),
        );
      case RoutesNames.auth:
        return _createSmoothPushRoute(AuthView());
      case RoutesNames.otp:
        return _createSmoothPushRoute(
          ConfirmOtpView(registerDto: arguments as RegisterDto),
        );

      case RoutesNames.forgotPincode:
        return _createSmoothPushRoute(
          ForgotPincodeView(canLogin: arguments as bool?),
        );
      case RoutesNames.confirmResetPinCode:
        return _createSmoothPushRoute(
          ConfirmResetPinOtpView(phoneNumber: arguments as String),
        );
      case RoutesNames.resetPincode:
        return _createSmoothPushRoute(
          ResetCodePinView(data: arguments as (String, String)),
        );
      case RoutesNames.main:
        return _createSmoothPushRoute(
          MainView(data: arguments == null ? null : arguments as DashboardData),
        );
      case RoutesNames.receiverChoice:
        return _createSmoothPushRoute(
          ReceiverChoiceView(selectedReceiver: arguments as Beneficiary?),
        );
      case RoutesNames.addAmount:
        return _createSmoothPushRoute(
          AddSendMoneyAmountView(balance: arguments as double),
        );
      case RoutesNames.contactSupportView:
        return _createSmoothPushRoute(SupportContactView());
      case RoutesNames.addNewReceiver:
        return _createSmoothPushRoute(AddNewReceiverView());
      case RoutesNames.addMoneyToWallet:
        return _createSmoothPushRoute(
          AddMoneyToWalletView(balance: arguments as double),
        );

      case RoutesNames.notificationsView:
        return _createSmoothPushRoute(NotificationsView());
      case RoutesNames.pendingRecharge:
        return _createSmoothPushRoute(
          PendingRechargeView(data: arguments as MobileDepositData),
        );
      case RoutesNames.enterPhoneNumberToRecharge:
        return _createSmoothPushRoute(
          EnterPhoneNumberToRechargeView(
            data: arguments as (double, List<CountryOperatorModel>),
          ),
        );
      case RoutesNames.account:
        return _createSmoothPushRoute(AccountView());
      case RoutesNames.enterCode:
        return _createSmoothPushRoute(
          EnterCodeView(transaction: arguments as InternTransaction),
        );
      case RoutesNames.verificationCodeCompleted:
        return _createSmoothPushRoute(
          VerificationCodeCompletedView(
            dashboardData: arguments as DashboardData,
          ),
        );

      case RoutesNames.sendMoneyAfterScan:
        return _createSmoothPushRoute(
          SendMoneyAfterScanView(beneficiary: arguments as Beneficiary),
        );
      case RoutesNames.setPasscode:
        return _createSmoothPushRoute(UpdateCodePinView());

      case RoutesNames.updatePassword:
        return _createSmoothPushRoute(UpdatePasswordView());
      case RoutesNames.forgotPassword:
        return _createSmoothPushRoute(ForgotPasswordView());
      case RoutesNames.resetPassword:
        return _createSmoothPushRoute(
          ResetPasswordView(data: arguments as (int, String)),
        );
      case RoutesNames.confirmOtpPassword:
        return _createSmoothPushRoute(
          ConfirmOtpPasswordView(data: arguments as (int, String)),
        );
      case RoutesNames.loginWithPinCode:
        return _createSmoothPushRoute(LoginWithPinCodeView());

      case RoutesNames.userAccountInfo:
        return _createSmoothPushRoute(UserInfoView());
      case RoutesNames.receivePayment:
        return _createSmoothPushRoute(
          ReceivePaymentView(amount: arguments as double),
        );
      case RoutesNames.enterWithdrawalAmount:
        return _createSmoothPushRoute(
          EnterWithdrawalAmountView(balance: arguments as double),
        );
      case RoutesNames.enterWithdrawalPhoneNumber:
        return _createSmoothPushRoute(
          EnterWithdrawalPhoneNumber(
            data: arguments as (double, List<CountryOperatorModel>),
          ),
        );
      case RoutesNames.confirmWithdrawal:
        return _createSmoothPushRoute(
          ConfirmWithdrawalView(
            transaction: arguments as MobileWithdrawalPreviewData,
          ),
        );
      case RoutesNames.enterWithdrawalCode:
        return _createSmoothPushRoute(
          EnterWithdrawalCodeView(
            transaction: arguments as MobileWithdrawalPreviewData,
          ),
        );
      case RoutesNames.confirmSendMoney:
        return _createSmoothPushRoute(
          ConfirmSendMoneyView(transaction: arguments as InternTransaction),
        );
      case RoutesNames.transactionView:
        return _createSmoothPushRoute(TransactionsView());
      case RoutesNames.createCodePin:
        return _createSmoothPushRoute(CreateCodePinView());
      /**
     *  case RoutesNames.paymentConfirmPinCodeView:
        return _createSmoothPushRoute(
        PaymentConfirmPinCodeView(
        request: arguments as PaymentRequestSummary,
        ),
        );
     */
      case RoutesNames.splash:
        return _createSmoothPushRoute(SplashScreen());

      case RoutesNames.internTransferView:
        return _createSmoothPushRoute(TransferView());
      case RoutesNames.merchantRegistration:
        return _createSmoothPushRoute(MerchantRegistrationView());
      case RoutesNames.enterRequestAmount:
        return _createSmoothPushRoute(EnterRequestAmountView());
      case RoutesNames.sendMoneyWithQrCode:
        return _createSmoothPushRoute(SendMoneyWithQrCode());
      case RoutesNames.addEmail:
        return _createSmoothPushRoute(AddEmailView());
      case RoutesNames.forceUpdateView:
        return _createSmoothPushRoute(
          ForceUpdateView(infos: arguments as (AppInfo, PackageInfo)),
        );
      case RoutesNames.errorConnexionView:
        return _createSmoothPushRoute(ErrorConnexionView());
      case RoutesNames.verifyEmail:
        return _createSmoothPushRoute(
          VerifyEmailView(email: arguments as String),
        );
      case RoutesNames.confirmRequestView:
        return _createSmoothPushRoute(
          ConfirmRequestView(request: arguments as UserRequest),
        );
      case RoutesNames.confirmResetPasswordVerificationEmail:
        return _createSmoothPushRoute(
          ConfirmVerificationEmailResetPasswordView(email: arguments as String),
        );
      case RoutesNames.confirmMobileMoneyView:
        return _createSmoothPushRoute(
          ConfirmRechargeMobileView(
            data: arguments as MobileRechargePreviewData,
          ),
        );
      case RoutesNames.createRequiredCodeView:
        return _createSmoothPushRoute(CreateRequiredCodePinView());
      case RoutesNames.addBeneficiaryWithQrcodeView:
        return _createSmoothPushRoute(AddBeneficiaryWithQrcodeView());
      case RoutesNames.qrCode:
        return _createSmoothPushRoute(QrCodeView());
      case RoutesNames.withdrawalSummaryView:
        return _createSmoothPushRoute(
          WithdrawalSummaryView(data: arguments as MobileWithdrawalPreviewData),
        );
      default:
        return MaterialPageRoute(builder: (context) => Container());
    }
  }

  static Route<dynamic> _createSmoothPushRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 280),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final enterSlide =
            Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(
              CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
            );

        final enterFade = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
          ),
        );

        final exitSlide =
            Tween(begin: Offset.zero, end: const Offset(-0.25, 0.0)).animate(
              CurvedAnimation(
                parent: secondaryAnimation,
                curve: Curves.fastOutSlowIn,
              ),
            );

        return SlideTransition(
          position: exitSlide,
          child: FadeTransition(
            opacity: enterFade,
            child: SlideTransition(position: enterSlide, child: child),
          ),
        );
      },
    );
  }
}
