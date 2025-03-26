import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:qrpay/backend/utils/custom_loading_api.dart';
import 'package:qrpay/backend/utils/custom_snackbar.dart';
import 'package:qrpay/custom_assets/assets.gen.dart';
import 'package:qrpay/routes/routes.dart';
import 'package:qrpay/utils/custom_color.dart';
import 'package:qrpay/utils/dimensions.dart';
import 'package:qrpay/utils/responsive_layout.dart';
import 'package:qrpay/utils/size.dart';
import 'package:qrpay/widgets/appbar/appbar_widget.dart';
import 'package:qrpay/widgets/buttons/primary_button.dart';

import '../../../backend/local_storage/local_storage.dart';
import '../../../controller/categories/money_in/money_in_controller.dart';
import '../../../controller/navbar/dashboard_controller.dart';
import '../../../language/english.dart';
import '../../../widgets/inputs/money_in_copy_with_input.dart';
import '../../../widgets/inputs/money_in_drop_down.dart';
import '../../../widgets/inputs/primary_input_filed.dart';
import '../../../widgets/others/limit_information_widget.dart';
import '../../../widgets/others/limit_widget.dart';
import '../../../widgets/text_labels/title_heading5_widget.dart';

class MoneyInScreen extends StatelessWidget {
  MoneyInScreen({super.key});

