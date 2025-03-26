import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrpay/controller/categories/send_money/send_money_controller.dart';

import '../../../custom_assets/assets.gen.dart';
import '../../../language/english.dart';
import '../../../routes/routes.dart';
import '../../../utils/custom_color.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/responsive_layout.dart';
import '../../../widgets/appbar/appbar_widget.dart';
import '../../others/custom_image_widget.dart';

class SendMoneyQRCodeScreen extends StatefulWidget {
  const SendMoneyQRCodeScreen({Key? key}) : super(key: key);

  @override
  ScanScreenState createState() => ScanScreenState();
}

class ScanScreenState extends State<SendMoneyQRCodeScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  RxBool isVisible = true.obs;
  final sendMoneyController = Get.put(SendMoneyController());

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void readQr() async {
    if (barcode != null) {
      controller!.pauseCamera();
      controller!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: CustomColor.primaryLightScaffoldBackgroundColor),
    );
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        appBar: const AppBarWidget(
          text: Strings.scanQR,
        ),
        body: _bodyWidget(context),
      ),
    );
  }

  // body widget containing all widget elements
  _bodyWidget(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 40,
            child: _scanQrCodeWidget(context),
          ),
          Positioned(
            bottom: 20,
            right: 5,
            left: 5,
            child: _iconButtonWidget(context),
          ),
        ],
      ),
    );
  }

  _scanQrCodeWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: _buildQrViewWidget(context),
    );
  }

  _buildQrViewWidget(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width * 0.6,
          borderWidth: 8,
          borderLength: 20,
          borderRadius: 10,
          borderColor: Theme.of(context).primaryColor),
    );
  }

  void onQRViewCreated(QRViewController? controller) {
    setState(() => this.controller = controller);
    // this.controller = controller;
    controller!.scannedDataStream.listen((barcode) => setState(() {
          this.barcode = barcode;
          Map<String, dynamic> qrCodeData;
          qrCodeData = jsonDecode(barcode.code.toString());
          String uniqueCode = qrCodeData["uniqueCode"].toString();
          sendMoneyController.senderAmountController.text =
              qrCodeData["expectedAmount"].toString().isNotEmpty
                  ? qrCodeData["expectedAmount"].toString()
                  : "0";
          sendMoneyController.receiverAmountController.text =
              qrCodeData["expectedAmount"].toString().isNotEmpty
                  ? qrCodeData["expectedAmount"].toString()
                  : "0";
          sendMoneyController.remainingController.senderCurrency.value =
              qrCodeData['currency'];
          sendMoneyController.senderCurrency.value = qrCodeData['currency'];
          sendMoneyController.receiverCurrency.value = qrCodeData['currency'];
          sendMoneyController.fromBarcode.value = qrCodeData['fromBarcode'];

          sendMoneyController.getCheckUserWithQrCodeData(uniqueCode);
          // Get.back();
          debugPrint("this.barcode!.code=> ${this.barcode!.code}");

          sendMoneyController.copyInputController.text = uniqueCode;
          Get.back();
          // Get.toNamed(Routes.moneyTransferScreen);
          readQr();
        }));
  }

  _iconButtonWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.8),
      margin: EdgeInsets.only(
        bottom: Dimensions.marginSizeVertical,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            radius: 30,
            backgroundColor: CustomColor.primaryLightColor,
            child: CustomImageWidget(path: Assets.icon.scan),
          ),
        ),
      ]),
    );
  }
}
