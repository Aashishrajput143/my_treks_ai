import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:vroar/main.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';
import 'package:vroar/utils/sized_box_extension.dart';

import '../../../common/common_widgets.dart';
import '../../../common/my_utils.dart';
import '../../../data/response/status.dart';
import '../../../resources/strings.dart';
import '../../controller/roadmap_controllers/quiz_controller.dart';

class QuizScreen extends ParentWidget {
  const QuizScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    QuizController controller = Get.put(QuizController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              centerTitle: true,
              toolbarHeight: 70,
              title: Text(
                appStrings.quiz,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: appFonts.NunitoBold,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              leading: InkWell(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: appColors.contentPrimary,
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressBar(
                    maxSteps: controller.getQuizData.value.data?.quizQuestions?.length ?? 1,
                    progressType: LinearProgressBar.progressTypeLinear,
                    currentStep: controller.currentIndex.value + 1,
                    progressColor: appColors.contentAccent,
                    backgroundColor: appColors.buttonStateDisabled,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  10.kH,
                  Align(
                    alignment: Alignment.bottomRight,
                    child: RichText(
                      text: TextSpan(
                        text: "${((controller.currentIndex.value) + 1).toString().padLeft(2, '0')} ",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: appFonts.NunitoMedium,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: appColors.contentAccent,
                        ),
                        children: [
                          TextSpan(
                            text: " of  ${(controller.getQuizData.value.data?.quizQuestions?.length ?? 0).toString().padLeft(2, '0')}",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: appFonts.NunitoMedium,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                              color: appColors.buttonTextStateDisabled,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  10.kH,
                  Container(
                    height: h * 0.63,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                        border: Border.all(
                            color: appColors.buttonStateDisabled, // Border color
                            width: 5),
                        boxShadow: [BoxShadow(color: appColors.border, blurRadius: 8, spreadRadius: 2, offset: const Offset(0, 4))]),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        controller: controller.scrollController,
                        child: Column(
                          children: [
                            Text(
                              textAlign: TextAlign.start,
                              controller.getQuizData.value.data?.quizQuestions?[controller.currentIndex.value].questionText ?? "",
                              style: TextStyle(fontSize: 20, fontFamily: AppFonts.appFonts.NunitoBold, color: appColors.contentPrimary),
                            ),
                            const SizedBox(height: 20),
                            controller.getQuizData.value.data?.quizQuestions?[controller.currentIndex.value].questionType == "Objective"
                                ? ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: controller.getQuizData.value.data?.quizQuestions?[controller.currentIndex.value].options?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      // return checkButtonObjective(
                                      //     index, controller.selectedLists[controller.currentIndex.value], appColors.contentAccent, appColors.contentPrimary, controller.getQuizData.value.data?.quizQuestions?[controller.currentIndex.value].options?[index].optionText ?? "", () {
                                      //   controller.addOption(index);
                                      // });
                                      return radioButtonObjective(
                                        controller.getQuizData.value.data?.quizQuestions?[controller.currentIndex.value].options?[index].optionText ?? "",
                                        controller.selectedValues[controller.currentIndex.value],
                                        appColors.contentAccent,
                                        appColors.contentPrimary,
                                        controller.getQuizData.value.data?.quizQuestions?[controller.currentIndex.value].options?[index].optionText ?? "",
                                        () {
                                          controller.addOption(index);
                                        },
                                      );
                                    },
                                  )
                                : commonDescriptionTextField(
                                    controller.controllers[controller.currentIndex.value],
                                    controller.focusNodes[controller.currentIndex.value],
                                    w, minLines: h > 677 ? 7 : 2,
                                    (value) {},
                                    hint: controller.getQuizData.value.data?.quizQuestions?[controller.currentIndex.value].subText ?? appStrings.thousandHint,
                                    maxLines: h > 677 ? 15 : 6,
                                    maxLength: 1000,
                                    //inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(1000)],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.05),
                  if (controller.currentIndex.value == 0) ...[
                    Align(
                        alignment: Alignment.bottomRight,
                        child: commonButtonIcon(w * 0.43, 55, appColors.contentAccent, Colors.white, () {
                          controller.forwardPage();
                        }, hint: controller.currentIndex.value == ((controller.getQuizData.value.data?.quizQuestions?.length ?? 0) - 1) ? appStrings.submit : appStrings.nextButton))
                  ],
                  if ((controller.currentIndex.value > 0 && (controller.currentIndex.value) <= (controller.getQuizData.value.data?.quizQuestions?.length ?? 0) - 1)) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commonButtonIcon(w * 0.43, 55, Colors.white, appColors.contentAccent, () {
                          controller.backPage();
                        }, hint: appStrings.previous, icon: Icons.arrow_back_ios, forward: false, borderColor: appColors.contentAccent),
                        commonButtonIcon(w * 0.43, 55, appColors.contentAccent, Colors.white, () {
                          controller.forwardPage();
                        }, hint: (controller.getQuizData.value.data?.quizQuestions?.length ?? 0) - 1 != controller.currentIndex.value ? appStrings.nextButton : appStrings.submit)
                      ],
                    )
                  ],
                ],
              ),
            ),
          ),
          progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w)
        ],
      ),
    );
  }
}
