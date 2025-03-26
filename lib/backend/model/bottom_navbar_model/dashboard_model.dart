import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) =>
    DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  final Message message;
  final Data data;

  DashboardModel({
    required this.message,
    required this.data,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
      };
}

class Data {
  final PusherCredentials pusherCredentials;
  final String baseCurr;
  List<AgentWallet> agentWallet;
  final String baseUrl;
  final String defaultImage;
  final String imagePath;
  final ModuleAccess moduleAccess;
  final Agent agent;
  final String totalAddMoney;
  final String totalWithdrawMoney;
  final String totalSendMoney;
  final String totalMoneyIn;
  final String totalReceiveMoney;
  final String totalSendRemittance;
  final String billPay;
  final String topUps;
  final int totalTransaction;
  final String agentProfits;
  final List<Transaction> transactions;

  Data({
    required this.pusherCredentials,
    required this.baseCurr,
    required this.agentWallet,
    required this.baseUrl,
    required this.defaultImage,
    required this.imagePath,
    required this.moduleAccess,
    required this.agent,
    required this.totalAddMoney,
    required this.totalWithdrawMoney,
    required this.totalSendMoney,
    required this.totalMoneyIn,
    required this.totalReceiveMoney,
    required this.totalSendRemittance,
    required this.billPay,
    required this.topUps,
    required this.totalTransaction,
    required this.agentProfits,
    required this.transactions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pusherCredentials:
            PusherCredentials.fromJson(json["pusher_credentials"]),
        baseCurr: json["base_curr"],
        agentWallet: List<AgentWallet>.from(
            json["userWallets"].map((x) => AgentWallet.fromJson(x))),
        baseUrl: json["base_url"],
        defaultImage: json["default_image"],
        imagePath: json["image_path"],
        moduleAccess: ModuleAccess.fromJson(json["module_access"]),
        agent: Agent.fromJson(json["agent"]),
        totalAddMoney: json["totalAddMoney"],
        totalWithdrawMoney: json["totalWithdrawMoney"],
        totalSendMoney: json["totalSendMoney"],
        totalMoneyIn: json["totalMoneyIn"],
        totalReceiveMoney: json["totalReceiveMoney"],
        totalSendRemittance: json["totalSendRemittance"],
        billPay: json["billPay"],
        topUps: json["topUps"],
        totalTransaction: json["total_transaction"],
        agentProfits: json["agent_profits"],
        transactions: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
      );
}

class Agent {
  final int id;
  final String firstname;
  final String lastname;
  final String username;
  final String storeName;
  final String email;
  final String mobileCode;
  final String mobile;
  final String fullMobile;
  final dynamic refferalUserId;
  final dynamic image;
  final int status;
  final Address address;
  final int emailVerified;
  final int smsVerified;
  final int kycVerified;
  final dynamic verCode;
  final dynamic verCodeSendAt;
  final int twoFactorVerified;
  final int twoFactorStatus;
  final dynamic twoFactorSecret;
  final dynamic deviceId;
  final dynamic emailVerifiedAt;
  final dynamic deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String fullname;
  final String agentImage;
  final StringStatus stringStatus;
  final String lastLogin;
  final StringStatus kycStringStatus;

