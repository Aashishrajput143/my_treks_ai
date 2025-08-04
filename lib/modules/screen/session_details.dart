import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vroar/common/my_alert_dialog.dart';
import 'package:vroar/main.dart';
import 'package:vroar/modules/controller/common_screen_controller.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';
import 'package:vroar/resources/images.dart';

import '../../common/app_constants_list.dart';
import '../../common/common_widgets.dart';
import '../../common/my_utils.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../controller/session_details_controller.dart';

class SessionDetailsScreen extends ParentWidget {
  const SessionDetailsScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    SessionDetailsController controller = Get.put(SessionDetailsController());
    return Obx(() => Stack(
          children: [
            controller.eventData.value.data?.eventName?.isNotEmpty ?? false
                ? Scaffold(
                    appBar: AppBar(
                        surfaceTintColor: Colors.white,
                        centerTitle: true,
                        toolbarHeight: 70,
                        leading: InkWell(
                          onTap: () => Get.back(),
                          child: Icon(Icons.arrow_back_ios, size: 20, color: appColors.contentPrimary),
                        ),
                        title: Text(controller.isPaid.value ? controller.tag.value : appStrings.sessionDetails, style: TextStyle(fontSize: 24, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (controller.isPaid.value) ...[
                              Stack(children: [
                                Container(
                                    width: w,
                                    //height: h * 0.148,
                                    constraints: BoxConstraints(minHeight: h * 0.14),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppConstantsList.carouselSliderColor[controller.currentIndex.value % AppConstantsList.carouselSliderColor.length]["dark"]),
                                    padding: const EdgeInsets.all(12),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                                      SizedBox(width: w * 0.5, child: Text(controller.eventData.value.data?.eventName ?? "", style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white))),
                                      const SizedBox(height: 10),
                                      Text(
                                          "${controller.getDateTime(controller.eventData.value.data?.sessionStartDate ?? "000", controller.eventData.value.data?.sessionStartDate ?? "000")} ${controller.eventData.value.data?.sessionStartTime} - ${controller.eventData.value.data?.sessionEndTime}",
                                          style: const TextStyle(fontSize: 14, color: Colors.white))
                                    ])),
                                Positioned(
                                    right: -45,
                                    top: -15,
                                    child: Stack(alignment: Alignment.center, children: [
                                      Container(width: 190, height: 190, decoration: BoxDecoration(shape: BoxShape.circle, color: AppConstantsList.carouselSliderColor[controller.currentIndex.value % AppConstantsList.carouselSliderColor.length]["light"].withOpacity(0.1))),
                                      Container(width: 135, height: 135, decoration: BoxDecoration(shape: BoxShape.circle, color: AppConstantsList.carouselSliderColor[controller.currentIndex.value % AppConstantsList.carouselSliderColor.length]["light"].withOpacity(0.5))),
                                      Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(shape: BoxShape.circle, color: AppConstantsList.carouselSliderColor[controller.currentIndex.value % AppConstantsList.carouselSliderColor.length]["dark"]),
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: SvgPicture.asset(
                                                  controller.tag.value == "Webinar"
                                                      ? appImages.webinar
                                                      : controller.tag.value == "On-Field Workshop"
                                                          ? appImages.onFieldWorkshop
                                                          : appImages.mentorSession,
                                                  width: 42,
                                                  color: Colors.white,
                                                  height: 42,
                                                  fit: BoxFit.contain)))
                                    ]))
                              ])
                            ],
                            if (!controller.isPaid.value) ...[Text(controller.eventData.value.data?.eventName ?? "", style: TextStyle(fontSize: 24, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold), textAlign: TextAlign.start)],

                            SizedBox(height: h * 0.01),
                            Text(controller.eventData.value.data?.eventDescription ?? "",
                                //textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 12, color: appColors.contentSecondary, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600)),
                            if (!controller.isPaid.value) ...[
                              SizedBox(height: h * 0.01),
                              Row(children: [
                                SvgPicture.asset(appImages.bagIcon, width: 22, height: 22, fit: BoxFit.contain),
                                const SizedBox(width: 5),
                                Text(controller.getDate(controller.eventData.value.data?.sessionStartDate ?? "000"), textAlign: TextAlign.start, style: TextStyle(fontSize: 14, color: appColors.contentSecondary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w500))
                              ])
                            ],
                            SizedBox(height: h * 0.04),
                            Text(appStrings.speakerName, style: TextStyle(fontSize: 16, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w500), textAlign: TextAlign.start),
                            const SizedBox(height: 2),
                            Text(controller.eventData.value.data?.speakerName ?? "", style: TextStyle(fontSize: 14, color: appColors.contentSecondary, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w500), textAlign: TextAlign.start),
                            SizedBox(height: h * 0.03),
                            Text(appStrings.eventDescription, style: TextStyle(fontSize: 16, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w500), textAlign: TextAlign.start),
                            const SizedBox(height: 2),
                            Text(
                              controller.eventData.value.data?.eventDescription ?? "",
                              style: TextStyle(fontSize: 14, color: appColors.contentSecondary, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w500),
                              //textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: h * 0.03),
                            Text(appStrings.speakerSummary, style: TextStyle(fontSize: 16, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w500), textAlign: TextAlign.start),
                            const SizedBox(height: 2),
                            commonReadMoreText(controller.eventData.value.data?.speakerSummary ?? "", trimLine: 3),
                            SizedBox(height: h * 0.03),
                            Text(appStrings.sessionDetails, style: TextStyle(fontSize: 16, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w500), textAlign: TextAlign.start),
                            const SizedBox(height: 2),
                            Text(
                              controller.eventData.value.data?.sessionDetails ?? "",
                              style: TextStyle(fontSize: 14, color: appColors.contentSecondary, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w500),
                              //textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: h * 0.03),
                            Text(appStrings.sessionTimings, style: TextStyle(fontSize: 16, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w500), textAlign: TextAlign.start),
                            const SizedBox(height: 2),
                            Text("${controller.eventData.value.data?.sessionStartTime} - ${controller.eventData.value.data?.sessionEndTime}",
                                style: TextStyle(fontSize: 14, color: appColors.contentSecondary, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w500), textAlign: TextAlign.start),
                            // SizedBox(height: h * 0.03),
                            // Text(
                            //   appStrings.meetingLink,
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //     color: appColors.contentPrimary,
                            //     fontFamily: appFonts.NunitoBold,
                            //     fontWeight: FontWeight.w500,
                            //   ),
                            //   textAlign: TextAlign.start,
                            // ),
                            // const SizedBox(height: 2),
                            // Text(
                            //   controller.eventData.value.data?.zoomLink??"",
                            //   style: TextStyle(
                            //     fontSize: 14,
                            //     color: appColors.contentSecondary,
                            //     fontFamily: appFonts.NunitoMedium,
                            //     fontWeight: FontWeight.w500,
                            //   ),
                            //   textAlign: TextAlign.start,
                            // ),
                            SizedBox(height: h * 0.03),
                          ],
                        ),
                      ),
                    ),
                    bottomNavigationBar: Container(
                        margin: EdgeInsets.only(bottom: h <= 677 ? 0 : 20),
                        padding: const EdgeInsets.all(16.0),
                        child: commonButton(double.infinity, 50, appColors.contentAccent, Colors.white,
                            hint: controller.isPaid.value
                                ? controller.tag.value == "Mentor Session"
                                    ? "Unlock Session"
                                    : appStrings.registerEventButton
                                : appStrings.rSVPButton, () async {
                          controller.isPaid.value ? controller.onSubmitPaid() : controller.onSubmitFree();
                        })))
                : const SizedBox(),
            progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w),
          ],
        ));
  }

  successDialog() async {
    Get.dialog(barrierDismissible: false, CustomAlertDialog(height: 440, message: appStrings.sessionSuccess));
    await Future.delayed(const Duration(seconds: 2));
    Get.back();
  }

  paidDialog(int coins) async {
    SessionDetailsController controller = Get.put(SessionDetailsController());
    Get.dialog(
        barrierDismissible: false,
        EventCoinDialogBox(
            width: Get.width,
            title: "Creative Writing Workshop",
            buttonHint: "No, Cancel",
            buttonHint2: "Yes, Register Now",
            onChanged: () {
              Get.back();
            },
            onChanged2: () {
              Get.back();
              controller.redeemRewardsApi();
            },
            coin: coins,
            message: "Are you sure you want to register for this event? Registering for this event will use $coins coins."));
  }

  paidSuccessDialog() async {
    CommonScreenController controller = Get.put(CommonScreenController());
    Get.dialog(
        barrierDismissible: false,
        SuccessDialogBox(
            width: Get.width,
            title: appStrings.successfullyRegisteredEvent,
            buttonHint: appStrings.buttonGoBackHome,
            onChanged: () {
              Get.back();
              Get.back();
              controller.selectedIndex.value = 0;
            },
            message: appStrings.eventSuccessDesc));
  }
}
