import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/constants.dart';

const String idKey = "idKey";

const String nameKey = "nameKey";

const String tokenKey = "tokenKey";

const String emailKey = "emailKey";

const String imageKey = "imageKey";

const String countryCode = "countryCode";
const String country = "country";

const String showAdKey = "showAdKey";
const String splashImgKey = "splashImgKey";
const String isLoggedInKey = "isLoggedInKey";

const String isDataLoadedKey = "isDataLoadedKey";

const String isOnBoardDoneKey = "isOnBoardDoneKey";

const String isScheduleEmptyKey = "isScheduleEmptyKey";

const String language = "language";

const String smallLanguage = "smallLanguage";

const String capitalLanguage = "capitalLanguage";

const String isEmailVerificationKey = "isEmailVerificationKey";

const String isKycVerificationKey = "isKycVerificationKey";
const String isPusherAuthenticationKey = "isPusherAuthenticationKey";
const String pusherInstanceIdKey = "pusherInstanceIdKey";

const String isSmsVerificationKey = "isSmsVerificationKey";
class LocalStorage {
  static Future<void> savePusherInstanceId({required String key}) async {
    final box = GetStorage();
    await box.write(pusherInstanceIdKey, key);
  }

  static String getPusherInstanceId() {
    return GetStorage().read(pusherInstanceIdKey) ?? "";
  }
  static Future<void> saveSmsVerification(
      {required bool isSmsVerification}) async {
    final box = GetStorage();

    await box.write(isSmsVerificationKey, isSmsVerification);
    debugPrint(isSmsVerification.toString());
  }
  static Future<void> savePusherAuthenticationKey(
      {required bool pusherAuthenticationKey}) async {
    final box = GetStorage();

    await box.write(isPusherAuthenticationKey, pusherAuthenticationKey);
  }

  static bool isPusherAuthentication() {
    return GetStorage().read(isPusherAuthenticationKey) ?? false;
  }

  static Future<void> saveEmailVerification(
      {required bool isEmailVerification}) async {
    final box = GetStorage();

    await box.write(isEmailVerificationKey, isEmailVerification);
    debugPrint(isEmailVerification.toString());
  }

  static Future<void> saveKycVerification(
      {required bool isKycVerification}) async {
    final box = GetStorage();

    await box.write(isKycVerificationKey, isKycVerification);
    debugPrint(isKycVerification.toString());
  }

  static Future<void> saveSplashImage({required String image}) async {
    final box = GetStorage();

    await box.write(splashImgKey, image);
  }

  static String getSplashImage() {
    return GetStorage().read(splashImgKey);
  }

  static Future<void> saveId({required String id}) async {
    final box = GetStorage();

    await box.write(idKey, id);
  }

  static Future<void> saveName({required String name}) async {
    final box = GetStorage();

    await box.write(nameKey, name);
  }

  static Future<void> saveEmail({required String email}) async {
    final box = GetStorage();

    await box.write(emailKey, email);
  }

  static Future<void> saveFiatPrecision({required int value}) async {
    final box = GetStorage();
    await box.write('FiatPrecision', value);
  }

  static int getFiatPrecision() {
    return GetStorage().read('FiatPrecision') ?? 0;
  }

  static Future<void> saveCryptoPrecision({required int value}) async {
    final box = GetStorage();
    await box.write('CryptoPrecision', value);
  }

  static int getCryptoPrecision() {
    return GetStorage().read('CryptoPrecision') ?? 0;
  }

  static Future<void> saveToken({required String token}) async {
    final box = GetStorage();

    await box.write(tokenKey, token);
  }

  static Future<void> saveCountryCode(
      {required String countryCodeValue}) async {
    final box = GetStorage();

    await box.write(countryCode, countryCodeValue);
  }

  static Future<void> saveCountry({required String countryValue}) async {
    final box = GetStorage();

    await box.write(country, countryValue);
  }

  static Future<void> saveImage({required String image}) async {
    final box = GetStorage();

    await box.write(imageKey, image);
  }

