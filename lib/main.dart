// ignore_for_file: deprecated_member_use
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pusher_beams/pusher_beams.dart';
import 'package:qrpay/routes/routes.dart';

import 'backend/services/notification_service.dart';
import 'backend/utils/network_check/dependency_injection.dart';
import 'controller/app_settings/app_settings_controller.dart';
import 'language/language_controller.dart';
import 'utils/maintenance_dialog.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('themePreferences');
  // Load the certificate file
  ByteData data = await PlatformAssetBundle().load('assets/ca/isrgrootx1.pem');

  await ScreenUtil.ensureScreenSize();
  // Locking Device Orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  NotificationService.init();
  // check internet connection
  InternetCheckDependencyInjection.init();
  GetStorage.init();

  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  // main app
  runApp(const MyApp());
}

// This widget is the root of your application.
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    initPusherBeams();
    super.initState();
  }

  initPusherBeams() async {
    if (!kIsWeb) {
      await PusherBeams.instance.onInterestChanges(
          (interests) => {debugPrint('Interests: $interests')});

      await PusherBeams.instance
          .onMessageReceivedInTheForeground(_onMessageReceivedInTheForeground);
    }
    await _checkForInitialMessage();
  }

  Future<void> _checkForInitialMessage() async {
    final initialMessage = await PusherBeams.instance.getInitialMessage();
    if (initialMessage != null) {}
  }

  _onMessageReceivedInTheForeground(Map<Object?, Object?> data) {
    NotificationService.showLocalNotificationPusher(
      title: data["title"].toString(),
      body: data["body"].toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: Themes().theme,
        navigatorKey: Get.key,
        initialRoute: Routes.splashScreen,
        getPages: Routes.list,
        initialBinding: BindingsBuilder(
          () {
            Get.put(
              LanguageController(),
              permanent: true,
            );

            Get.put(
              AppSettingsController(),
              permanent: true,
            );
            Get.put(SystemMaintenanceController());
          },
        ),
        builder: (context, widget) {
          ScreenUtil.init(context);
          final languageController = Get.find<LanguageController>();

          return Obx(
            () => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: Directionality(
                textDirection: languageController.isLoading
                    ? TextDirection.ltr
                    : languageController.languageDirection,
                child: widget!,
              ),
            ),
          );
        },
      ),
    );
  }
}
