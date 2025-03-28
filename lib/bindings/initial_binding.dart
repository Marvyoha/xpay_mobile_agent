import 'package:get/get.dart';

import '../controller/navbar/dashboard_controller.dart';
import '../controller/wallet/wallets_controller.dart';

class InitialScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DashBoardController());
    Get.put(WalletsController());
  }
}
