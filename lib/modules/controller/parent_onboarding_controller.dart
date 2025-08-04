import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vroar/data/app_url/app_base_url.dart';
import 'package:vroar/data/app_url/app_url.dart';
import 'package:vroar/resources/images.dart';
import 'package:vroar/resources/strings.dart';

import '../../common/constants.dart';
import '../../routes/routes_class.dart';
import '../../utils/utils.dart';

class ParentOnBoardingController extends GetxController {
  var role = "".obs;
  var currentIndex = 0.obs;

  final RxList<dynamic> images = [
    appImages.firstParentOnBoardingImage,
    appImages.secondParentOnBoardingImage,
    appImages.thirdParentOnBoardingImage,
    appImages.fourthParentOnBoardingImage,
    appImages.fifthParentOnBoardingImage,
  ].obs;

  final RxList<String> titles = [appStrings.discoverTheirStrengths, appStrings.keepTrack, appStrings.learningMakeFun, appStrings.inspireTheirFuture, appStrings.supportTheirDreams].obs;

  final RxList<String> subtitles = [appStrings.empowerParent, appStrings.helpYourChild, appStrings.engageYourChild, appStrings.connectYourChild, appStrings.equipYourChild].obs;

  final RxList<Tween<Offset>> offsetList = [
    Tween<Offset>(begin: const Offset(0.1, 0), end: const Offset(0, 0.0)),
    Tween<Offset>(begin: const Offset(0.1, 0), end: const Offset(0, 0.0)),
    Tween<Offset>(begin: const Offset(-0.1, 0), end: const Offset(0, 0.0)),
    Tween<Offset>(begin: const Offset(0, 0.1), end: const Offset(0, 0.0)),
    Tween<Offset>(begin: const Offset(0, 0.1), end: const Offset(0, 0.0)),
  ].obs;

  final RxList<Tween<Offset>> offsetListForImage = [
    Tween<Offset>(begin: const Offset(0.0, 0), end: const Offset(0, 0.0)),
    Tween<Offset>(begin: const Offset(0.0, 0.1), end: const Offset(0, 0.0)),
    Tween<Offset>(begin: const Offset(0.0, 0.1), end: const Offset(0, 0.0)),
    Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0, 0.0)),
    Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0, 0.0)),
    // Tween<Offset>(begin: const Offset(-0.00, 0.08), end: const Offset(0.0, -0.0098)),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  void updateIndex(int newIndex) {
    if (newIndex < 5) {
      currentIndex.value = newIndex;
    } else {
      // Get.toNamed(RoutesClass.parentSignUpScreen, arguments: "PARENT");
      var websiteUrl = AppUrl.baseUrl == AppBaseUrl.baseUrlMyTreksDev
          ? 'https://dev.accounts.mytreks.ai/login'
          : AppUrl.baseUrl == AppBaseUrl.baseUrlMyTreksUAT
              ? 'https://uat.accounts.mytreks.ai/login'
              : 'https://accounts.mytreks.ai/login';
      final uri = Uri.parse(websiteUrl);
      launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    }
    Utils.printLog("Current Index: $currentIndex");
  }

  void initialize() async {
    String? roleValue = await Utils.getPreferenceValues(Constants.role);
    role.value = roleValue ?? ""; // Set to an empty string if null
    Utils.printLog("Role: ${role.value}");

    String? accessToken = await Utils.getPreferenceValues(Constants.accessToken);
    Utils.printLog("Access Token: $accessToken");

    if (accessToken != null) {
      if (role.value.isEmpty) {
        Utils.printLog("Navigating to Create Profile Screen");
      } else {
        Utils.printLog("Navigating to Common Screen");
        Get.offAllNamed(RoutesClass.gotoCommonScreen());
      }
    } else {
      Utils.printLog("Access token is null, staying on splash screen or navigating to login.");
    }
  }
}
