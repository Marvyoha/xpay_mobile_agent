// To parse this JSON data, do
//
//     final withdrawFlutterWaveInsertModel = withdrawFlutterWaveInsertModelFromJson(jsonString);

import 'dart:convert';

WithdrawFlutterWaveInsertModel withdrawFlutterWaveInsertModelFromJson(
        String str) =>
    WithdrawFlutterWaveInsertModel.fromJson(json.decode(str));

class WithdrawFlutterWaveInsertModel {
  final Message message;
  final Data data;

  WithdrawFlutterWaveInsertModel({
    required this.message,
    required this.data,
  });

  factory WithdrawFlutterWaveInsertModel.fromJson(Map<String, dynamic> json) =>
      WithdrawFlutterWaveInsertModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final PaymentInformation paymentInformation;
  final String gatewayType;
  final String gatewayCurrencyName;
  final String alias;
  final String url;
  final String method;
  final bool branchAvailable;

  Data({
    required this.paymentInformation,
    required this.gatewayType,
    required this.gatewayCurrencyName,
    required this.alias,
    required this.url,
    required this.method,
    required this.branchAvailable,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        paymentInformation:
            PaymentInformation.fromJson(json["payment_information"]),
        gatewayType: json["gateway_type"],
        gatewayCurrencyName: json["gateway_currency_name"],
        alias: json["alias"],
        url: json["url"],
        method: json["method"],
        branchAvailable: json["branch_available"],
      );
}

class PaymentInformation {
  final String trx;
  final String gatewayCurrencyName;
  final String requestAmount;
  final String exchangeRate;
  final String conversionAmount;
  final String totalCharge;
  final String willGet;
  final String payable;

  PaymentInformation({
    required this.trx,
    required this.gatewayCurrencyName,
    required this.requestAmount,
    required this.exchangeRate,
    required this.conversionAmount,
    required this.totalCharge,
    required this.willGet,
    required this.payable,
  });

  factory PaymentInformation.fromJson(Map<String, dynamic> json) =>
      PaymentInformation(
        trx: json["trx"],
        gatewayCurrencyName: json["gateway_currency_name"],
        requestAmount: json["request_amount"],
        exchangeRate: json["exchange_rate"],
        conversionAmount: json["conversion_amount"],
        totalCharge: json["total_charge"],
        willGet: json["will_get"],
        payable: json["payable"],
      );

  Map<String, dynamic> toJson() => {
        "trx": trx,
        "gateway_currency_name": gatewayCurrencyName,
        "request_amount": requestAmount,
        "exchange_rate": exchangeRate,
        "conversion_amount": conversionAmount,
        "total_charge": totalCharge,
        "will_get": willGet,
        "payable": payable,
      };
}

class Message {
  final List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
