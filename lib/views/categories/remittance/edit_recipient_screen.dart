import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrpay/utils/dimensions.dart';
import 'package:qrpay/utils/responsive_layout.dart';
import 'package:qrpay/widgets/appbar/appbar_widget.dart';
import 'package:qrpay/widgets/buttons/primary_button.dart';
import 'package:qrpay/widgets/inputs/phone_number_with_contry_code_input.dart';

import '../../../backend/utils/custom_loading_api.dart';
// import '../../../backend/utils/custom_snackbar.dart';
import '../../../controller/categories/remittance/edit_recipient_controller.dart';
import '../../../controller/drawer/recipient/my_recipient/my_recipient_controller.dart';
import '../../../language/english.dart';
import '../../../utils/custom_style.dart';
import '../../../utils/size.dart';
import '../../../widgets/inputs/primary_input_filed.dart';
import '../../../widgets/text_labels/custom_title_heading_widget.dart';
import 'banks_dropdown_widget.dart';
import 'receiver_country_dropdown_widget.dart';
import 'recipient_email_input_widget.dart';
import 'transaction_type_dropdown_widget.dart';

class EditRecipientScreen extends StatelessWidget {
  EditRecipientScreen({super.key});

  final controller = Get.put(EditRecipientController());
  final myRecipientController = Get.put(MyRecipientController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        appBar: const AppBarWidget(text: Strings.updateReceipient),
        body: Obx(() => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context)),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.marginSizeHorizontal * 0.9),
        children: [
          _transTypeWidget(),
          _countryWidget(),
          _phoneNumerWidget(),
          _emailWidget(),
          if (controller.transactionTypeSelectedMethod.value ==
              controller.transactionTypeList[0].labelName) ...[
            _accountNumberWidget(context),
          ],
          _nameEmailInput(context),
          verticalSpace(Dimensions.heightSize),
          _addressInput(context),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _emailWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RecipientEmailInputWidget(
          controller: controller.emailController,
          hint: Strings.enterEmailAddress.tr,
          label: Strings.emailAddress.tr,
          maxLines: 1,
        ),
        verticalSpace(Dimensions.heightSize),
        // Obx(() {
        //   return TitleHeading5Widget(
        //     text: controller.checkUserMessage.value,
        //     color: controller.isValidUser.value ? Colors.green : Colors.red,
        //   );
        // }),
        verticalSpace(Dimensions.heightSize),
      ],
    );
  }

  _phoneNumerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PhoneNumberInputWidget(
          countryCode: controller.numberCode,
          controller: controller.numberController,
          keyBoardType: TextInputType.number,
          hint: Strings.xxx,
          label: Strings.phoneNumber,
        ),
        verticalSpace(Dimensions.heightSize),
      ],
    );
  }

  _transTypeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitleHeadingWidget(
            text: Strings.transactionType, style: CustomStyle.labelTextStyle),
        verticalSpace(Dimensions.heightSize * 0.5),
        TransactionTypeDropDown(
          selectMethod: controller.transactionTypeSelectedMethod,
          itemsList: controller.transactionTypeList,
          onChanged: (value) {
            controller.transactionTypeSelectedMethod.value = value!.labelName;
            controller.transactionType = value;
          },
        ),
        verticalSpace(Dimensions.heightSize),
      ],
    );
  }

  _nameEmailInput(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryInputWidget(
            hint: Strings.enterFirstName,
            label: Strings.firstName,
            controller: controller.firstNameController,
          ),
        ),
        horizontalSpace(Dimensions.widthSize),
        Expanded(
          child: PrimaryInputWidget(
            hint: Strings.enterLastName,
            label: Strings.lastName,
            controller: controller.lastNameController,
          ),
        ),
      ],
    );
  }

  _addressInput(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        Row(
          children: [
            Expanded(
              child: PrimaryInputWidget(
                hint: Strings.enterAddress,
                label: Strings.address,
                controller: controller.addressController,
              ),
            ),
            horizontalSpace(Dimensions.widthSize),
            Expanded(
              child: PrimaryInputWidget(
                hint: Strings.enterState,
                label: Strings.state,
                controller: controller.stateController,
              ),
            ),
          ],
        ),
        verticalSpace(Dimensions.heightSize),
        Row(
          children: [
            Expanded(
              child: PrimaryInputWidget(
                hint: Strings.enterCity,
                label: Strings.city,
                controller: controller.cityController,
              ),
            ),
            horizontalSpace(Dimensions.widthSize),
            Expanded(
              child: PrimaryInputWidget(
                hint: Strings.enterZipCode,
                label: Strings.zipCode,
                keyboardType: TextInputType.number,
                controller: controller.zipController,
              ),
            ),
          ],
        ),
        verticalSpace(Dimensions.heightSize),
        Obx(() => Visibility(
              visible: controller.transactionTypeSelectedMethod.value ==
                  controller.transactionTypeList[2].labelName,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTitleHeadingWidget(
                      text: Strings.pickUpPoint,
                      style: CustomStyle.labelTextStyle),
                  verticalSpace(Dimensions.heightSize * 0.5),
                  ReceiverBankDropDown(
                    selectMethod: controller.pickupPointMethod,
                    itemsList: controller.pickupPointList,
                    onChanged: (value) {
                      controller.pickupPointMethod.value = value!.name;
                      controller.pickupPoint = value;
                    },
                  ),
                ],
              ),
            )),
        Obx(() => Visibility(
              visible: controller.transactionTypeSelectedMethod.value ==
                  controller.transactionTypeList[0].labelName,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTitleHeadingWidget(
                      text: Strings.selectBank,
                      style: CustomStyle.labelTextStyle),
                  verticalSpace(Dimensions.heightSize * 0.5),
                  ReceiverBankDropDown(
                    selectMethod: controller.receiverBankSelectedMethod,
                    itemsList: controller.receiverBankList,
                    onChanged: (value) {
                      controller.receiverBankSelectedMethod.value = value!.name;
                      controller.receiverBank = value;
                    },
                  ),
                ],
              ),
            )),
      ],
    );
  }

  _countryWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitleHeadingWidget(
            text: Strings.selectCountry, style: CustomStyle.labelTextStyle),
        verticalSpace(Dimensions.heightSize * 0.5),
        ReceiverCountryDropdownSearch(
          selectMethod: controller.receiverCountrySelectedMethod,
          itemsList: controller.receiverCountryList,
          onChanged: (value) {
            controller.receiverCountrySelectedMethod.value = value!.name;
            controller.receiverCountry = value;
            controller.numberCode.value = value.mobileCode;
          },
        ),
        verticalSpace(Dimensions.heightSize),
      ],
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.marginSizeVertical),
      child: PrimaryButton(
          title: Strings.updateReceipient,
          onPressed: () {
            if (formKey.currentState!.validate()) {
              controller.recipientUpdateApiProcess().then((value) {
                Get.close(1);
                myRecipientController.getMyRecipientData();
                // CustomSnackBar.success('Recipient saved successfully'.tr);
              });
            }
          }),
    );
  }

  _accountNumberWidget(BuildContext context) {
    return Column(
      children: [
        PrimaryInputWidget(
          hint: Strings.enterAccountNumber,
          label: Strings.accountNumber,
          keyboardType: TextInputType.number,
          controller: controller.accountNumberController,
        ),
        verticalSpace(Dimensions.heightSize),
      ],
    );
  }
}
