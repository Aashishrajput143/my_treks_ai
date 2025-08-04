import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:vroar/main.dart';
import 'package:vroar/modules/controller/roadmap_controllers/question_answer_controller.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';
import 'package:vroar/resources/images.dart';

import 'package:vroar/resources/strings.dart';

import '../../../common/common_widgets.dart';
import '../../../common/my_utils.dart';
import '../../../data/response/status.dart';

class QuestionAnswerScreen extends ParentWidget {
  const QuestionAnswerScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    QuestionAnswerController controller = Get.put(QuestionAnswerController());
    return Obx(
      () => Stack(
        children: [
          SizedBox(
            height: h,
            width: w,
            child: Stack(
              children: [
                Positioned(
                  child: Image.asset(
                    height: h * 0.37,
                    width: w,
                    color: Colors.black.withOpacity(0.6),
                    colorBlendMode: BlendMode.darken,
                    appImages.parentStrengthBackground,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  left: w * 0.41,
                  top: h * 0.09,
                  right: 12,
                  bottom: 12,
                  child: RichText(
                    text: TextSpan(
                      text:
                          "${((controller.currentIndex.value) + 1).toString().padLeft(2, '0')} ",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: appFonts.PlusJakartaSansRegular,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: appColors.contentAccent,
                      ),
                      children: [
                        TextSpan(
                          text:
                              " of  ${(controller.getAssessmentData.value.data?.questions?.length ?? 1)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: appFonts.PlusJakartaSansRegular,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                            color: appColors.buttonTextStateDisabled,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: w * 0.05,
                  top: h * 0.19,
                  right: 12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: LinearProgressBar(
                      maxSteps: controller.getAssessmentData.value.data
                              ?.questions?.length ??
                          1,
                      progressType: LinearProgressBar.progressTypeLinear,
                      currentStep: controller.currentIndex.value + 1,
                      progressColor: appColors.contentAccent,
                      backgroundColor: Colors.white,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: h * 0.75,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: h * 0.12),
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          children: [
                            Text(
                              textAlign: TextAlign.start,
                              controller
                                      .getAssessmentData
                                      .value
                                      .data
                                      ?.questions?[
                                          controller.currentIndex.value]
                                      .questionText ??
                                  "",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: AppFonts.appFonts.NunitoBold,
                                  color: appColors.contentPrimary),
                            ),
                            const SizedBox(height: 20),
                            controller
                                        .getAssessmentData
                                        .value
                                        .data
                                        ?.questions?[
                                            controller.currentIndex.value]
                                        .questionType ==
                                    "Objective"
                                ? ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: controller
                                        .getAssessmentData
                                        .value
                                        .data
                                        ?.questions?[
                                            controller.currentIndex.value]
                                        .options
                                        ?.length,
                                    itemBuilder: (context, index) {
                                      return
                                       controller.multipleSelected.value? checkButtonObjective(
                                          index,
                                          controller.selectedLists[
                                              controller.currentIndex.value],
                                          appColors.contentAccent,
                                          appColors.contentPrimary,
                                          controller
                                                  .getAssessmentData
                                                  .value
                                                  .data
                                                  ?.questions?[controller
                                                      .currentIndex.value]
                                                  .options?[index]
                                                  .optionText ??
                                              "", () {
                                        controller.addOption(index);
                                      }):radioButtonObjective(
                                        controller
                                            .getAssessmentData
                                            .value
                                            .data
                                            ?.questions?[controller
                                            .currentIndex.value]
                                            .options?[index]
                                            .optionText ?? "",
                                        controller.selectedValues[controller.currentIndex.value],
                                        appColors.contentAccent,
                                        appColors.contentPrimary,
                                        controller
                                            .getAssessmentData
                                            .value
                                            .data
                                            ?.questions?[controller
                                            .currentIndex.value]
                                            .options?[index]
                                            .optionText ?? "",
                                            () {
                                          controller.addOption(index);
                                        },
                                      );
                                    },
                                  )
                                : commonDescriptionTextField(
                                    controller.controllers[
                                        controller.currentIndex.value],
                                    controller.focusNodes[
                                        controller.currentIndex.value],
                                    w,
                                    (value) {},
                                    hint: appStrings.thousandHint,
                                    maxLines: h > 677 ? 15 : 7,
                                    minLines: h > 677 ? 6 : 2,
                                    maxLength: 1000,
                                    //inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(1000)],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    left: w * 0.05,
                    right: w * 0.05,
                    bottom: h * 0.06,
                    child: controller.currentIndex.value == 0
                        ? Align(
                            alignment: Alignment.bottomRight,
                            child: commonButtonIcon(w * 0.43, 55,
                                appColors.contentAccent, Colors.white, () {
                              (controller.getAssessmentData.value.data
                                              ?.questions?.length ??
                                          1) ==
                                      1
                                  ? controller.submit()
                                  : controller.forwardPage();
                            },
                                hint: (controller.getAssessmentData.value.data
                                                ?.questions?.length ??
                                            1) ==
                                        1
                                    ? appStrings.submit
                                    : appStrings.nextButton))
                        : (controller.currentIndex.value > 0 &&
                                (controller.currentIndex.value) <=
                                    (controller.getAssessmentData.value.data
                                                ?.questions?.length ??
                                            1) -
                                        1)
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  commonButtonIcon(w * 0.43, 55, Colors.white,
                                      appColors.contentAccent, () {
                                    controller.backPage();
                                  },
                                      hint: appStrings.previous,
                                      icon: Icons.arrow_back_ios,
                                      forward: false,
                                      borderColor: appColors.contentAccent),
                                  commonButtonIcon(
                                      w * 0.43,
                                      55,
                                      appColors.contentAccent,
                                      Colors.white, () {
                                    (controller.getAssessmentData.value.data
                                                    ?.questions?.length ??
                                                1) ==
                                            1
                                        ? controller.submit()
                                        : (controller
                                                            .getAssessmentData
                                                            .value
                                                            .data
                                                            ?.questions
                                                            ?.length ??
                                                        1) -
                                                    1 !=
                                                controller.currentIndex.value
                                            ? controller.forwardPage()
                                            : controller.submit();
                                  },
                                      hint: (controller
                                                          .getAssessmentData
                                                          .value
                                                          .data
                                                          ?.questions
                                                          ?.length ??
                                                      1) -
                                                  1 !=
                                              controller.currentIndex.value
                                          ? appStrings.nextButton
                                          : appStrings.submit)
                                ],
                              )
                            : const SizedBox()),
              ],
            ),
          ),
          progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w),
          // internetException(
          //     controller.rxRequestStatus.value == Status.ERROR &&
          //         controller.error.value.toString() == "No internet",
          //         () {}),
          // generalException(
          //     controller.rxRequestStatus.value == Status.ERROR &&
          //         controller.error.value.toString() != "No internet",
          //         () {}),
        ],
      ),
    );
  }
}
