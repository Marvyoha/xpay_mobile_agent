// ignore_for_file: use_build_context_synchronously

import 'package:qrpay/backend/utils/custom_loading_api.dart';
import 'package:qrpay/utils/responsive_layout.dart';
import 'package:qrpay/widgets/appbar/appbar_widget.dart';
import 'package:qrpay/widgets/others/preview/amount_preview_widget.dart';
import 'package:qrpay/widgets/others/preview/information_amount_widget.dart';
import 'package:qrpay/widgets/text_labels/title_heading5_widget.dart';

import '../../../backend/utils/custom_snackbar.dart';
import '../../../controller/categories/send_money/send_money_controller.dart';
import '../../../controller/navbar/dashboard_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/others/congratulation_widget.dart';

class SendMoneyPreviewScreen extends StatelessWidget {
  SendMoneyPreviewScreen({super.key});

  final controller = Get.put(SendMoneyController());
  final dashboardController = Get.find<DashBoardController>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        appBar: const AppBarWidget(text: Strings.preview),
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.5),
      physics: const BouncingScrollPhysics(),
      children: [
        _amountWidget(context),
        _amountInformationWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _amountWidget(BuildContext context) {
    return previewAmount(
        amount:
            '${controller.senderAmountController.text} ${controller.selectSenderWallet.value!.currency.code}');
  }

  _amountInformationWidget(BuildContext context) {
    var senderCurrency = controller.selectSenderWallet.value!.currency;
    var receiverCurrency = controller.selectReceiverWallet.value!.currency;
    int precision =
        controller.selectSenderWallet.value!.currency.type == 'FIAT' ? 4 : 8;

    return amountInformationWidget(
      children: Column(
        children: [
          _rowWidget(
            title: Strings.sendingWallet,
            subTitle: "${senderCurrency.code} (${senderCurrency.country})",
          ),
          _rowWidget(
            title: Strings.receivingWallet,
            subTitle: "${receiverCurrency.code} (${receiverCurrency.country})",
          ),
        ],
      ),
      information: Strings.amountInformation,
      enterAmount: Strings.enterAmount,
      enterAmountRow:
          '${controller.senderAmountController.text} ${controller.selectSenderWallet.value!.currency.code}',
      fee: Strings.transferFee,
      feeRow:
          '${controller.totalFee.value.toStringAsFixed(precision)} ${controller.selectSenderWallet.value!.currency.code}',
      received: Strings.recipientReceived,
      receivedRow:
          '${controller.receiverAmountController.text} ${controller.selectReceiverWallet.value!.currency.code}',
      total: Strings.totalPayable,
      totalRow:
          '${("${double.parse(controller.senderAmountController.text.isNotEmpty ? controller.senderAmountController.text : '0.0') + controller.totalFee.value}")} ${controller.selectSenderWallet.value!.currency.code}',
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.marginSizeVertical * 2,
      ),
      child: Obx(
        () => controller.isSendMoneyLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.confirm,
                onPressed: () {
                  if (dashboardController.kycStatus.value == 1) {
                    controller.sendMoneyProcess(context).then(
                          (value) => StatusScreen.show(
                            context: context,
                            subTitle: Strings.yourmoneySenSuccess,
                            onPressed: () {
                              Get.offAllNamed(Routes.bottomNavBarScreen);
                            },
                          ),
                        );
                  } else {
                    CustomSnackBar.error(Strings.pleaseSubmitYourInformation);
                    Future.delayed(const Duration(seconds: 2), () {
                      Get.toNamed(Routes.updateKycScreen);
                    });
                  }
                },
              ),
      ),
    );
  }

  _rowWidget({required String title, required String subTitle}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: mainSpaceBet,
          children: [
            TitleHeading5Widget(
              text: title,
              color: Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor.withValues(alpha:0.6)
                  : CustomColor.primaryLightColor.withValues(alpha:
                      0.4,
                    ),
            ),
            TitleHeading4Widget(
              text: subTitle,
              color: Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor.withValues(alpha:0.6)
                  : CustomColor.primaryLightColor.withValues(alpha:
                      0.6,
                    ),
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        verticalSpace(Dimensions.heightSize * 0.7),
      ],
    );
  }
}
