import 'package:get/get.dart';
import 'package:qrpay/backend/services/api_endpoint.dart';
import 'package:qrpay/routes/routes.dart';
import 'package:qrpay/views/auth/kyc_from/wait_for_approval_screen.dart';
import 'package:qrpay/views/auth/login/otp_verification_screen.dart';
import 'package:qrpay/views/auth/registration/email_otp_screen.dart';
import 'package:qrpay/views/auth/registration/registration_screen.dart';
import 'package:qrpay/views/categories/add_money/add_money_preview_screen.dart';
import 'package:qrpay/views/categories/bill_pay/bill_pay_screen.dart';
import 'package:qrpay/views/categories/mobile_topup/mobile_topup_screen.dart';
import 'package:qrpay/views/categories/money_in/money_in_qr_code_screen.dart';
import 'package:qrpay/views/categories/money_in/qr_code_screen.dart';
import 'package:qrpay/views/categories/remittance/remitance_preview_screen.dart';
import 'package:qrpay/views/categories/send_money/send_money_preview_screen.dart';
import 'package:qrpay/views/categories/send_money/send_money_screen.dart';
import 'package:qrpay/views/categories/withdraw/withdraw_preview_screen.dart';
import 'package:qrpay/views/drawer/bill_payment_log_screen.dart';
import 'package:qrpay/views/drawer/change_password_screen.dart';
import 'package:qrpay/views/drawer/mobile_log_screen.dart';
import 'package:qrpay/views/drawer/receipients/my_recipients/my_recipient_screen.dart';
import 'package:qrpay/views/drawer/setting_screen.dart';
import 'package:qrpay/views/drawer/transaction_logs_screen.dart';
import 'package:qrpay/views/navbar/bottom_navbar_screen.dart';
import 'package:qrpay/views/navbar/dashboard_screen.dart';
import 'package:qrpay/views/navbar/notification_screen.dart';
import 'package:qrpay/views/onboard/onboard_screen.dart';
import 'package:qrpay/views/profile/2fa/enable_2fa_screen.dart';
import 'package:qrpay/views/profile/2fa/two_fa_otp_screen.dart';
import 'package:qrpay/views/profile/my_wallet_screen.dart';
import 'package:qrpay/views/profile/profile_screen.dart';
import 'package:qrpay/views/profile/update_kyc_screen.dart';
import 'package:qrpay/views/profile/update_profile_screen.dart';

