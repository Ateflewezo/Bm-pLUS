import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/ui/tooles/currency.dart';
import 'package:telephony/telephony.dart';
import 'control/services/locator.dart';
import 'ui/annimation/custom_animation.dart';
import 'ui/tooles/roots.dart';
import 'ui/tooles/theme_app.dart' as Theme;

void main() async {
//    DevicePreview(
//     enabled: !kReleaseMode,
//     builder: (context) => MyApp2(), // Wrap your app
//   ),
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
// FirebaseFirestore.instance.enablePersistence();
  setuplocator_user();
  configLoading();
  // runApp(EasyLocalization(
  //   path: "res/lang",
  //   supportedLocales: [
  //     const Locale('en', 'US'), // English
  //     const Locale('ar', 'SA'), // Arabic
  //   ],
  //   saveLocale: true,
  //   child: MyApp(),
  // ));

  runApp(DevicePreview(
      enabled: false,
      builder: (context) {
        // return MyApp2();
        return EasyLocalization(
          path: "res/lang",
          supportedLocales: [
            const Locale('en', 'US'), // English
            const Locale('ar', 'SA'), // Arabic
          ],
          saveLocale: true,
          child: MyApp(),
        );
      }));

//   // SyncfusionLicense.registerLicense(null);
//   // return runApp(ChartApp());
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale locale;

  @override
  Widget build(BuildContext context) {
    // var data=EasyLocalizationProvider.of(context).data;

    return ChangeNotifierProvider<Operation_provider>(
        create: (context) => Operation_provider(),
        child: ScreenUtilInit(
          designSize: Size(750, 1334),
          allowFontScaling: false,
          child: MaterialApp(
            theme: Theme.ThemeApp,
            debugShowCheckedModeBanner: false,
            // locale: DevicePreview.locale(context), // Add the locale here
            // builder: DevicePreview.appBuilder, // Add the builder here

            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,

            onGenerateRoute: CustomRouts.allRouts,
            initialRoute: "/splash", //"/operation_details/:id",
            builder: EasyLoading.init(),
          ),
        ));
  }
}

////sms
onBackgroundMessage(SmsMessage message) {
  debugPrint("onBackgroundMessage called");
}
