import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/main.dart';
import 'package:vroar/modules/controller/onboarding_controller.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';

import 'package:vroar/resources/strings.dart';

import '../../common/common_widgets.dart';

class OnBoardingScreen extends ParentWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    OnBoardingController controller = Get.put(OnBoardingController());
    return Obx(() => Container(
        color: appColors.onBoardingScreenBackgroundColor,
        height: h,
        width: w,
        child: Stack(
          children: [
            Positioned(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 800),
                switchOutCurve: Curves.fastLinearToSlowEaseIn,
                switchInCurve: Curves.fastOutSlowIn,
                layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                  return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      if (currentChild != null) currentChild, // Only display the new image
                    ],
                  );
                },
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: AnimatedSize(alignment: Alignment.topCenter, curve: Curves.fastOutSlowIn, duration: const Duration(milliseconds: 800), child: child),
                  );
                },
                child: Image.asset(
                  key: ValueKey<String>(controller.images[controller.currentIndex.value]),
                  height: controller.currentIndex.value == 0
                      ? h * 0.66
                      : controller.currentIndex.value == 1
                          ? h * 0.61
                          : controller.currentIndex.value == 2
                              ? h * 0.76
                              : h * 0.6,
                  width: w,
                  controller.images[controller.currentIndex.value],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            controller.currentIndex.value > 0
                ? backButton(() => controller.currentIndex.value == 0 ? null : controller.currentIndex.value--,)
                : Container(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                //height: controller.currentIndex.value == 3 ? h * 0.49 : h * 0.42,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: h<=667? 20:50),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      AnimatedSwitcher(
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
                        child: controller.currentIndex.value == 0
                            ? Text(
                                appStrings.myTreks,
                                key: ValueKey<String>(appStrings.myTreks),
                                style: TextStyle(
                                  fontSize: 38,
                                  fontFamily: AppFonts.appFonts.NunitoBold,
                                  color: controller.currentIndex.value == 0 ? appColors.contentAccent : Colors.black,
                                ),
                              )
                            : const SizedBox(),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding:edgeInsetsOnly(left: w * 0.08, right: w * 0.08),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          switchOutCurve: Curves.fastOutSlowIn,
                          layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                            return Stack(
                              children: <Widget>[
                                if (currentChild != null) currentChild, // Show only new text
                              ],
                            );
                          },
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return SlideTransition(
                              position: controller.offsetList[controller.currentIndex.value].animate(animation),
                              child: child,
                            );
                          },
                          child: Text(
                            controller.subtitles[controller.currentIndex.value],
                            key: ValueKey<String>(controller.subtitles[controller.currentIndex.value]),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, fontFamily: AppFonts.appFonts.NunitoRegular, fontWeight: FontWeight.w600, color: appColors.contentPrimary),
                          ),
                        ),
                      ),
                      controller.currentIndex.value == 0
                          ? const SizedBox(height: 31.5)
                          : controller.currentIndex.value == 3
                              ? const SizedBox(height: 35)
                              : const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: commonOnBoardingButton(
                              controller.currentIndex.value == 0
                                  ? 0.25
                                  : controller.currentIndex.value == 1
                                      ? 0.5
                                      : controller.currentIndex.value == 2
                                          ? 0.75
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