import '../bindings/initial_binding.dart';
import '../bindings/splash_screen_binding.dart';
import '../language/english.dart';
import '../views/auth/kyc_from/kyc_from_screen.dart';
import '../views/auth/login/email_verification_screen.dart';
import '../views/auth/login/phone_verification_screen.dart';
import '../views/auth/login/reset_password_phone_screen.dart';
import '../views/auth/login/reset_password_screen.dart';
import '../views/auth/login/reset_phone_otp_screen.dart';
import '../views/auth/login/signin_screen.dart';
import '../views/auth/registration/sms_otp_screen.dart';
import '../views/categories/add_money/add_money_manual_payment_screen.dart';
import '../views/categories/add_money/add_money_screen.dart';
import '../views/categories/add_money/coingate_payment_screen.dart';
import '../views/categories/add_money/flutterwave_web_payment_screen.dart';
import '../views/categories/add_money/pagadito_web_payment_screen.dart';
import '../views/categories/add_money/paypal_web_payment_screen.dart';
import '../views/categories/add_money/paystack_money_payment_screen.dart';
import '../views/categories/add_money/perfect_money_payment_screen.dart';
import '../views/categories/add_money/razor_pay_web_screen.dart';
import '../views/categories/add_money/ssl_web_payment_screen.dart';
import '../views/categories/add_money/stripe_web_payment_screen.dart';
import '../views/categories/add_money/tatum/tatum_payment_screen.dart';
import '../views/categories/bill_pay/billpay_preview_screen.dart';
import '../views/categories/exchange_money/exchange_money_preview_screen.dart';
import '../views/categories/exchange_money/exchange_money_screen.dart';
import '../views/categories/mobile_topup/mobile_preview_screen.dart';
import '../views/categories/money_in/money_in_preview_screen.dart';
import '../views/categories/money_in/money_in_screen.dart';
import '../views/categories/payments_screen/payment_log/payment_log_screen.dart';
import '../views/categories/payments_screen/payments_edit/payments_edit_screen.dart';
import '../views/categories/payments_screen/payments_screen.dart';
import '../views/categories/received_money/money_received_screen.dart';
import '../views/categories/remittance/add_recipient_screen.dart';
import '../views/categories/remittance/edit_recipient_screen.dart';
import '../views/categories/remittance/remitance_screen.dart';
import '../views/categories/remittance/sender/add_my_sender_recipient_screen.dart';
import '../views/categories/remittance/sender/edit_my_sender_recipient_screen.dart';
import '../views/categories/request_money/request_money_log.dart';
import '../views/categories/request_money/request_money_preview_screen.dart';
import '../views/categories/request_money/request_money_qr_code_screen.dart';
import '../views/categories/request_money/request_money_screen.dart';
import '../views/categories/send_money/send_money_qr_code.dart';
import '../views/categories/withdraw/withdraw_flutterwave_screen.dart';
import '../views/categories/withdraw/withdraw_manual_payment_screen.dart';
import '../views/categories/withdraw/withdraw_screen.dart';
import '../views/drawer/giftcard_log_screen.dart';
import '../views/drawer/receipients/my_sender/my_sender_recipient_screen.dart';
import '../views/drawer/web_view.dart';
import '../views/navbar/wallets_screen.dart';
import '../views/splash_screen/splash_screen.dart';

