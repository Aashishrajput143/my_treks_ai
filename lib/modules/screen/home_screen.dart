import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:vroar/common/common_shimmer.dart';
import 'package:vroar/routes/routes_class.dart';
import 'package:vroar/utils/sized_box_extension.dart';

import '../../common/app_constants_list.dart';
import '../../common/common_widgets.dart';
// import '../../common/my_utils.dart';
import '../../data/response/status.dart';
import '../../main.dart';
import '../../resources/colors.dart';
import '../../resources/font.dart';
import '../../resources/images.dart';
import '../../resources/strings.dart';
import '../controller/home_controller.dart';

class HomeScreen extends ParentWidget {
  const HomeScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    HomeController controller = Get.put(HomeController());
    return GetBuilder<HomeController>(
        init: HomeController(),
        initState: (state) {
          if (state.mounted) {
            controller.setGreeting();
            controller.getRoadmapCompletionApi();
            controller.getEventListApi();
          }
        },
        builder: (controller) {
          return Obx(() => Stack(
                children: [
                  Scaffold(
                    appBar: appBar(context, h, w),
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
                            paddingOnly(top: 10),
                            controller.roadmapCompletionData.value.data?.percentage != null
                                ? roadMapText(context, 200, w)
                                : controller.rxRequestStatus.value == Status.LOADING
                                    ? shimmerRoundedLine(w, 200)
                                    : shimmerRoundedLine(w, 200),
                            paddingOnly(top: 10),
                            mentorInternshipText(context, 200, w),
                            paddingOnly(top: 10),
                            controller.eventListData.value.data != null
                                ? controller.eventListData.value.data?.docs?.isNotEmpty ?? false
                                    ? eventText(context, 125, w)
                                    : const SizedBox()
                                : controller.rxRequestStatus.value == Status.LOADING
                                    ? shimmerRoundedLine(w, 125)
                                    : shimmerRoundedLine(w, 125),
                            8.kH,
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(controller.eventListData.value.data?.docs?.length ?? 0,
                                    (index) => Container(width: 7, height: 7, margin: const EdgeInsets.symmetric(horizontal: 4), decoration: BoxDecoration(shape: BoxShape.circle, color: controller.currentIndex.value == index ? appColors.contentAccent : appColors.border)))),
                            SizedBox(height: h * 0.01),
                            controller.mainController.rxRequestStatus.value == Status.COMPLETED ? Padding(padding: const EdgeInsets.only(bottom: 16.0), child: needAssistanceText(context, 80, w)) : shimmerRoundedLine(w, 80),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // internetException(
                  //     controller.mainController.rxRequestStatus.value == Status.NOINTERNET||
                  //         controller.rxRequestStatus.value == Status.NOINTERNET,
                  //         () {}),
                  // generalException(
                  //     controller.rxRequestStatus.value == Status.ERROR &&
                  //         controller.error.value.toString() != "No internet",
                  //         () {}),
                  //progressBar(controller.mainController.rxRequestStatus.value == Status.LOADING, h, w)
                ],
              ));
        });
  }

  PreferredSizeWidget appBar(BuildContext context, double h, double w) {
    HomeController controller = Get.put(HomeController());
    return AppBar(
      surfaceTintColor: Colors.white,
      toolbarHeight: 70,
      title: controller.mainController.getProfileData.value.data?.email?.isNotEmpty ?? false
          ? Column(
              crossAxisAlignment: controller.mainController.getProfileData.value.data?.firstName?.isNotEmpty ?? false ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      controller.greetings.value,
                      style: TextStyle(fontFamily: appFonts.NunitoBold, color: Color(appColors.black), fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                    paddingOnly(left: 5),
                    Image.asset(controller.greetings.value == "Good Evening" || controller.greetings.value == "Good Night" ? appImages.moonIcon : appImages.sunIcon, height: 25, width: 25)
                  ],
                ),
                controller.mainController.getProfileData.value.data?.firstName?.isNotEmpty ?? false
                    ? Text(
                        controller.mainController.getProfileData.value.data?.firstName ?? "",
                        style: TextStyle(fontFamily: appFonts.NunitoBold, color: appColors.contentAccent, fontSize: 28, fontWeight: FontWeight.w700),
                      )
                    : const SizedBox(),
              ],
            )
          : controller.rxRequestStatus.value == Status.LOADING
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [shimmerRoundedLine(100, 20), 6.kH, shimmerRoundedLine(150, 28)])
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [shimmerRoundedLine(100, 20), 6.kH, shimmerRoundedLine(150, 28)]),
      actions: [
        // InkWell(
        //   onTap: (){},
        //   child: SvgPicture.asset(appImages.bellIcons, height: 34, width: 34),
        // ),
        // paddingOnly(left: 10),
        controller.mainController.rxRequestStatus.value == Status.COMPLETED
            ? InkWell(
                onTap: () => controller.mainController.selectedIndex.value = 4,
                child: Container(
                    width: 45,
                    height: 45,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: CircleAvatar(
                        radius: 25,
                        backgroundColor: appColors.photoBackground,
                        child: ClipOval(
                            child: controller.mainController.getProfileData.value.data?.avatar?.isNotEmpty ?? false
                                ? Image.network(controller.mainController.getProfileData.value.data?.avatar ?? "", fit: BoxFit.cover, width: 45, height: 45)
                                : Image.asset(appImages.jhony, fit: BoxFit.cover, width: 45, height: 45)))))
            : shimmerCircle(25),
        paddingOnly(right: 16),
      ],
    );
  }

  Widget roadMapText(BuildContext context, double h, double w) {
    HomeController controller = Get.put(HomeController());
    return Container(
        height: h,
        width: w,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), image: DecorationImage(image: AssetImage(appImages.parentStrengthBackground), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appStrings.your,
                style: TextStyle(fontFamily: appFonts.NunitoRegular, color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                appStrings.roadMap,
                style: TextStyle(fontFamily: appFonts.NunitoBold, color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                  width: w * 0.4,
                  child: LinearProgressBar(
                      maxSteps: 100,
                      progressType: LinearProgressBar.progressTypeLinear,
                      currentStep: controller.roadmapCompletionData.value.data?.percentage ?? 0,
                      progressColor: appColors.contentAccent,
                      backgroundColor: Colors.white.withOpacity(0.5),
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(10))),
              1.kH,
              Text(
                controller.roadmapCompletionData.value.data?.percentage != 0 ? "${controller.roadmapCompletionData.value.data?.percentage ?? 0}${appStrings.percentCompleted}" : "${controller.roadmapCompletionData.value.data?.percentage ?? 0}${appStrings.progressNoCompleted}",
                style: TextStyle(fontFamily: appFonts.NunitoRegular, color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
              ),
              20.kH,
              Text(
                controller.roadmapCompletionData.value.data?.percentage != 0
                    ? controller.roadmapCompletionData.value.data?.percentage == 100
                        ? appStrings.learningJourneyCompleted
                        : appStrings.continueYourLearningJourney
                    : appStrings.beginYourLearningJourney,
                style: TextStyle(fontFamily: appFonts.NunitoRegular, color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
              ),
              commonButton(30, 20, Colors.white, appColors.contentAccent,
                  hint: controller.roadmapCompletionData.value.data?.percentage != 0
                      ? controller.roadmapCompletionData.value.data?.percentage == 100
                          ? appStrings.doneIt
                          : appStrings.keepGoing
                      : appStrings.startNow,
                  radius: 4,
                  paddingHorizontal: 8,
                  paddingVertical: 4, () {
                controller.mainController.selectedIndex.value = 1;
              })
            ],
          ),
        ));
  }

  Widget mentorInternshipText(BuildContext context, double h, double w) {
    HomeController controller = Get.put(HomeController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        controller.mainController.rxRequestStatus.value == Status.COMPLETED
            ? Container(
                height: h,
                width: w * 0.45,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), image: DecorationImage(image: AssetImage(appImages.mentorImage), fit: BoxFit.cover)),
                child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appStrings.mentor,
                          style: TextStyle(fontFamily: appFonts.NunitoBold, color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          appStrings.library,
                          style: TextStyle(fontFamily: appFonts.NunitoBold, color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        30.kH,
                        Text(
                          appStrings.bookASessionWithMentor,
                          style: TextStyle(fontFamily: appFonts.NunitoRegular, color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        commonButton(
                          30,
                          20,
                          Colors.white,
                          appColors.contentAccent,
                          hint: appStrings.findYourMentor,
                          radius: 4,
                          paddingHorizontal: 8,
                          paddingVertical: 4,
                          () => controller.mainController.selectedIndex.value = 7,
                        )
                      ],
                    )))
            : shimmerRoundedLine(w * 0.45, h),
        controller.mainController.rxRequestStatus.value == Status.COMPLETED
            ? Container(
                height: h,
                width: w * 0.45,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), image: DecorationImage(image: AssetImage(appImages.internshipImage), scale: 4, fit: BoxFit.cover)),
                child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(
                        appStrings.internships,
                        style: TextStyle(fontFamily: appFonts.NunitoBold, color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      76.kH,
                      Text(
                        appStrings.exploreNow,
                        style: TextStyle(fontFamily: appFonts.NunitoRegular, color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      commonButton(30, 20, Colors.white, appColors.contentAccent, hint: appStrings.exploreInternships, radius: 4, fontSize: h <= 677 ? 15 : 16, paddingHorizontal: 4, paddingVertical: 4, () => controller.mainController.selectedIndex.value = 13)
                    ])))
            : shimmerRoundedLine(w * 0.45, h),
      ],
    );
  }

  Widget eventText(BuildContext context, double h, double w) {
    HomeController controller = Get.put(HomeController());
    List<String> images = [appImages.bagBanner, appImages.boxStarIcon, appImages.flagIcon];
    return CarouselSlider(
      options: CarouselOptions(
        initialPage: controller.currentIndex.value,
        //height: h,
        autoPlay: controller.eventListData.value.data?.docs != null
            ? controller.eventListData.value.data!.docs!.length >= 2
                ? true
                : false
            : false,
        enlargeCenterPage: true,
        aspectRatio: 16 / 6,
        viewportFraction: 1,
        onPageChanged: (index, reason) {
          controller.currentIndex.value = index;
        },
      ),
      items: controller.eventListData.value.data?.docs?.asMap().entries.map((entry) {
        var id = entry.value.id;
        String title = entry.value.eventName ?? "";
        String eventTime = controller.getDateTime(entry.value.sessionStartDate ?? "000", entry.value.sessionStartDate ?? "000");
        return Builder(builder: (BuildContext context) {
          return InkWell(
              onTap: () {
                Get.toNamed(RoutesClass.eventDetails, arguments: {'index': controller.currentIndex.value, 'id': id, "eventType": "FREE", 'Tag': ""});
              },
              child: Stack(children: [
                Container(
                  width: w,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppConstantsList.carouselSliderColor[controller.currentIndex.value % AppConstantsList.carouselSliderColor.length]["dark"]),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [SizedBox(width: w * 0.45, child: Text(title, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white))), 10.kH, Text(eventTime, style: const TextStyle(fontSize: 14, color: Colors.white))]),
                ),
                Positioned(
                    right: -45,
                    top: -15,
                    child: Stack(alignment: Alignment.center, children: [
                      Container(
                        width: 190,
                        height: 190,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppConstantsList.carouselSliderColor[controller.currentIndex.value % AppConstantsList.carouselSliderColor.length]["light"].withOpacity(0.1)),
                      ),
                      Container(
                        width: 135,
                        height: 135,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppConstantsList.carouselSliderColor[controller.currentIndex.value % AppConstantsList.carouselSliderColor.length]["light"].withOpacity(0.5)),
                      ),
                      Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: AppConstantsList.carouselSliderColor[controller.currentIndex.value % AppConstantsList.carouselSliderColor.length]["dark"]),
                          child: Align(alignment: Alignment.center, child: SvgPicture.asset(images[controller.currentIndex.value % images.length], width: 42, height: 42, fit: BoxFit.contain)))
                    ]))
              ]));
        });
      }).toList(),
    );
  }

  Widget needAssistanceText(BuildContext context, double h, double w) {
    return InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () => Get.toNamed(RoutesClass.needAssistance),
        child: Container(
            height: h,
            width: w,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Added padding
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: appColors.border)),
            child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    appStrings.needAssistanceQuestionMark,
                    style: TextStyle(fontFamily: appFonts.NunitoBold, color: appColors.contentPrimary, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  4.kH,
                  Text(
                    appStrings.getHelpNeedQuickly,
                    style: TextStyle(fontFamily: appFonts.NunitoRegular, color: appColors.contentSecondary, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SvgPicture.asset(appImages.msg, width: 40, height: 40, fit: BoxFit.contain)
            ])));
  }
}
