import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:get/get.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';
import 'package:vroar/resources/images.dart';

import 'common_widgets.dart';

class CommonMethods {
  static String version = "";
  static Future<bool> checkInternetConnectivity() async {
    //String connectionStatus;
    bool isConnected = await InternetConnectionChecker().hasConnection;
/*    final Connectivity _connectivity = Connectivity();

    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
      if (await _connectivity.checkConnectivity() ==
          ConnectivityResult.mobile) {
        print("===internetconnected==Mobile" + connectionStatus);
        isConnected = true;
        // I am connected to a mobile network.
      } else if (await _connectivity.checkConnectivity() ==
          ConnectivityResult.wifi) {
        isConnected = true;
        print("===internetconnected==wifi" + connectionStatus);
        // I am connected to a wifi network.
      } else if (await _connectivity.checkConnectivity() ==
          ConnectivityResult.none) {
        isConnected = false;
        print("===internetconnected==not" + connectionStatus);
      }
    } on PlatformException catch (e) {
      print("===internet==not connected" + e.toString());
      connectionStatus = 'Failed to get connectivity.';
    }*/
    return isConnected;
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  static void moveCursorToastPos(TextEditingController textField) {
    var cursorPos =
    TextSelection.fromPosition(TextPosition(offset: textField.text.length));
    textField.selection = cursorPos;
  }

  static void comingSoon(context,w){
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(24),
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.rocket_launch_outlined,
                size: 60,
                color: appColors.contentAccent,
              ),
              const SizedBox(height: 20),
              Text(
                "Coming Soon!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: appColors.contentAccent,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "This feature is on the way. Stay tuned!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 25),
              commonButton(w * 0.35, 50,
                  appColors.contentAccent, Colors.white,
                  hint: "Okay", () {
                    Get.back();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  static void showError({required String title, required String message,int time=3}) {
    Get.snackbar(
      '',
      '',
      titleText: Container(
        margin: const EdgeInsets.only(top:22.0),
        child: Center(
          child: Row(
            children: [
              SvgPicture.asset(appImages.errorIcon,width: 50,height: 50,fit: BoxFit.fill,),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:  TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: appFonts.NunitoMedium,
                      ),
                    ),
                    Text(
                      message,
                      style:  TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: appFonts.NunitoMedium,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: appColors.backgroundNegative,
      borderRadius: 12,
      margin: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 36.0),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      duration: Duration(seconds: time),
      animationDuration: const Duration(milliseconds: 700),
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInCubic,
    );
  }

  static void showToast(String message,{time=3}) {
    Get.showSnackbar(
      GetSnackBar(
        messageText: Row(
          children: [
            SvgPicture.asset(appImages.errorIcon,width: 30,height: 30,fit: BoxFit.fill,),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        isDismissible: true,
        snackStyle: SnackStyle.FLOATING,
        overlayColor: Colors.black54,
        snackPosition: SnackPosition.TOP,
        backgroundColor: appColors.backgroundNegative,
        borderRadius: 12,
        margin: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 36.0),
        duration:Duration(seconds: time),
        animationDuration: const Duration(milliseconds: 700),
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.easeInCubic,
      ),
    );
  }

  static void showToastSuccess(String message) {
    Get.showSnackbar(
      GetSnackBar(
        messageText: Row(
          children: [
            const Icon(Icons.check_circle_rounded,size: 23,color: Colors.white,),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        isDismissible: true,
        snackStyle: SnackStyle.FLOATING,
        overlayColor: Colors.black54,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        borderRadius: 12,
        margin: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 36.0),
        duration: const Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 700),
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.easeInCubic,
      ),
    );
  }

  static void showProgress() {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
      barrierDismissible: false,
      useSafeArea: true,
    );
  }

  static void inputFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  bool isConnect = false;

  // static void showToast(text,
  //     context,
  //     {fontSize = 16.0,
  //     length =const Duration(milliseconds: 1000),
  //     gravity = SnackPosition.BOTTOM,
  //     backColor = Colors.white,
  //     textColor = Colors.black,
  //     webBgColor = "#FFFFFF"
  //     }){
  //   Get.snackbar('Hello Shyam',text,
  //   snackPosition: SnackPosition.BOTTOM,
  //       showProgressIndicator: true,
  //       isDismissible: true,
  //       overlayBlur: 5,
  //       backgroundColor: Colors.pink,
  //       colorText: Colors.white,
  //       mainButton: TextButton(
  //           onPressed:(){
  //            Get.back();
  //           },
  //           child: const Text(
  //               "Close"
  //           )));
  //   // Fluttertoast.cancel();
  // }

  // static Future<String> createFileOfPdfUrl(link) async {
  //   String pathPDF = "";
  //   final url = link;
  //   final filename = url.substring(url.lastIndexOf("/") + 1);
  //   var request = await HttpClient().getUrl(Uri.parse(url));
  //   var response = await request.close();
  //   var bytes = await consolidateHttpClientResponseBytes(response);
  //   String dir = (await getApplicationDocumentsDirectory()).path;
  //   File file = new File('$dir/$filename');
  //   await file.writeAsBytes(bytes);
  //   pathPDF = file.path;
  //   return pathPDF;
  // }

  static void showImageInPopUp(BuildContext context, String imageUrl) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 100),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return SafeArea(
            child: Stack(
              children: [
                PhotoView(
                  imageProvider: NetworkImage(imageUrl),
                  minScale: 0.3,
                  maxScale: 50.0,
                ),
              ],
            ),
          );
        });
  }

// static void lanchOnBrowser(BuildContext context,String url)async
// {
//
//   if (await canLaunch(url)) {
// await launch(url);
// } else {
// throw 'Could not launch $url';
// }
// }

//   static void launchURL(BuildContext context,String url) async {
//
//     // await launch(url,
//     //             enableJavaScript: true,
//     //             enableDomStorage: true,
//     //             forceWebView: false,
//     //             universalLinksOnly: true,
//     //             webOnlyWindowName: '_top',
//     //             forceSafariVC: false);
//
//     // try {
//       // Intent().
//       //     .setAction(Action.ACTION_DEFINE)
//       //   ..putExtra(Extra.EXTRA_TEXT, "json")
//       //   ..startActivity().catchError((e) => print(e));
//
//
//
//      //  var intent =new Intent();
//      //  intent.
//      // Intent()
//      //    ..setAction(android_action.Action.ACTION_SHOW_APP_INFO)
//      //    ..putExtra(android_extra.Extra.EXTRA_PACKAGE_NAME, "com.whatsapp", type: android_typedExtra.TypedExtra.stringExtra)
//      //    ..startActivity().catchError((e) => print(e));
//
//
//
//
//     //   if (await canLaunch(url)) {
//     //
//     //
//     //     await launch(url,
//     //         enableJavaScript: true,
//     //         enableDomStorage: true,
//     //         forceWebView: false,
//     //         universalLinksOnly: true,
//     //         webOnlyWindowName: '_top',
//     //         forceSafariVC: true)
//     //     ;
//     //   } else {
//     //     throw 'Could not launch $url';
//     //   }
//     // }catch(e)
//     // {
//     //   print("Errors: "+e.toString());
//     // }
//    //  try {
//    //    await launch(
//    //      url,
//    //      customTabsOption: CustomTabsOption(
//    //        toolbarColor: Theme.of(context).primaryColor,
//    //        enableDefaultShare: true,
//    //        enableUrlBarHiding: true,
//    //        enableInstantApps: true,
//    //        showPageTitle: true,
//    //        // animation: CustomTabsAnimation.slideIn(),
//    //        // // or user defined animation.
//    //        // animation: const CustomTabsAnimation(
//    //        //   startEnter: 'slide_up',
//    //        //   startExit: 'android:anim/fade_out',
//    //        //   endEnter: 'android:anim/fade_in',
//    //        //   endExit: 'slide_down',
//    //        // ),
//    //        extraCustomTabs: const <String>[
//    //
//    //          // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
//    //          // 'org.mozilla.firefox',
//    //          // // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
//    //          // 'com.microsoft.emmx',
//    //        ],
//    //      ),
//    //      safariVCOption: SafariViewControllerOption(
//    //        preferredBarTintColor: Theme.of(context).primaryColor,
//    //        preferredControlTintColor: Colors.white,
//    //        barCollapsingEnabled: true,
//    //        entersReaderIfAvailable: false,
//    //        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
//    //      ),
//    //    );
//    //  } catch (e) {
//    //    // An exception is thrown if browser app is not installed on Android device.
//    //    debugPrint("Shyam Error "+e.toString());
//    //  }
//    // }
//
//   static void launchPopUpDailog(context) {
//     showDialog<void>(
//         context: context,
//         barrierDismissible:true,
//         builder: (BuildContext context) {
//           return CupertinoAlertDialog(
//             content: Column(
//               children: <Widget>[
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   child: Image.asset(appImages.warning, height: 44,width: 44,),
//                 ),
//                 // Text(Languages.of(context)!.importent,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
//                 Text(Languages.of(context)!.noGoodstorage,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
//               ],
//             ),
//             actions: <Widget>[ FlatButton(child: Text(Languages.of(context)!.ok),
//                 onPressed: (){Navigator.pop(context);})],
//           );
//         });
//
//   }
//
//
//
//
//
//
//
//
//

// static Future<String> createFileOfPdfUrl(link) async {
//   String pathPDF = "";
//   try {
//     final url = link;
//     final filename = url.substring(url.lastIndexOf("/") + 1);
//     var request = await HttpClient().getUrl(Uri.parse(url));
//     var response = await request.close();
//     var bytes = await consolidateHttpClientResponseBytes(response);
//     String dir = (await getApplicationDocumentsDirectory()).path;
//     File file = new File('$dir/$filename');
//     await file.writeAsBytes(bytes);
//     pathPDF = file.path;
//     return pathPDF;
//   }catch(e){
//     print("error ->>>>${e.toString()}");
//     return "Eror";
//   }
// }
}

