import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrpay/routes/routes.dart';

import '../../../backend/model/categories/bill_pay_model/bill_pay_model.dart';
import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/model/wallet/wallets_model.dart';
import '../../../backend/services/api_services.dart';
import '../../../backend/utils/logger.dart';
import '../../../language/english.dart';
import '../../../widgets/others/congratulation_widget.dart';
import '../../remaining_controller/remaining_balance_controller.dart';
import '../../wallet/wallets_controller.dart';

final log = logger(BillPayController);

class BillPayController extends GetxController {
  RxString billMethodselected = "".obs;
  RxString billTypeNameMethod = "".obs;
  RxString billItemType = "".obs;
  RxString selectedBillMonths = "".obs;
  RxString type = "".obs;
  List<BillType> billList = [];
  List<String> billMonthsList = [];

  final billNumberController = TextEditingController();
  final amountController = TextEditingController();
  final walletsController = Get.find<WalletsController>();
  final remainingController = Get.put(RemaingBalanceController());

  RxDouble fee = 0.0.obs;
  RxDouble limitMin = 0.0.obs;
  RxDouble limitMax = 0.0.obs;
  RxDouble dailyLimit = 0.0.obs;
  RxDouble monthlyLimit = 0.0.obs;
  RxDouble automaticMin = 0.0.obs;
  RxDouble automaticMax = 0.0.obs;
  RxDouble automaticLimitMin = 0.0.obs;
  RxDouble automaticLimitMax = 0.0.obs;
  RxDouble manualLimitMin = 0.0.obs;
  RxDouble manualLimitMax = 0.0.obs;
  RxDouble percentCharge = 0.0.obs;
  RxDouble automaticCharge = 0.0.obs;
  RxDouble fixedCharge = 0.0.obs;
  RxDouble rate = 0.0.obs;
  RxDouble automaticRate = 0.0.obs;
  RxDouble totalFee = 0.0.obs;
  RxDouble exchangeRate = 0.0.obs;
  RxDouble automaticTotalFee = 0.0.obs;
  RxString baseCurrency = "".obs;
  RxString automaticSelectedCurrency = "".obs;
  RxBool isAutomatic = false.obs;
  RxBool isCrypto = false.obs;

  Rxn<MainUserWallet> selectMainWallet = Rxn<MainUserWallet>();
  List<MainUserWallet> walletsList = [];
  @override
  void onInit() {
    amountController.text = "0";
    getBillPayInfoData();
    super.onInit();
  }

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  final _isInsertLoading = false.obs;

  bool get isInsertLoading => _isInsertLoading.value;

  BillPayInfoModel? _billPayInfoData;

  BillPayInfoModel? get billPayInfoData => _billPayInfoData;

