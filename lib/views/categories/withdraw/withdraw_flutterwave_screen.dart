import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrpay/backend/utils/custom_loading_api.dart';
import 'package:qrpay/routes/routes.dart';
import 'package:qrpay/utils/dimensions.dart';
import 'package:qrpay/utils/responsive_layout.dart';
import 'package:qrpay/utils/size.dart';
import 'package:qrpay/widgets/appbar/appbar_widget.dart';
import 'package:qrpay/widgets/buttons/primary_button.dart';

import '../../../controller/categories/withdraw_controller/withdraw_controller.dart';
import '../../../language/english.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/custom_style.dart';
import '../../../widgets/dropdown/flutter_wave_banks_drop_down.dart';
import '../../../widgets/dropdown/flutter_wave_branch_dropdown.dart';
import '../../../widgets/inputs/primary_input_filed.dart';
import '../../../widgets/others/congratulation_widget.dart';
import '../../../widgets/text_labels/custom_title_heading_widget.dart';

class WithdrawFlutterWaveScreen extends StatefulWidget {
  const WithdrawFlutterWaveScreen({super.key});

  @override
  State<WithdrawFlutterWaveScreen> createState() =>
      _WithdrawFlutterWaveScreenState();
}

class _WithdrawFlutterWaveScreenState extends State<WithdrawFlutterWaveScreen> {
  final controller = Get.put(WithdrawController());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        appBar: AppBarWidget(
            text: Strings.withdraw,
            onTapLeading: () => Get.offAllNamed(Routes.bottomNavBarScreen)),
        body: Obx(
          () => controller.isLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context),
        ),
        bottomNavigationBar: _buttonWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.9),
      child: Column(
        children: [
          _inputWidget(context),
        ],
      ),
    );
  }

  _inputWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.marginSizeVertical * 1),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleHeading4Widget(
              text: Strings.selectBank,
              fontWeight: FontWeight.w600,
            ),
            verticalSpace(Dimensions.heightSize * .8),
            FlutterWaveBanksDropDown(
              bankInfoList: controller.bankInfoList,
              selectMethod: controller.selectedCountry,
              onChanged: (value) {
                controller.bankCode.value = value!.code.toString();
                controller.bankNameController.text = value.name;
                controller.selectedCountry.value = value.name;
                controller.selectFlutterWaveBankId.value = value.id;
                controller.isSearchEnable.value = false;
                controller.getFlutterWaveBanksBranch();
              },
            ),
            verticalSpace(Dimensions.heightSize * .8),
            if (controller.isBranch.value)
              const FlutterWaveBanksBranchesDropDown()
            // FlutterWaveBanksBranchesDropDown(
            //     selectMethod: controller.selectedBranch,
            //     bankBranchInfoList: controller.bankBranchInfoList,
            //     onChanged: (value) {
            //       print("Debug: Branch selected: ${value?.branchName}");
            //       controller.selectFlutterWaveBankBranchCode.value =
            //           value!.branchCode;
            //       controller.selectFlutterWaveBankBranchName.value =
            //           value.branchName;
            //       controller.selectedBranch.value = value.branchName;

            //       controller.branchNameController.text = value.branchName;

            //       controller.isBranchSearchEnable.value = false;
            //     })
            ,
            PrimaryInputWidget(
              controller: controller.accountNumberController,
              keyboardType: TextInputType.number,
              hint: Strings.enterAccountNumber.tr,
              label: Strings.accountNumber.tr,
              onFieldSubmitted: (value) {
                controller.isButtonEnable.value = false;
                controller.checkAccountInfo();
              },
            ),
            verticalSpace(Dimensions.heightSize * .8),
            PrimaryInputWidget(
              controller: controller.beneficiaryNameController,
              hint: Strings.enterBeneficiaryName.tr,
              label: Strings.beneficiaryName,
              onFieldSubmitted: (value) {
                controller.isButtonEnable.value = false;
              },
            ),
          ],
        ),
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Dimensions.paddingSize * .5),
      child: Obx(
        () => controller.isConfirmManualLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.confirm,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    controller.flutterwavePaymentProcess().then(
                      (value) {
                        if (context.mounted) {
                          StatusScreen.show(
                            context: context,
                            subTitle: controller.manualPaymentConfirmModel
                                .message.success.first,
                            onPressed: () {
                              controller.isButtonEnable.value = false;
                              Get.offAllNamed(Routes.bottomNavBarScreen);
                            },
                          );
                        }
                      },
                    );
                  }
                }),
      ),
    );
  }
}
