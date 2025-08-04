import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:vroar/utils/sized_box_extension.dart';

import '../../common/common_shimmer.dart';
import '../../common/common_widgets.dart';
import '../../common/my_utils.dart';
import '../../data/response/status.dart';
import '../../main.dart';
import '../../resources/colors.dart';
import '../../resources/font.dart';
import '../../resources/images.dart';
import '../../resources/strings.dart';
import '../controller/parent_home_controller.dart';

class ParentHomeScreen extends ParentWidget {
  const ParentHomeScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    ParentHomeController controller = Get.put(ParentHomeController());
    return Obx(() =>
            Scaffold(
              appBar: appBar(context,h, w),
              resizeToAvoidBottomInset: true,
              body: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: w,
                color: Colors.white,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: h*0.025),
                      controller.mainController.rxRequestStatus.value ==
                          Status.COMPLETED
                          ? roadMapText(context,h,w)
                          :shimmerRoundedLine(w, h * 0.26),
                      paddingOnly(top: 10),
                      SizedBox(height: h * 0.01),
                      controller.mainController.rxRequestStatus.value ==
                          Status.COMPLETED
                          ? needAssistanceText(context,h,w)
                          : shimmerRoundedLine(w, h * 0.09),
                      SizedBox(height: h * 0.1),
                      controller.mainController.rxRequestStatus.value ==
                          Status.COMPLETED
                          ? Text(
                        appStrings.empoweringYourChild,
                        style: TextStyle(
                            fontFamily: appFonts.NunitoBold,
                            color: appColors.buttonTextStateDisabled,
                            fontSize: 45,
                            fontWeight: FontWeight.w500),
                      )
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          3,
                              (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: shimmerRoundedLine(index==0?w*0.4:index==1?w*0.5:w*0.6, 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ));
  }

  PreferredSizeWidget appBar(BuildContext context, double h, double w){
    ParentHomeController controller = Get.put(ParentHomeController());
    return AppBar(
      surfaceTintColor: Colors.white,
      toolbarHeight: 70,
      title: controller.mainController.rxRequestStatus.value==Status.COMPLETED? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appStrings.hello,
            style: TextStyle(
                fontFamily: appFonts.NunitoBold,
                color: Color(
                  appColors.black,
                ),
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
          Text(
            controller.mainController.getProfileData.value.data
                ?.firstName ??
                "User",
            style: TextStyle(
                fontFamily: appFonts.NunitoBold,
                color: appColors.contentAccent,
                fontSize: 28,
                fontWeight: FontWeight.w700),
          ),
        ],
      ):Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shimmerRoundedLine(100, 20),
          6.kH,
          shimmerRoundedLine(150, 28)
        ],
      ),
      actions: [
        // InkWell(
        //   onTap: (){},
        //   child: Image.asset(appImages.bellIcons, height: 34, width: 34),
        // ),
        // paddingOnly(left: 10),
        controller.mainController.rxRequestStatus.value ==
            Status.COMPLETED
            ?
        InkWell(
          onTap: () =>
          controller.mainController.selectedIndex.value = 4,
          child: Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: appColors.photoBackground,
              child: ClipOval(
                child: controller.mainController.getProfileData
                    .value.data?.avatar?.isNotEmpty ??
                    false
                    ? Image.network(
                  controller.mainController.getProfileData
                      .value.data?.avatar ??
                      "",
                  fit: BoxFit.cover,
                  width: 45,
                  height: 45,
                )
                    : Image.asset(
                  appImages.jhony,
                  fit: BoxFit.cover,
                  width: 45,
                  height: 45,
                ),
              ),
            ),
          ),
        ):shimmerCircle(25),
        paddingOnly(right: 16),
      ],
    );
  }

  Widget roadMapText(BuildContext context, double h, double w){
    return Stack(
      children: [
        Container(
          height: h * 0.26,
          width: w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                12),
            child: Image.asset(
              appImages
                  .parentStrengthBackground,
              fit: BoxFit
                  .cover,
            ),
          ),
        ),
        Positioned(
            top: 18,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appStrings.yourChild,
                  style: TextStyle(
                      fontFamily: appFonts.NunitoRegular,
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  appStrings.roadMap,
                  style: TextStyle(
                      fontFamily: appFonts.NunitoBold,
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: w * 0.4,
                  child: LinearProgressBar(
                    maxSteps: 10,
                    progressType:
                    LinearProgressBar.progressTypeLinear,
                    currentStep: 5,
                    progressColor: appColors.contentAccent,
                    backgroundColor:
                    Colors.white.withOpacity(0.5),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  appStrings.percentCompleted,
                  style: TextStyle(
                      fontFamily: appFonts.NunitoRegular,
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                Text(
                  appStrings.keepTrackChild,
                  style: TextStyle(
                      fontFamily: appFonts.NunitoRegular,
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                commonButton(
                    30,
                    20,
                    Colors.white,
                    appColors.contentAccent,
                    hint: appStrings.trackNow,
                    radius: 4,
                    paddingHorizontal: 8,
                    paddingVertical: 4,
                        () {})
              ],
            ))
      ],
    );
  }

  Widget needAssistanceText(BuildContext context, double h, double w){
    ParentHomeController controller = Get.put(ParentHomeController());
    return InkWell(
      onTap: () =>
      controller.mainController.selectedIndex.value = 3,
      child: Container(
        height: h * 0.09,
        width: w,
        padding: const EdgeInsets.symmetric(
            vertical: 8, horizontal: 12), // Added padding
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: appColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  appStrings.raiseFeedback,
                  style: TextStyle(
                      fontFamily: appFonts.NunitoBold,
                      color: appColors.contentPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  appStrings.shareInsightsChild,
                  style: TextStyle(
                      fontFamily: appFonts.NunitoRegular,
                      color: appColors.contentSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SvgPicture.asset(
              appImages.msg,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