  Agent({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.storeName,
    required this.email,
    required this.mobileCode,
    required this.mobile,
    required this.fullMobile,
    required this.refferalUserId,
    required this.image,
    required this.status,
    required this.address,
    required this.emailVerified,
    required this.smsVerified,
    required this.kycVerified,
    required this.verCode,
    required this.verCodeSendAt,
    required this.twoFactorVerified,
    required this.twoFactorStatus,
    required this.twoFactorSecret,
    required this.deviceId,
    required this.emailVerifiedAt,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.fullname,
    required this.agentImage,
    required this.stringStatus,
    required this.lastLogin,
    required this.kycStringStatus,
  });

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        storeName: json["store_name"],
        email: json["email"],
        mobileCode: json["mobile_code"],
        mobile: json["mobile"],
        fullMobile: json["full_mobile"],
        refferalUserId: json["refferal_user_id"],
        image: json["image"],
        status: json["status"],
        address: Address.fromJson(json["address"]),
        emailVerified: json["email_verified"],
        smsVerified: json["sms_verified"],
        kycVerified: json["kyc_verified"],
        verCode: json["ver_code"],
        verCodeSendAt: json["ver_code_send_at"],
        twoFactorVerified: json["two_factor_verified"],
        twoFactorStatus: json["two_factor_status"],
        twoFactorSecret: json["two_factor_secret"],
        deviceId: json["device_id"],
        emailVerifiedAt: json["email_verified_at"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        fullname: json["fullname"],
        agentImage: json["agentImage"],
        stringStatus: StringStatus.fromJson(json["stringStatus"]),
        lastLogin: json["lastLogin"],
        kycStringStatus: StringStatus.fromJson(json["kycStringStatus"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "store_name": storeName,
        "email": email,
        "mobile_code": mobileCode,
        "mobile": mobile,
        "full_mobile": fullMobile,
        "refferal_user_id": refferalUserId,
        "image": image,
        "status": status,
        "address": address.toJson(),
        "email_verified": emailVerified,
        "sms_verified": smsVerified,
        "kyc_verified": kycVerified,
        "ver_code": verCode,
        "ver_code_send_at": verCodeSendAt,
        "two_factor_verified": twoFactorVerified,
        "two_factor_status": twoFactorStatus,
        "two_factor_secret": twoFactorSecret,
        "device_id": deviceId,
        "email_verified_at": emailVerifiedAt,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "fullname": fullname,
        "agentImage": agentImage,
        "stringStatus": stringStatus.toJson(),
        "lastLogin": lastLogin,
        "kycStringStatus": kycStringStatus.toJson(),
      };
}

class Address {
  final String country;
  final String city;
  final String zip;
  final String state;
  final String address;

  Address({
    required this.country,
    required this.city,
    required this.zip,
    required this.state,
    required this.address,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        country: json["country"],
        city: json["city"],
        zip: json["zip"],
        state: json["state"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "city": city,
        "zip": zip,
        "state": state,
        "address": address,
      };
}

class StringStatus {
  final String stringStatusClass;
  final String value;

  StringStatus({
    required this.stringStatusClass,
    required this.value,
  });

  factory StringStatus.fromJson(Map<String, dynamic> json) => StringStatus(
        stringStatusClass: json["class"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "class": stringStatusClass,
        "value": value,
      };
}

class AgentWallet {
  final dynamic balance;
  final Currency currency;

  AgentWallet({
    required this.balance,
    required this.currency,
  });

  factory AgentWallet.fromJson(Map<String, dynamic> json) => AgentWallet(
        balance: json["balance"],
        currency: Currency.fromJson(json["currency"]),
      );
}

class Currency {
  final int id;
  final dynamic code;
  final dynamic rate;
  final dynamic flag;
  final dynamic symbol;
  final dynamic type;
  final dynamic currencyDefault;
  final dynamic country;
  final bool both;
  final bool senderCurrency;
  final bool receiverCurrency;
  final dynamic editData;
  final dynamic currencyImage;

  Currency({
    required this.id,
    required this.code,
    required this.rate,
    required this.flag,
    required this.symbol,
    required this.type,
    required this.currencyDefault,
    required this.country,
    required this.both,
    required this.senderCurrency,
    required this.receiverCurrency,
    required this.editData,
    required this.currencyImage,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"],
        code: json["code"],
        rate: json["rate"],
        flag: json["flag"],
        symbol: json["symbol"],
        type: json["type"],
        currencyDefault: json["default"],
        country: json["country"],
        both: json["both"],
        senderCurrency: json["senderCurrency"],
        receiverCurrency: json["receiverCurrency"],
        editData: json["editData"],
        currencyImage: json["currencyImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "rate": rate,
        "flag": flag,
        "symbol": symbol,
        "type": type,
        "default": currencyDefault,
        "country": country,
        "both": both,
        "senderCurrency": senderCurrency,
        "receiverCurrency": receiverCurrency,
        "editData": editData,
        "currencyImage": currencyImage,
      };
}

class ModuleAccess {
  final bool receiveMoney;
  final bool addMoney;
  final bool withdrawMoney;
  final bool transferMoney;
  final bool moneyIn;
  final bool billPay;
  final bool mobileTopUp;
  final bool remittanceMoney;

  ModuleAccess({
    required this.receiveMoney,
    required this.addMoney,
    required this.withdrawMoney,
    required this.transferMoney,
    required this.moneyIn,
    required this.billPay,
    required this.mobileTopUp,
    required this.remittanceMoney,
  });

  factory ModuleAccess.fromJson(Map<String, dynamic> json) => ModuleAccess(
        receiveMoney: json["receive_money"],
        addMoney: json["add_money"],
        withdrawMoney: json["withdraw_money"],
        transferMoney: json["transfer_money"],
        moneyIn: json["money_in"],
        billPay: json["bill_pay"],
        mobileTopUp: json["mobile_top_up"],
        remittanceMoney: json["remittance_money"],
      );

  Map<String, dynamic> toJson() => {
        "receive_money": receiveMoney,
        "add_money": addMoney,
        "withdraw_money": withdrawMoney,
        "transfer_money": transferMoney,
        "money_in": moneyIn,
        "bill_pay": billPay,
        "mobile_top_up": mobileTopUp,
        "remittance_money": remittanceMoney,
      };
}

class Transaction {
  final int id;
  final String type;
  final String trx;
  final String transactionType;
  final String requestAmount;
  final String payable;
  final String status;
  final String remark;
  final DateTime dateTime;

  Transaction({
    required this.id,
    required this.type,
    required this.trx,
    required this.transactionType,
    required this.requestAmount,
    required this.payable,
    required this.status,
    required this.remark,
    required this.dateTime,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        type: json["type"],
        trx: json["trx"],
        transactionType: json["transaction_type"],
        requestAmount: json["request_amount"],
        payable: json["payable"],
        status: json["status"],
        remark: json["remark"],
        dateTime: DateTime.parse(json["date_time"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "trx": trx,
        "transaction_type": transactionType,
        "request_amount": requestAmount,
        "payable": payable,
        "status": status,
        "remark": remark,
        "date_time": dateTime.toIso8601String(),
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

class PusherCredentials {
  final String instanceId;
  final String secretKey;

  PusherCredentials({
    required this.instanceId,
    required this.secretKey,
  });

  factory PusherCredentials.fromJson(Map<String, dynamic> json) =>
      PusherCredentials(
        instanceId: json["instanceId"],
        secretKey: json["secretKey"],
      );

  Map<String, dynamic> toJson() => {
        "instanceId": instanceId,
        "secretKey": secretKey,
      };
}
