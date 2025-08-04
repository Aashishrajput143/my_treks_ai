import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/main.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';

// import 'package:vroar/resources/strings.dart';

import '../../common/common_widgets.dart';
import '../controller/student_onboarding_controller.dart';

class StudentOnBoardingScreen extends ParentWidget {
  const StudentOnBoardingScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    StudentOnBoardingController controller = Get.put(StudentOnBoardingController());
    return Obx(() => Container(
        color: appColors.onBoardingScreenBackgroundColor,
        height: h,
        width: w,
        child: Stack(
          children: [
            Positioned(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 450),
                switchOutCurve: Curves.easeInOutSine,
                switchInCurve: Curves.easeOut,
                layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                  return Stack(
                    children: <Widget>[
                      if (currentChild != null) currentChild, // Show only new text
                    ],
                  );
                },
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: controller.offsetList[controller.currentIndex.value].animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Image.asset(
                  key: ValueKey<String>(controller.images[controller.currentIndex.value]),
                  height: controller.currentIndex.value == 0
                      ? h * 0.66
                      : controller.currentIndex.value == 1
                          ? h * 0.61
                          : controller.currentIndex.value == 2
                              ? h * 0.6
                              : h * 0.6,
                  width: w,
                  controller.images[controller.currentIndex.value],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            backButton(() => controller.currentIndex.value == 0 ? Navigator.pop(context) : controller.currentIndex.value--,),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
                      Flexible(
                        child: AnimatedSwitcher(
                          switchInCurve: Curves.fastOutSlowIn,
                          switchOutCurve: Curves.fastOutSlowIn,
                          duration: const Duration(milliseconds: 350),
                          layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                            return Stack(
                              children: <Widget>[
                                if (currentChild != null) currentChild, // Show only new text
                              ],
                            );
                          },
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return SlideTransition(
                              textDirection: TextDirection.ltr,
                              position: controller.offsetList[controller.currentIndex.value].animate(animation),
                              child: child,
                            );
                          },
                          child: Text(
                            textAlign: TextAlign.center,
                            controller.titles[controller.currentIndex.value],
                            key: ValueKey<String>(controller.titles[controller.currentIndex.value]),
                            style: TextStyle(fontSize: 38, fontFamily: AppFonts.appFonts.NunitoBold, color: appColors.contentPrimary),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: edgeInsetsOnly(left: w * 0.05, right: w * 0.05),
                        child: AnimatedSwitcher(
                          switchInCurve: Curves.fastOutSlowIn,
                          switchOutCurve: Curves.fastOutSlowIn,
                          duration: const Duration(milliseconds: 350),
                          layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                            return Stack(
                              children: <Widget>[
                                if (currentChild != null) currentChild, // Show only new text
                              ],
                            );
                          },
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return SlideTransition(
                              textDirection: TextDirection.ltr,
                              position: controller.offsetList[controller.currentIndex.value].animate(animation),
                              child: child,
                            );
                          },
                          child: Text(
                            key: ValueKey<String>(controller.titles[controller.currentIndex.value]),
                            controller.subtitles[controller.currentIndex.value],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, fontFamily: AppFonts.appFonts.NunitoRegular, fontWeight: FontWeight.w600, color: appColors.contentPrimary),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: commonOnBoardingButton(
                              controller.currentIndex.value == 0
                                  ? 0.20
                                  : controller.currentIndex.value == 1
                                      ? 0.40
                                      : controller.currentIndex.value == 2
                                          ? 0.60
                                          : controller.currentIndex.value == 3
                                              ? 0.80
                                              : 1, () {
                            controller.updateIndex(controller.currentIndex.value + 1);
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
