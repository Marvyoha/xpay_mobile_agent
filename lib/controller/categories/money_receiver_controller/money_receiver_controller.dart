import 'dart:convert';

import 'package:qrpay/backend/model/categories/receive_money/receive_money_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../backend/services/api_services.dart';
import '../../../backend/utils/logger.dart';

final log = logger(MoneyReceiverController);

class MoneyReceiverController extends GetxController {
  final inputController = TextEditingController();
  final expectedAmountController = TextEditingController();

  final generatedCode = ''.obs;
  RxString transactionType = "".obs;
  RxString attribute = "".obs;
  RxString senderAmount = "0".obs;
  RxString senderCurrency = "".obs;
  RxInt cardId = 0.obs;

  @override
  void onInit() {
    getReceiveMoneyData();
    super.onInit();
  }

  // ---------------------------------------------------------------------------
  //                              Get Card Info Data
  // ---------------------------------------------------------------------------

  // -------------------------------Api Loading Indicator-----------------------
  //
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  // -------------------------------Define API Model-----------------------------
  //
  late ReceiveMoneyModel? _receiveMoneyModel;

  ReceiveMoneyModel? get receiveMoneyModel => _receiveMoneyModel;

  // ------------------------------API Function---------------------------------
  //

  // void getNewQRCode() {
  //   generatedCode.value = jsonEncode({
  //     "expectedAmount":
  //         expectedAmountController.text.replaceAll(RegExp(r','), ''),
  //     "currency": senderCurrency.value.isEmpty ? "USD" : senderCurrency.value,
  //     "uniqueCode": _receiveMoneyModel?.data.uniqueCode,
  //     "fromBarcode": true
  //   });

  //   print("new code => ${generatedCode.value}");
  // }

  Future<ReceiveMoneyModel?> getReceiveMoneyData() async {
    _isLoading.value = true;
    update();

    await ApiServices.receiveMoneyApi().then((value) {
      _receiveMoneyModel = value!;
      inputController.text =
          _receiveMoneyModel?.data.uniqueCode.toString() ?? '';
      generatedCode.value = jsonEncode({
        "expectedAmount":
            expectedAmountController.text.replaceAll(RegExp(r','), ''),
        "origin": "agent",
        "currency": senderCurrency.value.isEmpty ? "USD" : senderCurrency.value,
        "uniqueCode": _receiveMoneyModel?.data.uniqueCode,
        "fromBarcode": true
      });
      // Get.bottomSheet(
      //     enableDrag: false,
      //     isDismissible: false,
      //     backgroundColor: Colors.white,
      //     RecieveMoneyBottomSheet(
      //         expectedAmountController: expectedAmountController));
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _receiveMoneyModel;
  }
}