  final dashboardController = Get.put(DashBoardController());
  final controller = Get.put(MoneyInController());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        appBar: const AppBarWidget(text: Strings.moneyIn),
        body: Obx(
          () => controller.isLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    int precision = controller.selectSenderWallet.value!.currency.type == 'FIAT'
        ? LocalStorage.getFiatPrecision()
        : LocalStorage.getCryptoPrecision();
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.9),
      physics: const BouncingScrollPhysics(),
      children: [
        _inputWidget(context),
        Obx(() {
          return LimitWidget(
              fee:
                  '${controller.totalFee.value.toStringAsFixed(precision)} ${controller.selectSenderWallet.value?.currency.code}',
              limit:
                  '${controller.limitMin.toStringAsFixed(precision)} - ${controller.limitMax.toStringAsFixed(precision)} ${controller.selectSenderWallet.value?.currency.code}');
        }),
        _limitInformation(context),
        _buttonWidget(context),
      ],
    );
  }

  _inputWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.marginSizeVertical),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MoneyInCopyWithInput(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.moneyInQRCodeScreen);
                    },
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                          color: CustomColor.primaryLightColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimensions.radius * 0.5),
                            bottomRight:
                                Radius.circular(Dimensions.radius * 0.5),
                          )),
                      child: Center(
                        child: controller.isCheckUserLoading
                            ? const CustomLoadingAPI(
                                colors: Colors.white,
                              )
                            : SvgPicture.asset(Assets.icon.scan,
                                colorFilter: const ColorFilter.mode(
                                    CustomColor.whiteColor, BlendMode.srcIn)),
                      ),
                    ),
                  ),
                  suffixColor: CustomColor.primaryDarkColor,
                  onTap: () {
                    // if (controller.copyInputController.text.isNotEmpty) {
                    //   controller.getCheckMoneyInUserExistDate();
                    // } else {
                    //   Get.toNamed(Routes.qRCodeScreen);
                    // }
                  },
                  controller: controller.copyInputController,
                  hint: Strings.enterEmailPhone,
                  label: Strings.phoneEmail,
                ),
                Obx(() {
                  return TitleHeading5Widget(
                    text: controller.checkUserMessage.value,
                    color: controller.isValidUser.value
                        ? CustomColor.greenColor
                        : CustomColor.redColor,
                  );
                })
              ],
            ),
            verticalSpace(Dimensions.heightSize),
            MoneyInInputWithDropdown(
              controller: controller.senderAmountController,
              hint: Strings.zero00,
              label: Strings.senderAmount,
              selectWallet: controller.selectSenderWallet,
            ),
            Obx(() {
              if (dashboardController
                      .walletController
                      .walletsInfoModel
                      .data
                      .userWallets[controller.selectedWalletIndex.toInt()]
                      .balance <
                  double.parse(controller
                          .remainingController.senderAmount.value.isEmpty
                      ? "0"
                      : controller.remainingController.senderAmount.value)) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: TitleHeading5Widget(
                    text: 'Insufficient balance',
                    color: CustomColor.redColor,
                  ),
                );
              }
              return const SizedBox();
            }),
            verticalSpace(Dimensions.heightSize),
            MoneyInInputWithDropdown(
              controller: controller.receiverAmountController,
              hint: Strings.zero00,
              label: Strings.receiverAmount,
              selectWallet: controller.selectReceiverWallet,
            ),
            verticalSpace(Dimensions.heightSize),
            PrimaryInputWidget(
              controller: controller.remarkController,
              hint: Strings.enterRemark,
              isValidator: false,
              label:
                  "${Strings.remark.translation} (${Strings.optional.translation})",
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }

  _limitInformation(BuildContext context) {
    int precision = controller.selectSenderWallet.value!.currency.type == 'FIAT'
        ? LocalStorage.getFiatPrecision()
        : LocalStorage.getCryptoPrecision();
    return LimitInformationWidget(
      showDailyLimit: controller.dailyLimit.value == 0.0 ? false : true,
      showMonthlyLimit: controller.monthlyLimit.value == 0.0 ? false : true,
      transactionLimit:
          '${controller.limitMin.value.toStringAsFixed(precision)} - ${controller.limitMax.value.toStringAsFixed(precision)} ${controller.selectSenderWallet.value!.currency.code}',
      dailyLimit:
          '${controller.dailyLimit.value.toStringAsFixed(precision)} ${controller.selectSenderWallet.value!.currency.code}',
      monthlyLimit:
          '${controller.monthlyLimit.value.toStringAsFixed(precision)} ${controller.selectSenderWallet.value!.currency.code}',
      remainingMonthLimit:
          '${controller.remainingController.remainingMonthLyLimit.value.toStringAsFixed(precision)} ${controller.selectSenderWallet.value!.currency.code}',
      remainingDailyLimit:
          '${controller.remainingController.remainingDailyLimit.value.toStringAsFixed(precision)} ${controller.selectSenderWallet.value!.currency.code}',
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.marginSizeVertical * 1,
        bottom: Dimensions.marginSizeVertical,
      ),
      child: Obx(
        () => controller.isMoneyInLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                buttonColor: controller.isValidUser.value &&
                        double.tryParse(controller
                                .remainingController.senderAmount.value) !=
                            null &&
                        double.parse(controller.remainingController.senderAmount.value) <=
                            controller.dailyLimit.value &&
                        double.parse(controller.remainingController.senderAmount.value) <=
                            controller.monthlyLimit.value &&
                        double.parse(controller.remainingController.senderAmount.value) !=
                            0 &&
                        double.parse(controller.remainingController.senderAmount.value) >=
                            controller.limitMin.value &&
                        double.parse(controller.remainingController.senderAmount.value) <=
                            controller.limitMax.value &&
                        dashboardController
                                .walletController
                                .walletsInfoModel
                                .data
                                .userWallets[
                                    controller.selectedWalletIndex.toInt()]
                                .balance >=
                            double.parse(controller.remainingController
                                    .senderAmount.value.isEmpty
                                ? "0"
                                : controller.remainingController.senderAmount.value)
                    ? CustomColor.primaryLightColor
                    : CustomColor.primaryLightColor.withValues(alpha: 0.3),
                title: Strings.send,
                onPressed: () {
                  if (controller.isValidUser.value &&
                      double.tryParse(controller
                              .remainingController.senderAmount.value) !=
                          null &&
                      double.parse(controller.remainingController.senderAmount.value) <=
                          controller.dailyLimit.value &&
                      double.parse(controller.remainingController.senderAmount.value) <=
                          controller.monthlyLimit.value &&
                      double.parse(controller.remainingController.senderAmount.value) !=
                          0 &&
                      double.parse(controller.remainingController.senderAmount.value) >=
                          controller.limitMin.value &&
                      double.parse(controller
                              .remainingController.senderAmount.value) <=
                          controller.limitMax.value &&
                      dashboardController
                              .walletController
                              .walletsInfoModel
                              .data
                              .userWallets[
                                  controller.selectedWalletIndex.toInt()]
                              .balance >=
                          double.parse(controller.remainingController
                                  .senderAmount.value.isEmpty
                              ? "0"
                              : controller
                                  .remainingController.senderAmount.value)) {
                    Get.toNamed(Routes.moneyInPreviewScreen);
                  }
                }),
      ),
    );
  }
}
