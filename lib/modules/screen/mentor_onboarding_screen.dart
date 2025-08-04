import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/main.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';
import '../../common/common_widgets.dart';
import '../../resources/strings.dart';
import '../controller/mentor_onboarding_controller.dart';

class MentorOnBoardingScreen extends ParentWidget {
  const MentorOnBoardingScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    MentorOnBoardingController controller =
        Get.put(MentorOnBoardingController());
    return Obx(() => SizedBox(
        height: h,
        width: w,
        child: Stack(
          children: [
            Positioned(
              child: Image.asset(
                height: controller.currentIndex.value == 0
                    ? h * 0.73
                    : controller.currentIndex.value == 1
                        ? h * 0.7
                        : h * 0.62,
                width: w,
                controller.images[controller.currentIndex.value],
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: InkWell( onTap:()=> controller.currentIndex.value==0?Navigator.pop(context):controller.currentIndex.value--,child: Icon(Icons.arrow_back_ios,size: 20,color: appColors.contentPrimary,)
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: h * 0.42,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          textAlign: TextAlign.center,
                          controller.titles[controller.currentIndex.value],
                          style: TextStyle(
                              fontSize: 38,
                              fontFamily: AppFonts.appFonts.NunitoBold,
                              color: appColors.contentPrimary),
                        ),
                      ),
                      controller.currentIndex.value == 0
                          ? Text(
                              appStrings.mentorship,
                              style: TextStyle(
                                fontSize: 38,
                                fontFamily: AppFonts.appFonts.NunitoBold,
                                color: controller.currentIndex.value == 0
                                    ? appColors.contentAccent
                                    : Colors.black,
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 10),
                      Padding(
                        padding:
                            edgeInsetsOnly(left: w * 0.05, right: w * 0.05),
                        child: Text(
                          controller.subtitles[controller.currentIndex.value],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: AppFonts.appFonts.NunitoRegular,
                              fontWeight: FontWeight.w600,
                              color: appColors.contentPrimary),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: commonOnBoardingButton(
                              controller.currentIndex.value == 0
                                  ? 0.333
                                  : controller.currentIndex.value == 1
                                      ? 0.666
                                      : 1, () {
                            controller
                                .updateIndex(controller.currentIndex.value + 1);
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