  // --------------------------- Api function ----------------------------------
  // get bill pay data function
  Future<BillPayInfoModel?> getBillPayInfoData() async {
    _isLoading.value = true;
    update();

    await ApiServices.billPayInfoAPi().then((value) {
      _billPayInfoData = value!;
      var data = _billPayInfoData?.data;
      baseCurrency.value = data?.baseCurr ?? "";
      limitMin.value = data?.billPayCharge.minLimit;
      limitMax.value = data?.billPayCharge.maxLimit;
      dailyLimit.value = data?.billPayCharge.dailyLimit;
      monthlyLimit.value = data?.billPayCharge.monthlyLimit;
      automaticMin.value = data?.billTypes.first.minLocalTransactionAmount;
      automaticMax.value = data?.billTypes.first.maxLocalTransactionAmount;
      automaticLimitMin.value = data?.billTypes.first.minLocalTransactionAmount;
      automaticLimitMax.value = data?.billTypes.first.maxLocalTransactionAmount;
      percentCharge.value = data?.billPayCharge.percentCharge;
      fixedCharge.value = data?.billPayCharge.fixedCharge;
      rate.value = data?.baseCurrRate;
      automaticRate.value = data?.billTypes.first.receiverCurrencyRate;
      automaticSelectedCurrency.value =
          data?.billTypes.first.receiverCurrencyCode;
      // type.value = data.billTypes.first.id.toString();
      billItemType.value = data?.billTypes.first.itemType ?? "";

      // Get wallet information
      selectMainWallet.value =
          walletsController.walletsInfoModel.data.userWallets.first;
      for (var element in walletsController.walletsInfoModel.data.userWallets) {
        walletsList.add(
          MainUserWallet(
            balance: element.balance,
            currency: element.currency,
            status: element.status,
          ),
        );
      }
      // print('billTypes: ${data?.billTypes.first.id}');
      if (data?.billTypes.first.name == "AUTOMATIC") {
        isAutomatic.value = true;
      } else {
        isAutomatic.value = false;
      }

      billMethodselected.value = data?.billTypes.first.name ?? "";
      billTypeNameMethod.value = data?.billTypes.first.name ?? "";

      for (var element in data!.billTypes) {
        billList.add(
          BillType(
            id: element.id,
            name: element.name,
            countryCode: element.countryCode,
            countryName: element.countryName,
            type: element.type,
            serviceType: element.serviceType,
            minLocalTransactionAmount: element.minLocalTransactionAmount,
            maxLocalTransactionAmount: element.maxLocalTransactionAmount,
            localTransactionFee: element.localTransactionFee,
            localTransactionFeeCurrencyCode:
                element.localTransactionFeeCurrencyCode,
            localTransactionFeePercentage:
                element.localTransactionFeePercentage,
            denominationType: element.denominationType,
            itemType: element.itemType,
            slug: element.slug,
            receiverCurrencyRate: element.receiverCurrencyRate,
            receiverCurrencyCode: element.receiverCurrencyCode,
          ),
        );
      }

      //start remaing get
      remainingController.transactionType.value =
          _billPayInfoData?.data.getRemainingFields.transactionType ?? "";
      remainingController.attribute.value =
          _billPayInfoData?.data.getRemainingFields.attribute ?? "";
      remainingController.cardId.value =
          _billPayInfoData?.data.billPayCharge.id ?? 0;
      remainingController.senderAmount.value = amountController.text;
      remainingController.senderCurrency.value =
          selectMainWallet.value!.currency.code;

      remainingController.getRemainingBalanceProcess();
      selectedBillMonths.value =
          _billPayInfoData?.data.billMonths.first.fieldName ?? "";
      for (var element in _billPayInfoData!.data.billMonths) {
        billMonthsList.add(element.fieldName);
      }

      automaticCharge.value = data.billTypes.first.localTransactionFee!;
      // Rate & currency get
      getExchangeRate(r: data.billTypes.first.receiverCurrencyRate);
      if (data.billTypes.first.itemType == "AUTOMATIC") {
        isAutomatic.value = true;
        exchangeRateUpdate();
        getAutomaticFee();
      } else {
        isAutomatic.value = false;
        getFee(rate: rate.value);
      }
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _billPayInfoData;
  }

  CommonSuccessModel? _successDatya;

  CommonSuccessModel? get successDatya => _successDatya;

  // Login process function
  Future<CommonSuccessModel?> billPayApiProcess({
    required String type,
    required String amount,
    required String billNumber,
    required BuildContext context,
  }) async {
    _isInsertLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'bill_type': type,
      'bill_number': billNumber,
      'amount': amount,
      'bill_month': selectedBillMonths.value,
      'biller_item_type': billItemType.value,
      'currency': selectMainWallet.value!.currency.code,
    };
    // print('billpayapiprocess typing: $type');
    // calling login api from api service
    await ApiServices.billPayConfirmedApi(body: inputBody).then((value) {
      _successDatya = value!;
      _isInsertLoading.value = false;
      StatusScreen.show(
        // ignore: use_build_context_synchronously
        context: context,
        subTitle: Strings.yourBillPaySuccess.tr,
        onPressed: () {
          Get.offAllNamed(Routes.bottomNavBarScreen);
        },
      );
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isInsertLoading.value = false;
    update();
    return _successDatya;
  }

  void gotoBillPreview(BuildContext context) {
    Get.toNamed(Routes.billPayPreviewScreen);
  }

  String? getType(String value) {
    for (var element in billPayInfoData!.data.billTypes) {
      if (element.name == value) {
        return element.id.toString();
      }
    }
    return null;
  }

  RxDouble getFee({required double rate}) {
    double value = fixedCharge.value * rate;

    _updateLimit(value);
    value = value +
        (double.parse(
                amountController.text.isEmpty ? '0.0' : amountController.text) *
            (percentCharge.value / 100));

    if (amountController.text.isEmpty) {
      totalFee.value = 0.0;
    } else {
      totalFee.value = value;
    }

    debugPrint(totalFee.value.toStringAsPrecision(2));
    return totalFee;
  }

  RxDouble getAutomaticFee() {
    double value = fixedCharge.value *
        double.parse(selectMainWallet.value!.currency.rate.toString());

    _updateLimit(value);
    value = value +
        (double.parse(
                amountController.text.isEmpty ? '0.0' : amountController.text) *
            (percentCharge.value / 100));

    if (amountController.text.isEmpty) {
      automaticTotalFee.value = 0.0;
    } else {
      automaticTotalFee.value = value;
    }

    debugPrint(automaticTotalFee.value.toStringAsPrecision(2));
    return automaticTotalFee;
  }

  RxDouble getExchangeRate({required double r}) {
    double value = rate.value / r;
    if (value == 0.0) {
      exchangeRate.value = 0.0;
    } else {
      exchangeRate.value = value;
    }
    return exchangeRate;
  }

  void _updateLimit(double value) {
    if (!isAutomatic.value) {
      manualLimitMin.value = limitMin.value * value;
      manualLimitMax.value = limitMax.value * value;
    }
  }

  exchangeRateUpdate() {
    exchangeRate.value = automaticRate.value /
        double.parse(selectMainWallet.value!.currency.rate.toString());
    automaticLimitMin.value = automaticMin.value / exchangeRate.value;
    automaticLimitMax.value = automaticMax.value / exchangeRate.value;
  }
}
