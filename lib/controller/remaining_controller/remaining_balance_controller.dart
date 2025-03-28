import 'package:get/get.dart';

import '../../../backend/services/api_services.dart';
import '../../backend/model/wallet/remaining_balance_model.dart';

class RemaingBalanceController extends GetxController {
  RxString transactionType = "".obs;
  RxString attribute = "".obs;
  RxString senderAmount = "0".obs;
  RxString senderCurrency = "".obs;
  RxInt cardId = 0.obs;

  // remaing limit
  RxDouble remainingDailyLimit = 0.0.obs;
  RxDouble remainingMonthLyLimit = 0.0.obs;

  // @override
  // void onInit() {
  //   getRemainingBalanceProcess();
  //   super.onInit();
  // }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  late RemainingBalanceModel? _remainingBalanceModel;

  RemainingBalanceModel? get remainingBalanceModel => _remainingBalanceModel;
  Future<RemainingBalanceModel?> getRemainingBalanceProcess() async {
    _isLoading.value = true;
    update();

    await ApiServices.remainingBalanceAPi(
            transactionType.value,
            attribute.value,
            senderAmount.value ?? '0',
            senderCurrency.value,
            cardId.value)
        .then((value) {
      _remainingBalanceModel = value!;

      remainingDailyLimit.value =
          double.parse(_remainingBalanceModel?.data.remainingDaily ?? "0");
      // print(" this is daily limit: ${remainingDailyLimit.value}");
      senderCurrency.value = _remainingBalanceModel?.data.currency ?? "0";
      remainingMonthLyLimit.value =
          double.parse(_remainingBalanceModel?.data.remainingMonthly ?? "0");
      // print(" this is daily limit: ${remainingMonthLyLimit.value}");
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      // print('This is the required error $onError');
      log.e(onError);
      _isLoading.value = false;
    });
    _isLoading.value = false;
    update();
    return _remainingBalanceModel;
  }
}
