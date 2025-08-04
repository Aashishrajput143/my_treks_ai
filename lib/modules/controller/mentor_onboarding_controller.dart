
import 'package:get/get.dart';
import 'package:vroar/resources/images.dart';
import 'package:vroar/resources/strings.dart';

import '../../common/constants.dart';
import '../../routes/routes_class.dart';
import '../../utils/utils.dart';

class MentorOnBoardingController extends GetxController {
  var role = "".obs;
  var currentIndex = 0.obs;

  final RxList<dynamic> images = [
    appImages.firstMentorOnBoardingImage,
    appImages.thirdParentOnBoardingImage,
    appImages.fourthParentOnBoardingImage,
  ].obs;

  final RxList<String> titles = [
    appStrings.welcomeTo,
    appStrings.helpStudentGrow,
    appStrings.celebrateTheirSuccess,
  ].obs;

  final RxList<String> subtitles = [
    appStrings.joinCommunity,
    appStrings.guideStudent,
    appStrings.monitorDevelopment,
  ].obs;

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  void updateIndex(int newIndex) {
    if(newIndex<3) {
      currentIndex.value = newIndex;
    }else{
      Get.toNamed(RoutesClass.mentorSignUpScreen,arguments: "MENTOR");
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

