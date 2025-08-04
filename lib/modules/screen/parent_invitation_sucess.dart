import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/common_widgets.dart';
import '../../modules/controller/roadmap_controllers/onboarding_roadmap_controller.dart';
import '../../resources/colors.dart';
import '../../main.dart';
import '../../resources/font.dart';
import '../../resources/images.dart';
import '../../resources/strings.dart';
import '../../routes/routes_class.dart';
import '../controller/parent_invite_controller.dart';

class ParentInvitationSuccessScreen extends ParentWidget {
  const ParentInvitationSuccessScreen({super.key, this.isOnBoardingRoadmap});
  final bool? isOnBoardingRoadmap;

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    ParentInviteController controller = Get.put(ParentInviteController());
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: w,
            height: h,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      appImages.successIconFull,
                      width: 190,
                      height: 190,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    appStrings.parent,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: appColors.contentAccent,
                      fontFamily: appFonts.NunitoBold,
                    ),
                  ),
                  Text(
                    appStrings.invitationSent,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: appFonts.NunitoBold,
                      color: appColors.contentAccent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    appStrings.parentInvitationSuccessDesc,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: appColors.contentSecondary, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 30),
                  commonButton(double.infinity, 50, appColors.contentAccent, Colors.white, hint: appStrings.continueButton, () async {
                    print(isOnBoardingRoadmap);
                    if (isOnBoardingRoadmap == true) {
                      OnBoardingRoadmapController onBoardingRoadmapController = Get.put<OnBoardingRoadmapController>(OnBoardingRoadmapController());
                      //onBoardingRoadmapController.setRxRequestStatus(Status.LOADING);
                      onclickComplete(onBoardingRoadmapController.markLevelCompleted, onBoardingRoadmapController.currStepId, onBoardingRoadmapController.currIndex);
                    } else {
                      Get.offAllNamed(RoutesClass.commonScreen);
                    }
                  }),
                ],
              ),
            ),
          ),
          // isOnBoardingRoadmap == true ? progressBar((Get.put<OnBoardingRoadmapController>(OnBoardingRoadmapController()).rxRequestStatus.value == Status.LOADING) ? true : false, h, w) : const SizedBox(),
        ],
      ),
    );
  }

  onclickComplete(markLevelCompleted, currStepId, currIndex) async {
    if (isOnBoardingRoadmap ?? false) {
      // await markLevelCompleted(currIndex.value, currStepId.value);
      Get.back();
    } else {
      Get.offNamed(RoutesClass.commonScreen);
    }
  }
}
