import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../modules/controller/roadmap_controllers/onboarding_roadmap_controller.dart';
import '../../resources/colors.dart';
import '../../common/common_widgets.dart';
import '../../utils/sized_box_extension.dart';
import '../../main.dart';
import '../../data/response/status.dart';
import '../../resources/font.dart';
import '../../resources/strings.dart';
import '../my_utils.dart';

class RoadmapTaskDoneScreen extends ParentWidget {
  const RoadmapTaskDoneScreen({super.key,this.appBarBack,this.paddingTop, required this.image, this.subText, required this.titleText, this.isLottie,this.showButton, this.buttonHint,this.button2Hint,this.navigate,this.onComplete});
  final String image;
  final String titleText;
  final String? subText;
  final String? buttonHint;
  final String? button2Hint;
  final bool? appBarBack;
  final bool? showButton;
  final VoidCallback? onComplete;
  final VoidCallback? navigate;
  final bool? isLottie;
  final double? paddingTop;
  @override
  Widget buildingView(BuildContext context, double h, double w) {
    OnBoardingRoadmapController controller = Get.put(OnBoardingRoadmapController());
    return Obx(()=> Stack(
      children: [
        Scaffold(
        appBar: AppBar(
            surfaceTintColor: Colors.white,
            leading: appBarBack??false?InkWell(onTap: () =>Get.back(), child: Icon(Icons.arrow_back_ios, size: 20, color: appColors.contentPrimary)):const SizedBox()),
        body: Container(
          width: w,
          height: h,
          //margin: EdgeInsets.only(top: paddingTop??h*0.12),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: (isLottie ?? false) ? Lottie.asset(reverse: false, image, repeat: true, width: 190, height: 190) : SvgPicture.asset(image, width: 190, height: 190),
                    ),
                    10.kH,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        titleText,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: appColors.contentAccent,
                          fontFamily: appFonts.NunitoBold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    10.kH,
                    subText != null
                        ? Text(
                              subText ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, color: appColors.contentSecondary, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600),
                            )
                        : const SizedBox(),
                    30.kH,
                    if(showButton??true)...[
                      buttonHint?.isNotEmpty??false?commonButton(double.infinity, 50, Colors.white, appColors.contentAccent, onComplete, borderColor: appColors.contentAccent, hint: buttonHint??appStrings.retakeAssessment):const SizedBox(),
                      16.kH,
                      button2Hint?.isNotEmpty??false?commonButton(double.infinity, 50, appColors.contentAccent, Colors.white, hint: button2Hint??appStrings.continueToNextLvlButton, navigate):const SizedBox(),
                    ]
                  ],
                ),
            ),
          ),
          ),
      ),
        progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w),
    ],));
  }
}
