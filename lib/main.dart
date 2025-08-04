import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';
import 'package:vroar/resources/strings.dart';
import 'package:vroar/routes/routes_class.dart';

import 'common/push_notification_Service.dart';
import 'firebase_options.dart';
import 'modules/controller/authController_refreshToken.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await PushNotificationService().setupInteractedMessage();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.getToken().then((token) {
    print("Firebase Token: $token");
  }).catchError((error) {
    print("Token error: $error");
  });

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.dark));
    return GetMaterialApp(
      title: appStrings.myTreks,
      theme: ThemeData(
        fontFamily: appFonts.NunitoBold,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(surface: Colors.white, primary: Color(appColors.colorPrimaryNew), secondary: Colors.black),
        primaryColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
      ),
      debugShowCheckedModeBanner: false,
      getPages: RoutesClass.routes,
      initialRoute: RoutesClass.splashScreen,
    );
  }
}

abstract class ParentWidget extends StatelessWidget {
  const ParentWidget({super.key});
  Widget buildingView(BuildContext context, double h, double w);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        // showDialog(
        //     context: context,
        //     barrierDismissible: false,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         title: Text(appStrings.confirmExit,style: TextStyle(fontSize: 20,color: Color(appColors.black))),
        //         content: Text(appStrings.areYouSure,style: TextStyle(fontSize: 16,color: Color(appColors.black))),
        //         actions: [
        //           TextButton(
        //             onPressed: (){
        //               SystemNavigator.pop();
        //             },
        //             style: TextButton.styleFrom(
        //                 backgroundColor: Color(appColors.appColorRed),
        //                 shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(5)
        //                 )
        //             ),
        //             child: SizedBox(
        //                 width: w * 0.2,
        //                 child: Center(child: Text(appStrings.yes,style: TextStyle(fontSize: 16,color: Colors.white)))),
        //           ),
        //           SizedBox(),
        //           TextButton(
        //             onPressed: (){
        //               Navigator.of(context).pop();
        //             },
        //             style: TextButton.styleFrom(
        //                 backgroundColor: Color(appColors.black),
        //                 shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(5)
        //                 )
        //             ),
        //             child: SizedBox(
        //                 width: w * 0.2,
        //                 child: Center(child: Text(appStrings.no,style: TextStyle(fontSize: 16,color: Colors.white)))),
        //           )
        //         ],
        //       );
        //     });
        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: buildingView(context, h, w),
      ),
    );
  }
// Future<void> getToken() async {
//   var fcmToken = await FirebaseMessaging.instance.getToken();
//   print('fcm is ' + fcmToken!);
// }
}