  static Future<void> isLoginSuccess({required bool isLoggedIn}) async {
    final box = GetStorage();

    await box.write(isLoggedInKey, isLoggedIn);
  }

  static Future<void> dataLoaded({required bool isDataLoad}) async {
    final box = GetStorage();

    await box.write(isDataLoadedKey, isDataLoad);
  }

  static Future<void> scheduleEmpty({required bool isScheduleEmpty}) async {
    final box = GetStorage();

    await box.write(isScheduleEmptyKey, isScheduleEmpty);
  }

  static Future<void> showAdYes({required bool isShowAdYes}) async {
    final box = GetStorage();

    await box.write(showAdKey, isShowAdYes);
  }

  static Future<void> saveOnboardDoneOrNot(
      {required bool isOnBoardDone}) async {
    final box = GetStorage();

    await box.write(isOnBoardDoneKey, isOnBoardDone);
  }

  static Future<void> saveLanguage({
    required String langSmall,
    required String langCap,
    required String languageName,
  }) async {
    final box1 = GetStorage();
    final box2 = GetStorage();
    final box3 = GetStorage();
    languageStateName = languageName;
    var locale = Locale(langSmall, langCap);
    Get.updateLocale(locale);
    await box1.write(smallLanguage, langSmall);
    await box2.write(capitalLanguage, langCap);
    await box3.write(language, languageName);
  }

  static List getLanguage() {
    String small = GetStorage().read(smallLanguage) ?? 'en';
    String capital = GetStorage().read(capitalLanguage) ?? 'EN';
    String languages = GetStorage().read(language) ?? 'English';
    return [small, capital, languages];
  }

  static Future<void> changeLanguage() async {
    final box = GetStorage();
    await box.remove(language);
  }

  static String? getId() {
    return GetStorage().read(idKey);
  }

  static String? getName() {
    return GetStorage().read(nameKey);
  }

  static String? getEmail() {
    return GetStorage().read(emailKey);
  }

  static String? getToken() {
    var rtrn = GetStorage().read(tokenKey);

    debugPrint(rtrn == null ? "##Token is null###" : "");

    return rtrn;
  }

  static String? getCountryCode() {
    var rtrn = GetStorage().read(countryCode);

    debugPrint(rtrn == null ? "##Country Code is null###" : "");

    return rtrn ?? "234";
  }

  static String? getCountry() {
    var rtrn = GetStorage().read(country);

    debugPrint(rtrn == null ? "##Country is null###" : "");

    return rtrn ?? "";
  }

  static String? getImage() {
    return GetStorage().read(imageKey);
  }
  static bool isSmsVerification() {
    return GetStorage().read(isSmsVerificationKey) ?? false;
  }
  static bool isLoggedIn() {
    return GetStorage().read(isLoggedInKey) ?? false;
  }

  static bool isEmailVerification() {
    return GetStorage().read(isEmailVerificationKey) ?? false;
  }

  static bool isKycVerification() {
    return GetStorage().read(isKycVerificationKey) ?? false;
  }

  static bool isDataLoaded() {
    return GetStorage().read(isDataLoadedKey) ?? false;
  }

  static bool isScheduleEmpty() {
    return GetStorage().read(isScheduleEmptyKey) ?? false;
  }

  static bool isOnBoardDone() {
    return GetStorage().read(isOnBoardDoneKey) ?? false;
  }

  static bool showAdPermission() {
    return GetStorage().read(showAdKey) ?? true;
  }

  static Future<void> saveRtl({required bool type}) async {
    final box = GetStorage();
    await box.write('RTL', type);
  }

  static Future<void> logout() async {
    final box = GetStorage();

    await box.remove(idKey);

    await box.remove(nameKey);

    await box.remove(emailKey);

    await box.remove(imageKey);

    await box.remove(isLoggedInKey);

    await box.remove(tokenKey);

    await box.remove(isOnBoardDoneKey);
  }
}