class RoutePageList {
  static var list = [
    //!auth
    GetPage(
      name: Routes.splashScreen,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.onboardScreen,
      page: () => OnboardScreen(),
    ),

    GetPage(
      name: Routes.signInScreen,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: Routes.resetOtpScreen,
      page: () => ResetOtpScreen(),
    ),
    GetPage(
      name: Routes.resetPasswordScreen,
      page: () => ResetPasswordScreen(),
    ),
    GetPage(
      name: Routes.registrationScreen,
      page: () => RegistrationScreen(),
    ),
    GetPage(
      name: Routes.emailOtpScreen,
      page: () => EmailOtpScreen(),
    ),

    // GetPage(
    //   name: Routes.facelockConfirmScreen,
    //   page: () => FaceLockConfirmScreen(),
    // ),
    // GetPage(
    //   name: Routes.facelockCaptureScreen,
    //   page: () => FaceLockCaptureScreen(),
    // ),
    // GetPage(
    //   name: Routes.fingerprintScreen,
    //   page: () => FingerPrintScreen(),
    // ),
    GetPage(
      name: Routes.kycFromScreen,
      page: () => KycFromScreen(),
    ),
    GetPage(
      name: Routes.waitForApprovalScreen,
      page: () => const WaitForApprovalScreen(),
    ),

    //!categories
    GetPage(
      name: Routes.bottomNavBarScreen,
      page: () => BottomNavBarScreen(),
      binding: InitialScreenBindings(),
    ),

    GetPage(
      name: Routes.dashboardScreen,
      page: () => const DashboardScreen(),
    ),
    GetPage(
      name: Routes.notificationScreen,
      page: () => NotificationScreen(),
    ),

    GetPage(
      name: Routes.qRCodeScreen,
      page: () => const QRCodeScreen(),
    ),
    GetPage(
      name: Routes.moneyInQRCodeScreen,
      page: () => const MoneyInQRCodeScreen(),
    ),
    GetPage(
      name: Routes.moneyTransferScreen,
      page: () => MoneyTransferScreen(),
    ),
    GetPage(
      name: Routes.sendMoneyPreviewScreen,
      page: () => SendMoneyPreviewScreen(),
    ),
    GetPage(
      name: Routes.moneyReceiveScreen,
      page: () => MoneyReceiveScreen(),
    ),
    GetPage(
      name: Routes.remittanceScreen,
      page: () => RemittanceScreen(),
    ),
    GetPage(
      name: Routes.remittancePreviewScreen,
      page: () => RemittancePreviewScreen(),
    ),
    GetPage(
      name: Routes.addRecipientScreen,
      page: () => AddRecipientScreen(),
    ),
    GetPage(
      name: Routes.editRecipientScreen,
      page: () => EditRecipientScreen(),
    ),

    GetPage(
      name: Routes.addMoneyScreen,
      page: () => DepositScreen(),
    ),
    GetPage(
      name: Routes.depositPreviewScreen,
      page: () => DepositPreviewScreen(),
    ),
    GetPage(
      name: Routes.withdrawScreen,
      page: () => WithdrawScreen(),
    ),
    GetPage(
      name: Routes.withdrawPreviewScreen,
      page: () => WithdrawPreviewScreen(),
    ),
    GetPage(
      name: Routes.mobileToUpScreen,
      page: () => MobileTopUpScreen(),
    ),
    GetPage(
      name: Routes.mobilePreviewScreen,
      page: () => const MobilePreviewScreen(),
    ),
    GetPage(
      name: Routes.billPayScreen,
      page: () => BillPayScreen(),
    ),
    GetPage(
      name: Routes.billPayPreviewScreen,
      page: () => const BillpayPreviewScreen(),
    ),

    GetPage(
      name: Routes.makePaymentPreviewScreen,
      page: () => SendMoneyPreviewScreen(),
    ),

    //!drawer screens
    GetPage(
      name: Routes.saveRecipientScreen,
      page: () => SaveRecipientScreen(),
    ),

    GetPage(
      name: Routes.transactionLogScreen,
      page: () => TransactionLogScreen(),
    ),
    GetPage(
        name: Routes.giftCardLogScreen, page: () => const GiftCardLogScreen()),
    GetPage(
      name: Routes.billPaymentLogScreen,
      page: () => BillPaymentLogScreen(),
    ),
    GetPage(
      name: Routes.mobileLogScreen,
      page: () => MobileLogScreen(),
    ),
    GetPage(
      name: Routes.settingScreen,
      page: () => SettingScreen(),
    ),
    GetPage(
      name: Routes.changePasswordScreen,
      page: () => ChangePasswordScreen(),
    ),

    //!profile screen
    GetPage(
      name: Routes.profileScreen,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: Routes.myWalletScreen,
      page: () => const MyWalletScreen(),
    ),
    GetPage(
      name: Routes.walletScreen,
      page: () => WalletsScreen(),
    ),
    GetPage(
      name: Routes.updateProfileScreen,
      page: () => UpdateProfileScreen(),
    ),
    GetPage(
      name: Routes.updateKycScreen,
      page: () => UpdateKycScreen(),
    ),
    GetPage(
      name: Routes.enable2FaScreen,
      page: () => Enable2FaScreen(),
    ),
    GetPage(
      name: Routes.otp2FaScreen,
      page: () => Otp2FaScreen(),
    ),
    GetPage(
      name: Routes.paypalWebPaymentScreen,
      page: () => PaypalWebPaymentScreen(),
    ),
    GetPage(
      name: Routes.flutterWaveWebPaymentScreen,
      page: () => FlutterWaveWebPaymentScreen(),
    ),

    GetPage(
      name: Routes.sendMoneyManualPaymentScreen,
      page: () => AddMoneyManualPaymentScreen(),
    ),
    GetPage(
      name: Routes.withdrawManualPaymentScreen,
      page: () => WithdrawManualPaymentScreen(),
    ),
    GetPage(
      name: Routes.withdrawFlutterwaveScreen,
      page: () => const WithdrawFlutterWaveScreen(),
    ),

    GetPage(
      name: Routes.emailVerificationScreen,
      page: () => EmailVerificationScreen(),
    ),

    GetPage(
      name: Routes.razorPayScreen,
      page: () => RazorPayWebPaymentScreen(),
    ),
    GetPage(
      name: Routes.paystackScreen,
      page: () => PaystackWebPaymentScreen(),
    ),

    GetPage(
      name: Routes.pagaditoWebPaymentScreen,
      page: () => PagaditoWebPaymentScreen(),
    ),

    GetPage(
      name: Routes.helpCenterScreen,
      page: () => WebScreen(
        title: Strings.helpCenter,
        url: "${ApiEndpoint.mainDomain}/contact",
      ),
    ),

    GetPage(
      name: Routes.privacyScreen,
      page: () => WebScreen(
        title: Strings.privacyPolicy,
        url: "${ApiEndpoint.mainDomain}/page/privacy-policy",
      ),
    ),
    GetPage(
      name: Routes.aboutUsScreen,
      page: () => WebScreen(
        title: Strings.aboutUs,
        url: "${ApiEndpoint.mainDomain}/about",
      ),
    ),
    GetPage(
      name: Routes.stripeWebPaymentScreen,
      page: () => StripeWebPaymentScreen(),
    ),
    GetPage(
      name: Routes.sslWebPaymentScreen,
      page: () => SslWebPaymentScreen(),
    ),
    GetPage(
      name: Routes.coinGatePaymentScreen,
      page: () => CoinGateWebPaymentScreen(),
    ),

    GetPage(
      name: Routes.paymentsScreen,
      page: () => const PaymentsScreen(),
    ),
    GetPage(
      name: Routes.paymentsEditScreen,
      page: () => const PaymentsEditScreen(),
    ),
    GetPage(
      name: Routes.paymentLogScreen,
      page: () => const PaymentLogScreen(),
    ),
    GetPage(
      name: Routes.requestMoneyScreen,
      page: () => RequestMoneyScreen(),
    ),
    GetPage(
      name: Routes.requestMoneyPreviewScreen,
      page: () => RequestMoneyPreviewScreen(),
    ),
    GetPage(
      name: Routes.requestMoneyQRCodeScreen,
      page: () => const RequestMoneyQRCodeScreen(),
    ),
    GetPage(
      name: Routes.requestMoneyLogScreen,
      page: () => RequestMoneyLogScreen(),
    ),
    GetPage(
      name: Routes.tatumPaymentScreen,
      page: () => TatumPaymentScreen(),
    ),

    GetPage(
      name: Routes.moneyInPreviewScreen,
      page: () => MoneyInPreviewScreen(),
    ),
    GetPage(
      name: Routes.moneyInScreen,
      page: () => MoneyInScreen(),
    ),

    // My Sender Recipient
    GetPage(
      name: Routes.mySenderRecipientScreen,
      page: () => MySenderRecipientScreen(),
    ),
    GetPage(
      name: Routes.editMySenderRecipientScreen,
      page: () => EditMySenderRecipientScreen(),
    ),
    GetPage(
      name: Routes.addMySenderRecipientScreen,
      page: () => AddMySenderRecipientScreen(),
    ),
    GetPage(
      name: Routes.sendMoneyQRCodeScreen,
      page: () => const SendMoneyQRCodeScreen(),
    ),

    // Exchange money screen
    GetPage(
      name: Routes.moneyExchange,
      page: () => ExchangeMoneyScreen(),
    ),
    GetPage(
      name: Routes.exchangeMoneyPreviewScreen,
      page: () => ExchangeMoneyPreviewScreen(),
    ),
    GetPage(
      name: Routes.perfectMoneyWebPaymentScreen,
      page: () => PerfectMoneyWebPaymentScreen(),
    ),
    GetPage(
      name: Routes.walletsScreen,
      page: () => WalletsScreen(),
    ),

    GetPage(
      name: Routes.smsOtpScreen,
      page: () => SmsOtpScreen(),
    ),
    GetPage(
      name: Routes.phoneVerificationScreen,
      page: () => PhoneVerificationScreen(),
    ),
    GetPage(
      name: Routes.resetPhoneOtpScreen,
      page: () => ResetPhoneOtpScreen(),
    ),
    GetPage(
      name: Routes.resetPasswordPhoneScreen,
      page: () => ResetPasswordPhoneScreen(),
    ),
  ];
}
