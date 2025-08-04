import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../../common/my_utils.dart';
import '../../../data/response/status.dart';
import '../../../resources/colors.dart';
import '../../../common/gradient.dart';
import '../../../common/common_widgets.dart';
import '../../../resources/font.dart';
import '../../../resources/strings.dart';
import '../../../utils/sized_box_extension.dart';
import '../../controller/roadmap_controllers/top_strength_controller.dart';

class TopStrengthScreen extends ParentWidget {
  const TopStrengthScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    TopStrengthController controller = Get.put(TopStrengthController());
    return Obx(() => Stack(children: [
          Container(
              decoration: BoxDecoration(gradient: AppGradients.customGradient),
              padding: EdgeInsets.only(bottom: h <= 677 ? 0 : 22),
              child: Scaffold(
                  appBar: AppBar(
                      toolbarHeight: 80,
                      // backgroundColor: Colors.white,
                      backgroundColor: Colors.transparent,
                      automaticallyImplyLeading: false,
                      centerTitle: false,
                      title: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(appStrings.enter, style: TextStyle(fontSize: 28, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentPrimary)),
                            RichText(
                                text: TextSpan(
                                    text: appStrings.yourTop,
                                    style: TextStyle(fontSize: 28, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentPrimary),
                                    children: [TextSpan(text: appStrings.strengths, style: TextStyle(fontSize: 28, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentAccent))]))
                          ]))),
                  //resizeToAvoidBottomInset: false,
                  body: Container(
                      decoration: BoxDecoration(gradient: AppGradients.commonGradient),
                      height: h,
                      width: w,
                      child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(appStrings.strengthDesc, style: TextStyle(fontSize: 16, color: appColors.contentSecondary, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600)),
                                20.kH,
                                dropdownButton(controller.topStrength, controller.selectedStrength1.value, w, 50, Colors.white, hint: appStrings.strength1, (newValue) => controller.updateStrength(controller.selectedStrength1, newValue)),
                                8.kH,
                                dropdownButton(controller.topStrength, controller.selectedStrength2.value, w, 50, Colors.white, hint: appStrings.strength2, (newValue) => controller.updateStrength(controller.selectedStrength2, newValue)),
                                8.kH,
                                dropdownButton(controller.topStrength, controller.selectedStrength3.value, w, 50, Colors.white, hint: appStrings.strength3, (newValue) => controller.updateStrength(controller.selectedStrength3, newValue)),
                                8.kH,
                                dropdownButton(controller.topStrength, controller.selectedStrength4.value, w, 50, Colors.white, hint: appStrings.strength4, (newValue) => controller.updateStrength(controller.selectedStrength4, newValue)),
                                8.kH,
                                dropdownButton(controller.topStrength, controller.selectedStrength5.value, w, 50, Colors.white, hint: appStrings.strength5, (newValue) => controller.updateStrength(controller.selectedStrength5, newValue)),
                                // SizedBox(height: h * 0.18),
                                20.kH
                              ])))),
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: Padding(
                      // decoration: BoxDecoration(color: Colors.transparent, gradient: AppGradients.customGradient),
                      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                      child: commonButton(double.infinity, 50, appColors.contentAccent, Colors.white, hint: appStrings.complete, () async => await controller.onClickComplete())))),
          progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w),
          // internetException(
          //     controller.rxRequestStatus.value == Status.ERROR &&
          //         controller.error.value.toString() == "No internet",
          //         () {}),
          // generalException(
          //     controller.rxRequestStatus.value == Status.ERROR &&
          //         controller.error.value.toString() != "No internet",
          //         () {}),
        ]));
  }
}
