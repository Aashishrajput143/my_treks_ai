import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/resources/images.dart';
import 'package:vroar/resources/strings.dart';

import '../../common/constants.dart';
import '../../routes/routes_class.dart';
import '../../utils/utils.dart';

class StudentOnBoardingController extends GetxController {
  var role = "".obs;
  var currentIndex = 0.obs;

  final RxList<dynamic> images = [
    appImages.firstStudentOnBoardingImage,
    appImages.secondStudentOnBoardingImage,
    appImages.fourthOnBoardingImage,
    appImages.fourthStudentOnBoardingImage,
    appImages.secondOnBoardingImage,
  ].obs;

  final RxList<String> titles = [appStrings.discoverTheirStrengths, appStrings.stayTrack, appStrings.learnThrough, appStrings.meetIndustry, appStrings.craftStory].obs;

  final RxList<String> subtitles = [appStrings.unlockPotential, appStrings.getExpert, appStrings.experiencePersonalized, appStrings.gainReal, appStrings.learnHow].obs;

  final RxList<Tween<Offset>> offsetList = [
    Tween<Offset>(begin: const Offset(0.1, 0), end: const Offset(0, 0.0)),
    Tween<Offset>(begin: const Offset(0.1, 0), end: const Offset(0, 0.0)),
    Tween<Offset>(begin: const Offset(-0.1, 0), end: const Offset(0, 0.0)),
    Tween<Offset>(begin: const Offset(-0.1, 0), end: const Offset(0, 0.0)),
    Tween<Offset>(begin: const Offset(-0.1, 0), end: const Offset(0, 0.0)),
    // Tween<Offset>(begin: const Offset(0, 0.2), end: const Offset(0, 0.0)),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> updateIndex(int newIndex) async {
    String? isSocialLogin = await Utils.getPreferenceValues(Constants.isSocialLogin);
    if (newIndex < 5) {
      currentIndex.value = newIndex;
    } else {
      if(isSocialLogin?.isNotEmpty??false){
        Get.toNamed(
          RoutesClass.signUpDetails,
          arguments: {
            'role': "STUDENT",
            'emailId': "",
          },
        );
      }else{
        Get.toNamed(RoutesClass.studentSignUpScreen, arguments: "STUDENT");
      }
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
        //Get.offAllNamed(RoutesClass.gotoCommonScreen());
      }
    } else {
      Utils.printLog("Access token is null, staying on splash screen or navigating to login.");
    }
  }
}
