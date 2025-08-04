import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vroar/common/roadmap_common_widgets/pdf_viwer.dart';
import 'package:vroar/models/refresh_token_model.dart';
import 'package:vroar/modules/repository/login_repository.dart';
import 'package:vroar/modules/screen/roadmap/onboarding_roadmap_screen.dart';

import '../../common/Constants.dart';
import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../models/get_profile_model.dart';
import '../../utils/utils.dart';
import '../repository/profile_repository.dart';
import '../screen/courses.dart';
import '../screen/internship_details.dart';
import '../screen/internship_list.dart';
import '../screen/mentor_schedule.dart';
import '../screen/need_assistance.dart';
import '../screen/parent_roadmap.dart';
import '../screen/roadmap/roadmap_screen.dart';
import '../screen/roadmap/roadmap_showcase.dart';
import '../screen/session_details.dart';
import '../../resources/colors.dart';
import '../../resources/images.dart';
import '../../resources/strings.dart';
import '../screen/book_session.dart';
import '../screen/change_password.dart';
import '../screen/coins_review.dart';
import '../screen/edit_profile.dart';
import '../screen/home_screen.dart';
import '../screen/mentor_details.dart';
import '../screen/message_chat.dart';
import '../screen/parent_home_screen.dart';
import '../screen/profile_details.dart';
import '../screen/roadmap/write_assignment.dart';
import 'edit_profile_controller.dart';

class CommonScreenController extends GetxController {
  var selectedIndex = 0.obs;
  var arguments = Get.arguments;
  var role = "STUDENT".obs;
  var isBackOnIndex = 0.obs;
  final profileApi = ProfileRepository();
  final loginApi = LoginRepository();
  @override
  void onInit() {
    super.onInit();
    getProfileApi();
    // role.value=arguments??"STUDENT";
  }

  int changeIndex() {
    if (selectedIndex.value <= 4) {
      return selectedIndex.value;
    } else if (selectedIndex.value == 8 || selectedIndex.value == 9 || (isBackOnIndex.value == 4 && selectedIndex.value == 5)) {
      return 4;
    } else if (selectedIndex.value == 12) {
      return 3;
    } else if (selectedIndex.value == 15 || selectedIndex.value == 16 || selectedIndex.value == 17) {
      return 1;
    } else {
      return 0;
    }
  }

  final List<Widget> pages = [
    const HomeScreen(), //index=0
    const RoadmapShowcase(), //index=1
    const CoinsReviewScreen(), //index=2
    const CoursesScreen(), //index=3
    const ProfileDetailsScreen(), //index=4
    const NeedAssistanceScreen(), //index=5
    const SessionDetailsScreen(), //index=6
    const MentorScheduleScreen(), //index=7
    const EditProfileScreen(), //index=8
    const ChangePasswordScreen(), //index=9
    const MentorDetailsScreen(), //index=10
    const BookSessionScreen(), //index=11
    const MessageChatScreen(), //index=12
    const InternshipListScreen(), //index=13
    const InternshipDetailsScreen(), //index=14
    const PDFScreen(), //index=15
    const OnBoardingRoadmapScreen(), //index=16
    const WriteAssignmentScreen(), //index=17
  ];

  List<BottomNavigationBarItem> bottomNavigationItems = [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(appImages.homeSvg, height: 24, width: 24),
      label: appStrings.home,
      activeIcon: SvgPicture.asset(appImages.homeSvgActive, height: 24, width: 24),
    ),
    BottomNavigationBarItem(icon: Image.asset(appImages.roadMap, height: 24, width: 24), label: appStrings.roadMap, activeIcon: Image.asset(appImages.roadMap, height: 24, width: 24, color: appColors.contentAccent)),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(appImages.coinSvg, height: 24, width: 24),
      label: appStrings.coins,
      activeIcon: SvgPicture.asset(appImages.coinSvgActive, height: 24, width: 24),
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(appImages.coursesSvg, height: 24, width: 24),
      label: appStrings.courses,
      activeIcon: SvgPicture.asset(appImages.coursesSvgActive, height: 24, width: 24),
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(appImages.profileSvg, height: 24, width: 24),
      label: appStrings.profile,
      activeIcon: SvgPicture.asset(appImages.profileSvgActive, height: 24, width: 24),
    ),
  ];

  int changeParentIndex() {
    if (selectedIndex.value <= 2) {
      return selectedIndex.value;
    } else if (selectedIndex.value == 4 || selectedIndex.value == 5) {
      return 2;
    } else if (isBackOnIndex.value == 2 || selectedIndex.value == 5) {
      return 2;
    } else {
      return 0;
    }
  }

  final List<Widget> parentPages = [
    const ParentHomeScreen(), //index=0
    const ParentRoadmapScreen(), //index=1
    const ProfileDetailsScreen(), //index=2
    const NeedAssistanceScreen(), //index=3
    const EditProfileScreen(), //index=4
    const ChangePasswordScreen(), //index=5
  ];

  List<BottomNavigationBarItem> parentBottomNavigationItems = [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(appImages.homeSvg, height: 24, width: 24),
      label: appStrings.home,
      activeIcon: SvgPicture.asset(appImages.homeSvgActive, height: 24, width: 24),
    ),
    BottomNavigationBarItem(
      icon: Image.asset(appImages.roadMap, height: 24, width: 24),
      label: appStrings.roadMap,
      activeIcon: Image.asset(appImages.roadMap, height: 24, width: 24, color: appColors.contentAccent),
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(appImages.profileSvg, height: 24, width: 24),
      label: appStrings.profile,
      activeIcon: SvgPicture.asset(appImages.profileSvgActive, height: 24, width: 24),
    ),
  ];

  final rxRequestStatus = Status.COMPLETED.obs;
  final getProfileData = GetProfileModel().obs;
  final getRefreshTokenData = RefreshTokenModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setGetProfileData(GetProfileModel value) => getProfileData.value = value;
  void setGetRefreshTokenData(RefreshTokenModel value) => getRefreshTokenData.value = value;

  Future<void> getProfileApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      profileApi.getProfile().then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setGetProfileData(value);
        Utils.savePreferenceValues(Constants.userId, value.data?.id ?? "");
        Utils.savePreferenceValues(Constants.firstName, value.data?.firstName ?? "");
        Utils.savePreferenceValues(Constants.avatar, value.data?.avatar ?? "");
        //CommonMethods.showToastSuccess("${value.message}");
        Utils.savePreferenceValues(Constants.refreshLogin, "");
        Utils.printLog("Response===> ${value.toString()}");
        // EditProfileController editController = Get.put(EditProfileController());
        // editController.setData();
      }).onError((error, stackTrace) {
        setError(error.toString());
        setRxRequestStatus(Status.ERROR);
        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          print("errrrorrr=====>$errorResponse");
          if (errorResponse is Map || errorResponse.containsKey('message')) {
            CommonMethods.showToast(errorResponse['message']);
          } else {
            CommonMethods.showToast("An unexpected error occurred.");
          }
        }
        Utils.printLog("Error===> ${error.toString()}");
        Utils.printLog("stackTrace===> ${stackTrace.toString()}");
      });
    } else {
      setRxRequestStatus(Status.NOINTERNET);
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}
